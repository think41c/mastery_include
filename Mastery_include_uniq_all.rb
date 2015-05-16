# include? - This method returns true/false if a collection contains an element specified in the parameter. 
# include? exists for an Array, a String, a Hash, a Range, and as an enumerable. With each method it has slightly different characteristics. 
# has_key? - this is an alaised method of include? that's used exclusively with Hashes.

# Simply takes an array/collection, and parameters have somewhat of a block characteristic. You can add in boolean conditionals as well  
a = [ "a", "b", "c" ]
p a.include?("b")   #=> true
p a.include?("z")   #=> false
puts a.include?("b" || "a")  # True 
puts a.include?("b" && "z")  # False
puts "***"
puts "hello".include?(?h)    # True. The ? syntax is only for the String class. The question mark checks for a single letter after it
puts [a].include?(?a)        # False. The ? syntax does NOT work for a array. The ?x syntax is from an old version of Ruby that used to 
							 # spit out the ASCII code for the character. This syntax is basically slowly being deprecated. 
# Also include will NOT inspect each element of an array and then inside of the that element. It WILL look inside of a string though.
arrayz = ["abcd", 4053, 55]
puts "\n"
puts arrayz.include?(4053 && 55)          # True.  Giving individual numbers/strings with a conditional is fine. 
puts arrayz.include?([4053,55])           # False. Giving an array as a parameter just returns false. DONT USE AN ARRAY AS A PARAM!
puts arrayz.include?(["abcd", 4053, 55])  # False. Doesn't matter if you check the whole array or not. 
puts arrayz.include?("b")                 # False.
a_string = "california"
puts a_string.include?("for")             # True  - Include can look inside a string to find a piece of the string. 
a_array  = ["california"]     
puts a_array.include?("for")              # False - can't look inside of an element in an array, even if it's a string.
puts arrayz.include?(05)     	          # False 
puts arrayz.include?(4053)                # True
puts arrayz.include?("abcd" && 4053)      # True
puts arrayz.include?("abcd" && 4000)      # False
puts arrayz.include?(if arrayz[0].length == 4 then end)  # False. Conditional statements like this aren't allowed.

# Example of using the true/false return value for a case statement. 
ruby_is_on = "RAILS"
case
  when ruby_is_on.include?("AI")   # True
    puts "Hello"
end

# puts arrayz.include?()  # Error. Wrong number of arguments.

# What if you wanted to only find the complete string as opposed to a chunk? 
puts a_array.to_s.include?("for")   # True. This turns the array into a string, which will allow include to look at a piece of the string.
puts a_array.include?("for")        # False. 

# If you wanted to take a single string and check include for an exact/full match, you'd need to get the string into an array format first.
# Since to_a doesn't exist for a String, we'll have to do a few things: 
zzz = []         # A new array instantiation. 
zzz << a_string  # Put in the string into the array 
puts zzz.include?("for")  # False. Now include is looking for the entire element to be an exact match since the original string is now in an array.

# include? can also be used for Hashes. Rememebr has_key? is the aliased method here. include? will ONLY check the keys, and NOT the values.

puts hash_brown = {:candy => "30", :donut => "20"}
puts hash_brown.include?(:candy)  # True. This is because has_key? is an alaised method of include? for Hashes.
puts hash_brown.include?(30)      # False. The hash has 30 as a String. I'm looking to see if a Fixnum is included. Doesn't matter.
puts hash_brown.include?("30")    # False. Hash has 30 as a String. Looking for a string. Doesn't matter - include? only looks at keys.

# Using Ranges with include? 
("a".."z").include?("g")   # true
("a".."z").include?("A")   # false
("a".."z").include?("cc")  # false
puts (1..6).include?(3)    # True 

######
# Quiz: Is the parameter in include optional?
# No. "Wrong number of arguments, 0 for 1"
# 
# Can the include inspect each element to see if there are pieces of a number/string that match the parameter? 
# No. It matches the parameter with the entire value of the current element it's looking at.
# 
# Is .include? the same as include?
# No. include is a reserved keyword for Ruby. .include? is a built in method.
#
# If you want to check to see if the word "police" has the word "ice" in it, does police need to be a string held outside or inside of an array? 
# Outside.
#
# You have an array and want to see if one of the elements is equal to "h". Does the (?h) parameter work?
# No. That only works for a String.
###############################

################# any? #######################################################################################
# any? is a great method to use with .include?. any? is available as an enumerable as well as for the Array / Hash / Range. class but NOT a String.
# While Range#any? isn't mentioned in the RubyDoc, it clearly works. 
#
# It passes each element of the collection to the given block. The method returns true if the block ever returns a value 
# other than false or nil. If the block is not given, Ruby adds an implicit block of { |obj| obj } that will cause any? to return 
# true if at least one of the collection members is not false or nil. 
# Using any? without a block is likely to be used for looking at a collection of booleans, to try to see if any element is true.
# Using any? with    a block is likely to be used to "create" those falses for each element, meaning you're providing a conditional statement.
#
#### any? used with an Array

