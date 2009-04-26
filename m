From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [doc] User Manual Suggestion
Date: Mon, 27 Apr 2009 00:25:32 +0200
Message-ID: <20090426222532.GA12338@atjola.homenet>
References: <alpine.LNX.2.00.0904241852500.2147@iabervon.org> <b4087cc50904241626h166c6b3bqa4ec714d4cb5662a@mail.gmail.com> <alpine.LNX.2.00.0904251445030.2147@iabervon.org> <b4087cc50904251216p617e347bmdc70e109298fa9b2@mail.gmail.com> <94a0d4530904251224g6b228448q276436f17f7e5cc3@mail.gmail.com> <E85677CA-FA7E-4777-97DF-9B295E89B83A@boostpro.com> <20090426112802.GC10155@atjola.homenet> <FA5C0FFA-2DCD-4DF1-9A94-C2A26A9DCAE9@boostpro.com> <20090426175613.GA4942@atjola.homenet> <F2B2D447-57B4-459C-8A0D-A94C12AE791C@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Witten <mfwitten@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 13:10:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyCpP-0001kS-R4
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 00:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbZDZWZu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2009 18:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbZDZWZt
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 18:25:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:54004 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750920AbZDZWZs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 18:25:48 -0400
Received: (qmail invoked by alias); 26 Apr 2009 22:25:45 -0000
Received: from i59F5A916.versanet.de (EHLO atjola.local) [89.245.169.22]
  by mail.gmx.net (mp010) with SMTP; 27 Apr 2009 00:25:45 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX198i7hYHDl8W1aB2mhK1ACyKTwmIoBAWIfp78YF4O
	CGbAgyOgBQYRgC
Content-Disposition: inline
In-Reply-To: <F2B2D447-57B4-459C-8A0D-A94C12AE791C@boostpro.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117657>

On 2009.04.26 16:17:43 -0400, David Abrahams wrote:
>
> On Apr 26, 2009, at 1:56 PM, Bj=F6rn Steinbrink wrote:
>
>> On 2009.04.26 09:55:34 -0400, David Abrahams wrote:
>>>
>>> On Apr 26, 2009, at 7:28 AM, Bj=F6rn Steinbrink wrote:
>>>
>>>> On 2009.04.25 15:36:24 -0400, David Abrahams wrote:
>>>>> Where it's relevant when the user notices that two distinct files
>>>>> have the same id (because they happen to have the same contents)
>>>>> and wonders what's up.
>>>>
>>>> Why would the user have to care about the object files in the repo=
?
>>>
>>> What a strange question. I have no idea how to answer. It seems
>>> self- evident to me that users of a VCS care that their files are
>>> stored in it.
>>
>> _Their_ files. The files that come from/end up in the working tree. =
I
>> cared about those when I used SVN, too. But I never went to the SVN
>> repo to find out if there are two equal files in it. We're talking
>> about object names, and those belong to objects, not files in the
>> working tree.
>
> I'm telling you, many new users who aren't already versed in Git will
> naturally associate the SHA1 codes exposed by the interface with the
> files they've checked in without understand that they actually
> identify object files (another poorly chosen Git name, if I've manage
> to deduce what it means)

Hm, not sure if that name is really important. The way objects are
stored is an implementation detail. Usually, we're just talking about
"objects" not the files the loose objects are stored in (loose object =3D
an object stored in its own file, not in a pack file). But as you
complained about it, how would you call a file in which an object is
stored?

> rather than directly corresponding to states
> of their files. And anyway, if you want to get into implementation
> details, SHA1s don't always identify object files because blobs get
> delta-compressed.

True, they identify the object, it's not even necessesary to mention
delta compression, just having the object in a pack file causes the
object name to no longer identify the file in which the object can be
found. Heck, the object might be in a different repo when you use
alternates ;-). And I think I never explicitly said that they
identify a file storing an object, but implied that by "accepting" your
example and assuming that you meant two object files having the same id=
=2E
I should have said that your "two distinct files have the same id" make=
s
no sense and should have asked what you mean.

>>>> And why would your implementation save the same object twice, in
>>>> two distinct files?
>>>
>>> One could easily have the expectation that contents can be
>>> duplicated because there are numerous precedents in everyone's
>>> experience of computing, for example in filesystems and in any
>>> programming language that is not pure-functional.
>>
>> That's not answering my question. I asked why you come up with an
>> implementation that is "broken" enough to save the same object twice
>> with different file names.
>
> I don't know what you mean by "come up with an implementation."  I'm
> not inventing an implementation.

