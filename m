From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Thu, 22 Jul 2010 15:41:52 -0400
Message-ID: <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 
	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 
	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 
	<m31vavn8la.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 21:42:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc1eu-0007fc-OX
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 21:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742Ab0GVTmP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jul 2010 15:42:15 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39387 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab0GVTmO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jul 2010 15:42:14 -0400
Received: by wwj40 with SMTP id 40so3848439wwj.1
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 12:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=weh+MRUpX/Q7iMKxegEs0OjbXHYOAP9heVTKRh9ZVqY=;
        b=UFfKELi3EOwI99bS+GBrQSLI+PVF984rajSWgzrBEVRH9d5vYznQkaBgPTPMxM19Hn
         US5rrrSWKnGeQ/CRfh4/WggCDOCTEuj1zPnBT3wnMFawJp8AlXCiPDPd15OkxvkB4NMD
         visDnLja352OrQkiC6fc6PjjX+Yz5bclF/O/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=l4BTinpI4EaaY1d9Ymz5ffvt6bT/+3ZmJubF/6LOQ5aCj3g+lc132ChnbJN+YOoAzI
         eWj9H+/DZJxvzhUoYDNkGkEGwf1lbJMflDJ22xS0Qw/b1vaerFUFTZWDzrOiSsgpwSwR
         LlYB6RAXGM5TuPr3yPxQ6ArGX2HRI0BpXNgV8=
Received: by 10.216.179.140 with SMTP id h12mr2354120wem.39.1279827732309; 
	Thu, 22 Jul 2010 12:42:12 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Thu, 22 Jul 2010 12:41:52 -0700 (PDT)
In-Reply-To: <m31vavn8la.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151473>

On Thu, Jul 22, 2010 at 5:57 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Avery Pennarun <apenwarr@gmail.com> writes:
>> The tree object of the parent points at 'commit xxxx'. =A0But everyt=
hing
>> in git has been *specially modified* to *just ignore* that 'commit
>> xxxx'. =A0It would have given exactly the same functionality - and m=
uch
>> less confusingly - if .gitmodules would just include the desired
>> commitid of the child project. =A0You could still have the same 'git
>> submodule' command with the same syntax and semantics. =A0And it
>> wouldn't have bastardized the git repo format.
>
> Actually the prototype implementation by Martin Waitz worked in such =
way,
> i.e. with special file in top directory holding SHA-1 of submodule co=
mmits,
> what you can read on https://git.wiki.kernel.org/index.php/Subproject=
Support
> page.
>
> The low level plumbing with 'commit' entries in the 'tree' object was
> created by Linus Torvalds (CC-ed). =A0I don't remember discussion abo=
ut why
> this solution was chosen, though. =A0But please read about difference=
s between
> git-subtree and git-submodule below.

I actually think Linus's contribution - the particular change to the
repo format to have trees link to commits - was exactly right.  If we
want to talk about failings of git-subtree, they all precisely come
down to the fact that, because it has tree->tree links instead of
tree->commit links, it has to stash commitid information in the commit
message, which is gross and error prone.

git-subtree would have benefitted from tree->commit links, but because
git's implementation of them is broken, that wasn't an option.

Unfortunately everything built *on top of* Linus's file format
contribution has turned out to be a disaster.  Actually making the
subprojects have their own local .git repositories was a disaster, for
exactly the same reasons that having every subdir in svn have its own
=2Esvn directory (or in cvs, every directory has its own CVS directory)
is a disaster.  When you split things up that way, you can't easily do
global atomic operations across the entire set of content.  And you
can accidentally have a subdir pointing at a totally different place
than the parent thinks it is.  And you have CVS/.svn/.git directories
cluttering stuff up everywhere.

The tree->commit links do not preclude you doing wonderful global
atomic operations across the entire set of content.  The separate
repository garbage absolutely does.

>> To wit:
>>
>> - cloning a local supermodule on my local machine to another copy:
>> every call to 'git submodule update' re-downloads submodule repos fr=
om
>> the remote machine, because the submodule path is hardcoded to point
>> at a remote machine.
>
> Errrr... the URL to submodule repository (I guess it is what you mean=
t here
> by "submodule path") in the config file overrides URL to submodule
> repository in '.gitmodules' for a reason. =A0So the plumbing support =
is here,
> it is only failing of an UI that we don't have '--recursive-local' or
> '--convert-submodules' (like '--convert-links' in wget) in "git clone=
".

Let me be more specific.

I create an app named myapp on github:

   git://github.com/apenwarr/myapp

It uses 17 different ruby gems, which I import as subprojects.  I have
two choices:

[1] .gitmodules can use absolute paths to the original gem locations:

   git://github.com/rubygems/gem[1..n]