%w[ant bear cat].any? { |word| word.length >= 3 } #=> true
%w[ant bear cat].any? { |word| word.length >= 4 } #=> true
puts %w[ant bear cat].any? { |x| x.length >= 5}   # False 
puts [nil, true, 99].any?                         # True. Even though there's a nil in here, one of the things is not nil. 
puts [nil, true, 99].any? { |x| x }               # True. Equivalent to the previous line. 
puts [nil, 5].any?                                # True. 

puts [10, 20, 30].any? {|x| 	 # True
	puts x                       # This puts 10. The next iteration seems to be skipped since it returns 'true' from 200 > 30 returning true.
	x * 10 > 30
	}
puts [50,50].any? {|x| nil}      # Returns false, since every evaluation returns nil. This is a stupid/broken usage of the method.

puts "yay" if [1, 2, 3].all? { |i| (1..9).include?(i) }             # => "yay"
puts "nope" if [1, 2, 3, 'A'].any? { |i| not (1..9).include?(i) }   # => "nope"

#### any? used with a Range

puts (2..50).any? {|x| x%2==0}    # True 
puts (2..50).any? {|x| x%2==51}   # False 

#### any? used with a Hash
# An empty array is false, and an empty Hash is nil. And therefore returns false. 
puts [].any?   # False 
hashy = {:band => 10, :cat => 30}
puts "Into Hashes"
puts hashy.any?    # True.
empty_hash = {}    
puts empty_hash.any? # False. However, if you try to put in an empty hash in the same expression, as opposed to assigning it a variable, it will error:
# puts {}.any? # False - error, the empty hash is nil. 
puts "b"
h = {:a => 1, :c => 3, :d => 4}
puts [:a, :b, :e].any? {|k| h.key?(k)}  # True. Says :a,:b,:c is any true for looking at a: as the key? ":a" in the 'h' hash? Yes. True.
puts [:e, :f].any? {|k| h.key?(k)}      # False.Says :e,:f is any true for looking at :e and :f being the key? in the 'h' has? No. False.
# Syntax is [array].any? {|x| hash_name.key?(x)} 

h = {:a => 1}
puts [:x, :a].any? {|k| h.key?(k)}      # True. 
puts [:x, :z].any? {|k| h.key?(k)}      # False. It looks at :x and :z and says is there any key in the h hash that matches that. No. 
puts [:x, :a].any? {|x| h.value?(1)}    # True. This looks as the values of the h hash only. The array coming into the .any? method doesn't matter!
puts [:v, :x].any? {|p| h.value?(1)}    # True. Even with the keys as something different from the hash, it doesn't matter since it never looks at it.
puts [:x, :a].any? {|x| h.value?(2)}    # False

# If you didn't use .any?, you'd have an ineligant solution like: 
h.key?(:a) || h.key?(:b) || h.key?(:e)

myhash = {:x => 3, :y => 5}
puts myhash.any? {|x| myhash.key?(:x)}   # True. (if it was NOT x or y, then it'd be false). What about not having a hash stored in a variable?
{:x => 3, :y => 5}.any? { |key, value| key == :y}  # When invoking any? on a hash, it returns the key/value pair as an array. Therefore key? wont work.

#################### all? ##############################
# .all? exists for the enumerable class. It's not mentioned in the docs for hash or array. The method returns true it if NEVER gets back false/nil 
# after passing through EVERY element in a collection. Similar to any?, there is an implicit block given of { |x| x } if one is not explicitly given.
#
puts %w[ant bear cat].all? { |word| word.length >= 3 } # true
puts %w[ant bear cat].all? { |word| word.length >= 4 } # false
puts  [nil, true, 99].all?                             # false

puts "yay" if [1, 2, 3].all? { |i| (1..9).include?(i) } # yay / true. 

######################### any vs all #######################################
#
# The method returns true if the block never returns false or nil.
# So since the block never gets called, of course it never returns false or nil, thus all returns true.
# 
# The same goes for any? 
# 
# The method returns true if the block ever returns a value other than false or nil.
# Since the block never gets called, it never returns a value other than false or nil, thus any returns false.

# [:a, :b, :c, :d].all? {|s| hash.key? s}   # Using .all with a Hash.

# .all? and include? - Search for elements in array "a" are all included in array "b". 

a = ["hello", "welcome"]
b = ["hello", "goodbye", "orange"]
(a - b).empty? # => false    # also can use empty?
a.all?{|i| b.include? i }

#


[nil, "car", "bus"].all? # False
[nil, "car", "bus"].any? # True

["nil", "car", "bus"].any? # True 
["nil", "car", "bus"].all? # True 

[].all? # True
[].any? # False

puts [nil].any? # False
puts [nil].all? # False