Sorry, "come up with" is clearly wrong. "Assume" or "expect" or so migh=
t
have been more correct. But I think we could agree that you misused the
"id" term by using it for files, and what ensued confused both of us? I=
f
you didn't mean the stored objects by "files", then that part of the
discussion was just based on a misunderstanding and can be ignored.

> I'm saying, new users inevitably and inexorably develop a mental mode=
l
> of the system they're learning about, and they don't always develop
> the right mental model, and I'm saying that it's easy to see how they
> can fall into incorrect assumptions.  The word "hash" helps a bit wit=
h
> avoiding one of those assumptions.

I've not met a lot of people that were actually confused about the fact
that the same object might be "reused" for tree entries with different
names. But most (all?) of those that were confused knew that the object=
s
are identified by hashes, but expected the filenames to be part of the
object and didn't know about tree objects.

>> If the implementation does not do that, your "when the user notices
>> that two distinct files has the same id" is immediately invalid. The
>> user cannot come into that situation then.
>
> I think this is why Git remains more opaque than it should be.  You
> can't assume that people will naturally develop the smartest possible
> mental model of a VCS, even with faced with some hints in the form of
> a partial understanding of Git.

I don't think I understand what you mean here. If users don't understan=
d
the data model, that's caused by missing/bad documentation or because
the user doesn't want to read the existing documentation. (I'll make no
assumptions here, it's been some time since I had a close look at the
docs). But I've been talking about how the given implementation stores
data in the repository. Could you explain?