[2] Or else I can fork them all and use relative paths in .gitmodules:

   ../gem[1..n]
   translates to --> git://github.com/apenwarr/gem[1..n]

At this phase, both options are okay (though option #2 is obviously
much more work).  My next step will be to clone myapp onto my local
machine:

   git clone --recursive git://github.com/apenwarr/myapp

And it will grab all the submodules just fine.

Now let's say I want to change gem13.  If I used option #1, I have to
now go fork gem13 on github.  Then do one of the following:

[1A] Re-point my .git/config file to point at the new submodule
location, git://github.com/apenwarr/gem13 but leave .gitmodules alone

[1B] or update both .git/config and .gitmodules

If I do #1A, then when I push my changes, the *next* guy who clones
git://github.com/apenwarr/myapp will fail; the gem13 link in myapp
points at a commit that is *only* in apenwarr/gem13, not
rubygems/gem13.

If I do #1B, then if someone else does something similar in their own
copy and pulls from me, we will have a conflict in .gitmodules.

In both cases, if two people need to patch gem13 during their changes
to myapp, merges will fail because there is no submodule-recursive
merge (and trying to write one would be incredibly hard since it would
have to communicate across sub-repositories).

So if you do #1, then I don't know of any options other than #1A and
#1B, and neither one works.

Now, if I had done #2 instead, things are a little better, because
we're using relative paths in .gitmodules so when the second guy
clones a copy of myapp, he can also clone a copy of all 17 gems, and
all the paths will still work.

When the second guy does 'git pull apenwarr myapp' it will still fail,
though; it will try to get the latest gem13 from ../gem13 -->
secondguy/gem13, when actually the required commits are in
apenwarr/gem13.

=46urthermore, 'git clone --recursive myapp myapp2' will totally fail,
because it will then expect gem[1..n] to all be in separate local
directories at the same level as myapp, which they aren't.  (You might
be saying: what do you need that for?  Well, I rarely do.  But
sometimes.  And as long as I don't use git-submodule, it works fine.)

You can fix warts all day long.  You can't make it work, because it's
not just warts; the insides are rotten.

>> - branching a local supermodule on my local machine: fails to branch
>> the submodule automatically and makes it super easy to lose patches
>> altogether (since by default, they're committed to a detached HEAD).
>
> That's UI problem, too. =A0Theough I guess that using detached HEAD w=
as
> choosen because it is simplest solution.

I've seen the discussion about submodule branch names go by on the git
list a few times, and I participated once or twice.  The current
option was certainly chosen because it's the simplest; unfortunately,
it's also non-functional, and all the other options are also awful.

Here it is in a nutshell: if I'm branching myapp, I already have a
branch that I want to store all my changes under; it's the branch I'm
working on in myapp.  That's not to say I want that same myapp branch
name *in my gem13 repository*; my branchname is probably something
like add-feature-to-myapp, which has nothing to do with gem13.  The
changes required to gem13 to implement add-feature-to-myapp are
probably just a tiny bugfix or config option.  gem13 doesn't know
anything about myapp.  The upstream gem13 maintainers certainly don't
care about myapp.  As a guy who *just wants to get work done on myapp
right now*, thinking about what to name my trivial one-patch temporary
branch gem13 is a *waste of time*.

I don't *want* my gem13 changes to have a branchname.

So the disconnected HEAD is the right answer then, right?  No!  The
default disconnected HEAD makes it *far* too easy to lose my changes.
I don't want to name my branch, but I *have* to, because I *have* to
push it somewhere separately, because if I don't, then my changes to
myapp will be useless to everyone who tries to pull from me.

The question of what to name the submodule branch is unanswerable
because it's the wrong question.

> Otherwise you would have either
> put submodule branch name in '.gitmodules' (but that's contrary to gi=
t
> philosophy that branches are ephemeral and branch names are local mat=
ter),

Surely including *repository URLs* inside the *repository content* is
at least as bad as including branch names.  If we're going to do one,
we might as well do the other.  But it won't help, because the stored
branch name will probably be 'master', and my personal hacked-up copy
of gem13 shouldn't be on a branch named master anyway.

>> - pulling/merging: always causes a conflict if local and remote have
>> modified the same submodule.
>>
>> - rebasing: always causes a conflict if local and remote have modifi=
ed
>> the same submodule. =A0Also requires you to rebase submodules separa=
tely
>> from the supermodule. =A0(Yes, this happens often in real life.)
>
> That's a matter of UI, and lack of merge strategy that can merge
> submodules... although if I remember correctly there was some prelimi=
nary or
> proof of concept work on submodule-aware merge strategy.
>
> "git merge" and "git rebase" would have to acquire '--recursive' opti=
on.
> Currently you probably need to use 'git submodule foreach ...', I gue=
ss.

Merge and rebase are actually very different here.  Merging is
something I might expect to work across submodules eventually;
rebasing is much less obvious, because successive versions of myapp
might actually be jumping back and forth between versions of gem13.
Then what does it mean to auto-rebase gem13 when you're rebasing
myapp?

You should check out git-subtree --squash here; it's quite interesting
and makes rebasing easy, even if the subtree version is alternating
back and forth.  I'm not sure how you'd map it onto git-submodule,
though, even if git-submodule weren't broken.

>> - submitting upstream: requires me to have a separate repo that's a
>> copy of the upstream repo, and to manage at least one subrepo branch
>> for every superproject branch, just to track my submissions. =A0With
>> git-subtree, no extra repos are necessary.
>
> NOTE that it is important design decision to have by default separate=
 object
> storage for submodules.

I certainly won't deny that :)  This discussion is about whether it
was the right decision.

> First, this allow to not clone submodule, and do not download its obj=
ects.
> This is *impossible* with git-subtree (with using 'subtree' merge str=
ategy).
> I'm not sure how commonly this feature is used in real life, but some=
body
> here in this thread gave example of submodule with arts, which is lar=
ge
> because it contains large / many binary files, while being required t=
o have
> only for some.
>
> Second, from what I remember this was implemented also for perfomance
> reasons... though I don't remember reasoning used.

I think this ended up being a terrible mistake.  The problems you
identify come down to this:

1) Sometimes I want to clone only some subdirs of a project
2) Sometimes I don't want the entire history because it's too big.
3) Super huge git repositories start to degrade in performance.

