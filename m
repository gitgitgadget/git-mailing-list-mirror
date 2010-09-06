From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Mon, 6 Sep 2010 14:23:48 +0100
Message-ID: <AANLkTi=CEOj40Sj+zegvX+ry8-y6p7UwsyqdtoHB1d-T@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<alpine.LFD.2.00.1009021249510.19366@xanadu.home>
	<AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
	<alpine.LFD.2.00.1009021624170.19366@xanadu.home>
	<B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
	<7voccezr7m.fsf@alter.siamese.dyndns.org>
	<20100903183120.GA4887@thunk.org>
	<alpine.LFD.2.00.1009031522590.19366@xanadu.home>
	<AANLkTi=sC3NMNzPRQM5RKwnZQyRq-gq6+7wdiT5LGDrc@mail.gmail.com>
	<AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com>
	<4C81A67B.2060400@gmail.com>
	<alpine.LFD.2.00.1009032304560.19366@xanadu.home>
	<4C81DC34.2090800@gmail.com>
	<alpine.LFD.2.00.1009040153280.19366@xanadu.home>
	<AANLkTi=7jUSCNiPf+HfEQuxaf16Jt06--bFE7=Of9wp=@mail.gmail.com>
	<AANLkTik9awEd40s3r-O8t9DwZBh34Z0ozsxMm1QNjNoT@mail.gmail.com>
	<alpine.LFD.2.00.1009042132500.19366@xanadu.home>
	<AANLkTi=YLx6MqbWd_N0geXbuXLdqAUOneGoym75dfthL@mail.gmail.com>
	<alpine.LFD.2.00.1009051820100.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Artur Skawina <art.08.09@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 06 15:24:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsbgV-0008SL-33
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 15:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782Ab0IFNXu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 09:23:50 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36385 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491Ab0IFNXt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 09:23:49 -0400
Received: by vws3 with SMTP id 3so3296714vws.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 06:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IrhFRWWfVvEZGTjnLR9NqobwCKNQ6hrnSD1KfhTNd6U=;
        b=l+CwEt3tQz60eQKORRKJtYg1mHwMuShOi5Ag9jA1Y6213h+AW/EqBzzcYJqBzCZSPL
         DzFLeghEof4QXf+hUuNwyt49qHCNxesNHPCg6cLU0tbvRCdhJ6z/YCMguma/jgo6BL/k
         n/kUlN04tEf73GTIrI1KRlSP96SBLAx2F1//I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hY/4pmP/2NN5VF/Zp6CYIgnMffqmvHpd4J3MMDUojbVudUnWH+OMV7H2V7nkt5QSMz
         NtRIZoxoDS+rSjoyVn1xL18bjnmmJFFEsZ+JA7kRoICwyy8bjdQTc7dGZFxoOPVkZnzO
         +Zzkn/eMConpnKF7/kB6wLgwlqJHkgAgc2D1Y=
Received: by 10.220.62.72 with SMTP id w8mr878542vch.200.1283779428139; Mon,
 06 Sep 2010 06:23:48 -0700 (PDT)
Received: by 10.220.75.196 with HTTP; Mon, 6 Sep 2010 06:23:48 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1009051820100.19366@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155568>

On Mon, Sep 6, 2010 at 12:52 AM, Nicolas Pitre <nico@fluxnic.net> wrote=
:

>> another branch (which is the situation that, i believe, happens with
>> "git pull" over http:// or git://); ignoring the fact that i actuall=
y
>> implemented using the .idx file yesterday ... :)
>
> Please, let's get it slow.

 ack :)

> There are 2 concepts you really need to master in order to come up wi=
th
> a solution. =C2=A0And those concepts are completely independent from
> each other, but at the moment you are blending them up together and
> that's not good.

 i kinda get it - but i realise that's not good enough: i need to be
able to _say_ i get it, in a way that satisfies you.

> The first one is all about object enumeration. =C2=A0And object enume=
ration
> is all about 'git rev-list'. =C2=A0This is important when offering ob=
jects to
> the outside world that you actually do offer _all_ the needed objects=
,
> but _only_ the needed objects. =C2=A0If some objects are missing you =
get a
> broken repository. =C2=A0But more objects can also be a security prob=
lem as
> those extra objects may contain confidential data that you never
> intended to publish.

 ack.

> And object enumeration has absolutely nothing to do with packs, nor .=
idx
> files for that matter.

 mmm packs not being to do with object enumeration i get.  i