>> And anyway, when the user notices something, that's a discovery, not
>> an expectation.
>
> It's better to give people something to connect their discoveries to
> (e.g. "oh, I see, they call those things hashes, so it makes sense
> that these two identical things are stored once")

We're talking about seeing, for example,  the same object name more tha=
n
once, for different "files", in e.g. gitweb, right? Then the "Hu? Isn't
the filename part of the object?" thing might still apply. The user can
still very easily make a wrong guess.

As Michael said in another mail, the important point is probably rather
to teach people to make a distinction between files and directories in
the working tree and the contents stored in the git objects. And that's
not accomplished by saying that the id is a hash, when the user doesn't
know what the hash is based upon.

Somewhat related: I'm trying to remember if I ever had problems
explaining the concept of hardlinks to someone, but I don't remember an=
y
such situation anymore. There are no hashes involved there, and I feel
like that was quite easy to grasp for most people I talked to. It's
pretty similar, separating content from names.

>>>> The SHA-1 hash is created from the object, that means the its type=
,
>>>> size and data. It's not an id of a file in the working tree, but o=
f
>>>> an object
>>>
>>> All true.  All somewhat subtle distinctions that are not nearly as
>>> apparent unless you actually use the word "hash" as I have been
>>> advocating.
>>
>> Hu? How does saying "object hash" instead of "object id" make it any
>> more apparent that a file in the working tree is something else than
>> a git object?
>
> It makes it apparent that two identical things can only have one ID,
> and thus must correspond to one object.

See above, the user needs to know "what" is identical in the first
place.

>>>> You can't have two objects with the same contents to begin with,
>>>> same content =3D> same object.
>>>
>>> In the Git world, I agree.  In general, I disagree.
>>
>> I don't think were discussing a term to describe something that
>> identifies an object in general. So, "in general" you can disagree a=
s
>> much as you want, but for git that doesn't matter at all.
>
> You don't think the general rules of the computing world and existing
> meanings of terms have an impact on a new user's ability to grok Git?
> If not, we don't have much to discuss.

This was probably also based on the files+id misunderstanding combined
with the fact that you used the term "object" where I thought that you
meant a "git object" (you probably didn't, right?). Because when talkin=
g
about "git objects" you actually can't have two different ones with the
same "value" (I guess you mean type, size and content when you say
"value", right?)

And admittedly, for this one, the "hash" term _would_ help to get the
user to understand that in git you cannot have two different objects
with the same contents and that this makes git different and efficient.
But I still don't buy that this is important for understanding the basi=
c
data model. It's a nice hint why git can always quickly tell that two
things are equal and why the repository size doesn't explode. But the
important part is the separation of names and content, that trees give
names to the contents stored in blobs. The "hash" name would only help
to understand its efficiency once you already understood the data model=
=2E
See below.

>>> The fact that is so in the Git world is reinforced by the notion
>>> that the id of an object is a hash of its contents.
>>>
>>>> You can just have that one object stored multiple times in
>>>> different places (for sane implementations this  likely means that
>>>> you have more than one repo to look at, and each has its  own copy
>>>> of that object, but that's nothing you as an user should have to
>>>> care  about).
>>>
>>>> It's an identity relation: same name/id =3D> same object. Unlike
>>>> e.g. a hash-table where you are expected to deal with collisions,
>>>> and  having the same hash doesn't mean that you have identical
>>>> data.  But that's not true of git, it expects an identity relation=
,
>>>> which is IMHO better expressed through "object name" or "object
>>>> id".
>>>
>>> Yes, that's true in the Git world (though not necessarily
>>> elsewhere), or at least you hope it is.  In fact, there's no
>>> guarantee that SHA1 collisions won't occur; it's just exremely
>>> unlikely.  In fact, if you google it you can find some interesting
>>> papers about SHA1 collision.
>>
>> Sure, it's an assumption that has been made and is required to hold
>> true for git to work.
>>
>>> Another way to express what you wrote above:
>>>
>>>   same same id =3D> same hash ?=3D> same contents =3D> same object
>>>
>>> where ?=3D> means "almost certainly implies."
>>
>> No, that chain shows how git could be "unreliable" when you get hash
>> collisions. You could put that into a chapter that explains the
>> implications of the way git generates its object ids. But it's not
>> very interesting when you use git and (implicitly) trust the
>> assumption  that no collisions happen.
>
> My point in mentioning that it's not certain was to point out that yo=
u
> left out the implication that actually /is/ certain, even across
> repos.

And my point is that this is not important for understanding the basic
data model, but only how git efficiently implements it, and which
assumptions it has to make.

>> Only when you want to explain how git manages to avoid duplicated
>> storage of fully identical contents, then you need to mention that
>> the object names are the hashes of the full object contents. But
>> that's  not what you actually use the object names for.
>>
>> same content =3D=3D> same content hash =3D=3D> object name/id =3D=3D=
> same object
>>
>> (Actually, you need an additional detail: "same
>> file/symlink/directory/... contents =3D=3D> same object contents", w=
hich
>> can't be made explicit by just saying that you use a hash).
>>
>> Your chain was in the wrong order
>
> If you think there's a right order, you haven't understood that all
> the arrows are bidirectional.

There's one that is not truly bidirectional.

id <=3D> hash <?=3D> contents <=3D> object

I can't go from id/hash to contents/object without hitting the "hash =3D=
>
content" assumption. I had two chains for a reason.

	id =3D> object =3D> content =3D> hash
and
	content =3D> hash =3D> id =3D> object

are guaranteed, at least within a single repo.

While:
	content =3D> hash =3D> id =3D> object ?=3D> content

has a non-guaranteed part again, just an assumption, at least when the
first and last "content" mean the same content. If you get a collision,
you rather have a guarantee that one version of the content is "not in
the repo".

And as I said, that fact, that the identifier is not globally unique,
along with the fact that git cannot have two different objects with the
same contents or name is not required to understand how commits, tree
and blobs go together to store the history of a project. It's IM(NS?)HO
far more important to understand the separation of names and content.
Then you can understand that multiple names can be associated with the
same object holding some content (which can be done with other kinds of
ids as well, even with more than one object having the same contents,
just not necessarily as efficiently). And that objects have a name that
is used to identify the object. And only then can you understand and
appreciate how hashes help to efficiently implement that model, knowing
which data is used to calculate the hash.

>> and explains neither the "a tree that has the same object name/id fo=
r
>> two entries" case (because of the uncertainity of the "same hash ?=3D=
>
>> same content" part), nor, when read in the other direction, where al=
l
>> implications are true, why same content leads to the same object (as
>> it already starts at the object level).
>
>>> I think the implication is important in both directions.  Neither
>>> one is self-evident to a new user.  Maybe the right answer is 'hash
>>> id'.
>>
>> git could work different. Just moving the storage of the filenames
>> from the tree objects to the blobs would mean that you'd get
>> different objects for files that have the same content but different
>> names.  You'd still have a hash of the object contents as the object
>> name, but suddenly you get more objects. Just saying "hash" or "hash
>> id" doesn't magically explain all the other things.
>
> But that's a strawman.  I'm not claiming that it magically explains
> all the other things.  I'm just claiming that it helps in avoiding
> some possible misunderstandings.

And I think that it doesn't help much at all and might confuse users,
because they expect the hash to be based on the wrong stuff. It's just
important that the "thing" is used to identify an object.

Bj=F6rn