(Actually #3 isn't really a problem as far as I've ever seen, and bup
stores hundreds of gigs, including trees that reference millions of
blobs, in a single git repo without dying.  But okay, maybe this is a
problem sometimes for some types of operations.)

These problems come up regardless of whether you're using submodules.
The hard truth of the matter is that people are using submodules to
try to solve these problems, but they were never caused by the lack of
submodules in the first place.

When I clone the Linux kernel, sometimes I just don't want the entire
history.  That's why people invented shallow clones (although last
time I checked, they were still a little half-assed).

When I clone KDE, sometimes I don't want all the subprograms;
sometimes I do. That's why people invented sparse checkouts, and why
(I think) it would be nice to have sparse clones as well (where you
don't even download the objects for subtrees you don't care about).

There is simply not a clear path from "my repo is too big" to "all my
problems will be solved if git-submodule is implemented correctly."

The truth is, problems 1-3 are easily solvable by improving the git
implementation, without any change in architecture and without
requiring people to layout their projects differently.

The *real* need for submodules - the need you can't fix without
submodules - has nothing to do with these requirements.  It's about
each submodule wanting to have its own lifecycle, owner, changelog,
and release process, and - perhaps this is actually the killer
requirement - each supermodule wanting to be able to cleanly rewind a
submodule if they don't like the new version.

>> It's very clear that git-submodule's current behaviour totally
>> mismatches the entire git philosophy. =A0That's why it's so impossib=
le
>> to make the git-submodule command usable.
>
> That's very strong accusation.

Agreed... but that doesn't make it wrong :)

> Using git-subtree has its warts too: I don't think for example that t=
here is
> a way to get a log _automatically excluding_ history subtree-merged
> subprojects. =A0Or is it there?

There's git-subtree merge --squash.  It's pretty cool.  Also insane
and not as good as real tree->commit links.  I will gladly admit to
git-subtree's warts.

>
> Sumodule =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | Subtre=
e
> -----------------------------------+---------------------------------=
-
> must clone recursively submodules; | automatically gets all subtrees

Yup.

> can not clone some submodules =A0 =A0 =A0| cannot leave out some subt=
ree, but
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 nowadays can not checkout it

I don't understand what you mean on the right-hand side here.  FWIW,
subtree forces you to always checkout the entire thing (unless you use
git sparse checkouts, I guess; maybe that's what you mean).

> rebase and merge needs separate =A0 =A0| rebase and merge works norma=
lly
> work in submodule currently =A0 =A0 =A0 =A0|

True.

> easy to send updates upstream =A0 =A0 =A0| need not to worry about su=
bmodule
> to submodule repo =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| repository

It's actually easy to send subtree updates upstream with the new 'git
subtree push' command, which was contributed recently.  Or you can
send them via format-patch if you use 'git subtree split'.  It's one
line more of typing than doing it on a submodule repo, and that one
line is greatly offset by the hugely reduced typing by not using
submodules.

Have fun,

Avery