understand that .idx files contain "lists of objects" which isn't the
same thing (and also happen to contain pointers/offsets to the objects
of its associated .pack)

 at some point i'd really like to know what the object list is (not
the objects themselves) that comes out of "git pack-objects --thin"
but my curiosity can wait.

>=C2=A0As I said, the objects you want might be split
> across multiple packs, and also in loose form, and also in some
> alternate location that is shared amongst many repositories on the sa=
me
> filesystem.

 ok - this tells me (and it's confirmed, below) that you're describing
the situation based on what can be found in .git - _not_ what comes
out of "git pack-objects".  i wouldn't _dream_ of digging around in a
=2Egit/ location looking for packs or idx files, but because i have
mentioned them _without_ prefixing every mention with "the
custom-generated .idx and/or .pack as generated by git pack-objects",
you may have got the wrong impression, for which i apologise.

> =C2=A0But a single pack may also contain more than what you want
> to offer, and it is extremely important that you do _not_ offer those
> objects that are not reachable from the branch you want to publish.
>
> Following me so far?

 yep :)

> The second concept is all about object _representation_ or _encoding_=
=2E
> That's where the deltas come into play. =C2=A0So the idea is to grab =
the list
> of objects you want to publish, and then look into existing packs to =
see
> if you could find them in delta form. =C2=A0So, for each object, if y=
ou do
> find them in delta form, and the objec the delta is made against is 1=
)
> also part of the list of objects you want to send, or 2) is already
> available at the remote end, then you may simply reuse that delta dat=
a
> as is from the pack. =C2=A0Finding if a particular pack has the wante=
d object
> is easy: you just need to look it up in the .idx file. =C2=A0Then, in=
 the
> corresponding pack file you parse the object header to find out if it=
 is
> a delta, and what its base object is.

 ok.  all of this makes sense - but it's enough for me to be able to
ask questions, rather than "do", if you know what i mean.

>> =C2=A0... there is a bit of a disadvantage to using pack index files=
 that
>> it goes all the way down (if i am reading things correctly) and cann=
ot
>> be told "give me just the objects related to a particular commit"...=
=2E
>
> Exact. =C2=A0The .idx file gives you a list of objects that exists in=
 the
> corresponding pack. =C2=A0That list of object might belong to a total=
ly
> random number of random commits. =C2=A0You may also have a random num=
ber of
> packs across which some or all objects are distributed. =C2=A0Because=
, of
> course, not all the objects you need are always packed.
>
> So... I hope you understand now that there is no relation between
> commits and .idx files. =C2=A0The only exception is when you do creat=
e a
> custom pack with 'git pack-objects'.

 yes.  ahh... that's what i've been doing: using "git pack-objects
--thin".  and the reason for that is because i've seen it used in the
http implementation of "git fetch".

 so, my questions up until now regarding .pack and .idx have all been
targetted at that, and based on that context, _not_ the packs+idx
files that are in .git/

>> > Try this instead:
>> >
>> > =C2=A0 =C2=A0git rev-list --objects HEAD | cut -c -40 | sort
>> >
>> > That will give you a sorted list of all objects reachable from the
>> > current branch. =C2=A0With the Linux repo, you may replace "HEAD" =
with
>> > "v2.6.34..v2.6.35" if you wish, and that would give you the list o=
f the
>> > new objects that were introduced between v2.6.34 and v2.6.35.
>>
>> =C2=A0... unlike this, which is in fact much more along the lines of=
 what i
>> was looking for (minus the loveliness of the delta compression oh
>> well)
>
> Again, delta compression is a _separate_ issue.
>
>> >=C2=A0This will
>> > provide you with 84642 objects instead of the 1.7 million objects =
that
>> > the Linux repo contains (easier when testing stuff).
>>
>> =C2=A0hurrah! :) =C2=A0[but, then if you actually want to go back an=
d get alll
>> commits, that's ... well, we'll not worry about that too much, given
>> the benefits of being able to get smaller chunks.]
>
> If you want all commits then you just need --all instead of HEAD.

 no, i want commits separated and individual and "compoundable".  the p=
lan is:

* to get the ref associated with refs/heads/master
* to get the list of all commits associated with that master ref
* to work out how far local deviates from remote along that list of com=
mits
* to get the objects which will make up the missing commits (if they
aren't already in the local store)
* to apply those commits in the correct order

in other words, the plan is to follow what git http fetch and/org git
git:// fetch does as much as possible (ok, perhaps not).

the reason for getting the objects individually (blobs etc.) should be
clear: prior commits _could_ have resulted in that exact object having
been obtained already.

so far i have implemented:

* get the master ref using git for-each-ref
* get the list of all commits using git rev-list
* enumerate the list of objects associated with an individual commit by=
:
    i) creating a CUSTOM pack+idx using git pack-objects {ref}
    ii) *parsing* the idx file using gitdb's FileIndex to get the list
of objects
    iii) transferring that list to the local machine
* requesting *individual* objects from the enumerated list out of the i=
dx file
   by using a CUSTOM "git pack-objects --thin {ref} < {ref}" command

that's as far as i've got, before you mentioned that it would be
better to use "git rev-list --objects commit1..commit2" and to use
"git cat-file" to obtain the actual object [what's not clear in this
plan is how to store that cat'ed file at the local end, hence the
continued use of git pack-objects --thin {ref} < {ref}]

the prior implementation was to treat the custom pack-object as if it
was "the atomic leaf-node operation" instead of individual objects
(blobs, trees).

>> > That sorted list of objects is more or less what the pack index fi=
le
>> > contains, plus an offset in the pack for each entry. =C2=A0It is u=
sed to
>> > quickly find the offset for a given object in the corresponding pa=
ck
>> > file, and the fanout is only a way to cut 3 iterations in the bina=
ry
>> > search.
>> >
>> > But anyway, what you want is really to select the precise set of o=
bjects
>> > you wish to share, and not blindly using the pack index file. =C2=A0=
If you
>> > have a public branch and a private branch in your repository, then
>> > objects from both branches may end up in the same pack
>>
>> =C2=A0slightly confused: are you of the belief that i intend to igno=
re
>> refs/branches/* starting points?
>
> I don't know what your exact understanding of Git is, and although I
> know one or two things about the Git storage model, I get confused
> myself by some of your comments, such as this one above.

 soorree.  i believe the source of the confusion is that you believed
that i intend to "blindly use a pack index file" as in "blindly go
rummaging around in .git/ at the remote end" when i have absolutely no
intention of doing so.

 what i _have_ been doing however is custom-generating pack-objects
and associated pack-indexes (just like git http fetch) _including_
using the --thin option because that's what git http fetch does.

 i believe that this results in the concerns that you raised (about
having access to unauthorised data) being dealt with.

>> > don't want to publish those objects from the private branch.
>>
>> =C2=A0ahh, i wondered where i'd seen the bit about "confusing" two
>> branches, i thought it was in another message. =C2=A0so many flying =
back &
>> forth :) =C2=A0from what i can gather, this is exactly what happens =
with
>> git fetch from http:// or git:// so what's the big deal about that?
>> why stop gitp2p from benefitting from the extra compression that cou=
ld
>> result from "borrowing" bits of another branch's objects, neh?
>
> No. =C2=A0git:// will _never_ ever transfer any object that is not pa=
rt of
> the published branch(es).

 ... because it uses, from what i can gather, git pack-objects --thin

>=C2=A0If an object that does get transmitted is
> actually a delta against an object that is only part of a branch that=
 is
> not published, then the delta will be expanded and redone against
> another suitable object before transmission.

 and that's handled by git pack-objects --thin (am i right?)

 ok.

 so.  we have a hierarchical plan: get the commit list, get a
per-commit object-list, get the objects (if needed), store the
objects.

 problem: despite looking through virtually every single builtin/*.c
file which uses write_sha1_file (which i believe i have correctly
identified, from examining git unpack-objects, as being the function
which stores actual objects, including their type), i do not see a git
command (yet) which performs the reverse operation of "git cat-file".

builtin/apply.c - that's for patches
builtin/checkout.c - that's for the merge result.
builtin/notes.c - creating a note
builtin/tag.c - creating a tag
builtin/mktree.c - creating a tree object but *only* from a text listin=
g

ok - maybe this is one of the ones that i need, but only if i use "git
cat-file -p" to pretty-print the output of tree objects but i don't
think that's a good idea.

what else...

cache_tree.c - nope.
commit.c - nope.
read-cache.c - beh? nope.  has blank args "", 0

so... um... unless i actually manually create a pack object (perhaps
using python-gitdb to construct it) out of the data obtained by "git
cat-file" i don't see how this would work.

l.
