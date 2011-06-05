From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Mon, 6 Jun 2011 01:37:28 +0200
Message-ID: <201106060137.32174.jnareb@gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <201106051311.00951.jnareb@gmail.com> <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 01:38:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTMtR-0002Ay-Ln
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 01:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756528Ab1FEXho convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jun 2011 19:37:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61533 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756520Ab1FEXhn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2011 19:37:43 -0400
Received: by bwz15 with SMTP id 15so2912459bwz.19
        for <git@vger.kernel.org>; Sun, 05 Jun 2011 16:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        bh=yI2CFvwn6rMTZW0pawgXtRhyhlOaeZm5WARqFStq/y4=;
        b=TjrIdSo/12BhSnaR1mFyKl8i1ey0pJOF5qhblf2OPy+Kp0CMsnv/Fnld4sKM3CucVe
         SC0rn9MrwnXEE/2jc3ag2RfKmKvgSRSHVhE8qyrPoqSQfrGZpDTSy6lGcP4RS/iDNAs0
         KN115ejfjMFvV1D8DrOAu9QS8x8XG9/S0/Hac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=bSWpX0wpR4oKlcD3qn/Oav7yb0cCmJuuwM4ACY6pooTsI9qHk8BjscZhPRjBslwwZF
         mTBiIyaLPhM4ewXcNPu8hJk10MibNcjIJqk3ksIxkR0aoDxDAH/Zt7yEJKSV+e3hbN12
         FRloKTlaJRkATA3d1W8J/jo2vTH921XscQD8A=
Received: by 10.204.39.203 with SMTP id h11mr737486bke.90.1307317059795;
        Sun, 05 Jun 2011 16:37:39 -0700 (PDT)
Received: from [192.168.1.13] (abvi97.neoplus.adsl.tpnet.pl [83.8.206.97])
        by mx.google.com with ESMTPS id k10sm2906202bkq.22.2011.06.05.16.37.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Jun 2011 16:37:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175087>

Hey,

On Sun, 5 Jun 2011, Scott Chacon wrote:
> On Sun, Jun 5, 2011 at 4:10 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
>> On Sun, 5 Jun 2011, Michael Nahas wrote:
>>> On Sat, Jun 4, 2011 at 5:49 PM, Jakub Narebski <jnareb@gmail.com> w=
rote:
>>>> Michael Nahas <mike.nahas@gmail.com> writes:
>>>>
>>>>> Quick list of recommendations:
>>>>>
>>>>> 1. Pick aliases for the next commit and the working tree that act=
 like
>>>>> =C2=A0 =C2=A0commits on the command-line.
>>>>
>>>> No go. =C2=A0This was asked for many times, and each time shot dow=
n.
>>>> Those "aliases" / pseudo-refs looks like commits but do not behave
>>>> exactly like commits. =C2=A0This would increase connfusion.
>>>
>>> I'm glad it was discussed. =C2=A0I think users would know that thos=
e
>>> commits were special (they are writeable after all), but I'm sure m=
ore
>>> informed people than I made the same arguments.
>>
>> Perhaps we should add conclusion / summary of this discussion either
>> somewhere on git wiki (http://git.wiki.kernel.org), or e.g. on gitcl=
i(7)
>> manpage, so that it won't get reiterated again and again. =C2=A0It i=
s sort
>> of frequently asked question^W request.
>=20
> Can you cite any of these threads please?  I also thought this was a
> reasonable suggestion and don't remember these previous discussions.

Somewhere in this thread:

  "[RFC/PATCH 0/2] New 'stage' command"
  http://thread.gmane.org/gmane.comp.version-control.git/115666/focus=3D=
115880
  (STAGE and WORKTREE pseudo-ref aliases)

And I think it was not the only one, but is the only one I have saved
(bookmarked).  Unfortunately searching for such thread needs case sensi=
tive
search, and most searches ain't.

> Also, to be fair, I've been pretty active in this community for a lon=
g
> time now and I honestly don't ever remember seeing the 'gitcli'
> manpage, so don't feel too bad Michael.

Well, gitcli(7) is referenced only from git(1) and from git-rev-parse(1=
)
manpages, and was added in 2f7ee08 (parse-options: Add a gitcli(5) man
page., 2007-12-13) [v1.5.4-rc2~14], as I wrote.

It should really be referenced in git tutorials and in user's manual.

>>
>>>>> 2. Adopt a (semi-)formal notation for describing what commands do=
=2E
>>>>
>>>> Whom it would help? =C2=A0Not an ordinary user.
>>>
>>> I think it would help experts in discussing exactly what happens. =C2=
=A0For
>>> ordinary users that are hitting an intricate case (or don't know
>>> English very well), it would be good if there was something that wo=
uld
>>> tell them mathematically what occurs.
>>
>> Well, semi-formal notation could help, but I am not sure if it would
>> really be easier to understand than textual description.
>=20
> I think some notational format like this would be way, way easier to
> understand than, for instance, the current git-reset page, which is
> almost impossible to follow.

Not all can be solved by semi-formal, semi-mathematical notation, but i=
t,
together with tables (a problem for manpages, though), and ABNF for=20
technical documentation would help, sure.

It is unfortunate that to know what to write in manpage you need to be
a bit of expert, and when you are expert you usually loose sight on how
to write manpage readable for new / non-expert user ;-)  Maybe it would
be a good task for Google Code-In?

>> What about (well, more rarely used) "git reset <commit> -- <path>"?
>> But I quite like "git unadd" alias, even if "git unadd <commit> <pat=
h>"
>> looks strange; we have precedent in the form of "git stage" command
>> (alias).
>=20
> I actually sort of dislike the idea of an alias, even though I'm
> probably mostly to blame for the introduction of the 'git stage' alia=
s
> in the first place.

Well, because of backward compatibility we would need to keep supportin=
g
"git checkout -- <path>", "git checkout <commit> -- <path>", and
"git reset -- <path>".  That's why I used 'alias' name.

> I do feel, however, that 'reset' and 'checkout'=20
> are horribly and confusingly overloaded and introducing a couple of
> new porcelain commands to do a subset of their functionality in a
> safer and more friendly manner would be hugely helpful.

Well, AFAIK responsible for some of this overloading was "git is diffic=
ult
because it has too many commands" mantra... though I am not sure if put=
ting
overloading commands really helps.

But the notion of checking out file, or reseting file is quite natural.=
=2E.
at least for native English speaker.  I think in most natural languages
there are words that have more than one meaning.


NOTE that information in "git status" output, and in template for commi=
t
message is *extremely* helpful because it explains in exact detail what
you can do!

> I would=20
> actually like to start treating 'reset' as more of a plumbing command=
,
> since it is so incredibly confusing and does so many different things=
=2E
>  I think it would be better to introduce things like 'unadd' or
> 'unstage',=20

Would need both, most probably.  I don't know how widespread is using o=
f
"stage" command, but I think old timers are used to "git add".

> 'revert-file' to revert file contents in the work tree,=20

Bit longish, but quite all right.

> 'uncommit' to do 'reset HEAD~',

Not "git reset --soft HEAD"?

> 'unmerge' to do a 'reset --hard' but=20
> check that we are in a conflicted merge state, etc.

I think you meant "git reset --merge" here.  Nevertheless it might be
a good addition because of safety check.  Like "git mv" which is wrappe=
r
around "git rm" and "mv"/"cp" and "git add", but with safety check.

> Not just aliases, but commands that run 'reset' or 'checkout' in the
> background but have command specific options and help pages.

If proliferation of command is problem, it might be "git add --undo"
instead of "git unadd"... but then there is problem with=20
"git unadd <commit> <file>".

> Knowing that 'reset' is how you do all of these things is not intuiti=
ve.

Thanks to "git status" output knowledge is not really necessary.  It is
written there in detail.

But it is true that guessing by ones own that forms of git-checkout and
git-reset is how you do it require good knowledge of "git model".

> Knowing that some options to 'reset' and 'checkout' are work tree
> unsafe and others are safe is not intuitive in addition to scaring
> people into not using or figuring out the other options because
> they're scared of the unsafe invocations.

Errr... "git checkout" in its branch switching version is always safe,
unless you use "--force".  The forms of "checkout" and "reset" that
are about checking out and reseting file are of course this file unsafe=
=2E
Duh.  Well, "git reset --hard" could get "--force" safety check... but
then it would be quite annoying and harder to use.

>>> (And renaming "git checkout -- <path>" to some
>>> yet-to-be-named other command.)
>>
>> I think this one could be left as is, at least until a really good n=
ame
>> for said replacement appears ("git revert" means something else, and
>> "git revert-file" is a bit long, and can be confused with currently
>> not existing but proposed and discussed "git revert <revision> <path=
spec>".)
>=20
> I would really like to not introduce more ways of making one command
> do totally different things depending on if it gets a file path
> limiter or not.

You probably don't like Perl with its context-dependency and TIMTOWTDI
("there is more than one way to do it")... ;-P

>>>>> My recommendations are:
>>>>>
>>>>> 1. Pick aliases for the next commit and the working tree that act=
 like
>>>>> commits on the command-line.
>> [...]
>>>>> For the alias for the next commit and working tree, I suggest "NE=
XT"
>>>>> and "WTREE".=C2=A0 Creating these aliases will make the interface=
 more
>>>>> regular. It will remove oddities like "diff --cached FOO" and rep=
lace
>>>>> them with "diff NEXT FOO" and mean that "diff" and "diff FOO" can=
 be
>>>>> explained as "diff WTREE NEXT" and "diff WTREE FOO".
>>>>
>>>> This idea ws proposed multiple time on git mailing list, and every
>>>> time it was rejected.
>> [...]
>>> That this idea has been brought up multiple times says that it does
>>> have some merit. =C2=A0But apparently not enough merit.
>>
>> No, this only means that people *think* it has merit. =C2=A0And perh=
aps
>> that they are poisoned by Subversion's pseudo-refs ;-P
>=20
> Just for the record, I've never used Subversion, have a pretty solid
> understanding of Git internals and I thought this was a good idea.
> For example, implementation details aside, I think having something
> like WTREE and NEXT available would help users understand that there
> are these 3 trees that are important and useful in Git and re-inforce
> a very non-SVN style workflow in that manner.

These are not quite tree-ish, because of index stages, and of ignored
and other (untracked not ignored) files in worktree.  And they are
not at all commit-ish/revision or symrefs, like name hints.
=20
> Having people learn '--cached', which just makes no sense in most
> contexts, is confusing.  It's great that it's there, but it's not
> necessary to know the difference to use git in almost any
> circumstances.  I never remember what the difference is, but I rarely=
,
> if ever, run into a case where I need to use one where I haven't just
> memorized the invocation I need. For example, 'rm --cached', and 'dif=
f
> --cached' are just commands I use because I know what they do, not
> because I remember the semantics of --cached over --index (if --index
> even is applicable in these cases, which I don't think it is).

Because --index is about affecting _also_ index, i.e. about affecting
index and working tree _together_, it is quite rare: only "git apply"
and "git stash" use it.

So --cached means proposed NEXT / STAGE.  It is used by "diff", "grep",
"ls-files", "rm", "submodule".  From those only in "git diff" there
might be trouble remembering, because diff is about 2 endpoints.

BTW. gitcli(7) manpage mentions http://marc.info/?l=3Dgit&m=3D116563135=
620359
(talking about --cached vs --index, and why both are necessary) and
http://marc.info/?l=3Dgit&m=3D119150393620273 (differences between --ca=
ched
and index, and about "git apply" that has three modes: "git apply",=20
"git apply --cached" and "git apply --index").
=20
>>>> BTW. both index and worktree have their own "aliases", namely ':0:=
'
>>>> for index (stage 0), and ':' or ':/' for top tree.
>>>
>>> Really? =C2=A0Where can these aliases be used?
>>
>> Well, actually they _currently_ cannot be used in many places.
>>
>> You can view version of file as it is in the index with
>>
>> =C2=A0$ git show :0:path/to/file
>>
>> You can add file from a top of project directory (given new enough g=
it;
>> I think it isn't in any released git version yet) with
>>
>> =C2=A0$ git add :/path/to/file
>>
>> independently on subdirectory you are in (i.e. --full-tree).
>>
>>
>> But the main point was meant to be that even if there was some merit
>> to the pseudo-tree-ish aliases, ':0:' or '::' or ':0' would be bette=
r
>> that NEXT / STAGE / INDEX that looks like symbolic refs and therefor=
e
>> commits but ain't, and ':/' would be better that WORK / WTREE.
>=20
> Please be kidding.
>=20
> I just don't understand how you can honestly suggest to someone that
> "git show :0:/path/to/file.txt" makes more sense to anyone then "git
> show NEXT:/path/to/file.txt" would.  I have no idea if ':0:' or '::'
> work anywhere, but if they ever do, I guarantee they will be used by
> practically nobody.

Note that it is :0:, :1:, :2:, :3:, i.e. you can refer to individual
stages for unmerged file.  Though perhaps people use --base, --ours,
--theirs instead... though this is not very widely supported. :0:file
works anywhere, because it is revspec.

The problem wit HEAD-like NEXT / STAGE pseudo-ref is that it looks like
commit but does not behave like commit.  Even looking at it as tree-ish
is [slight] oversimplification.
=20
>>>> Second, it doesn't solve issue of needing --cached and/or --index
>>>> swiches completely. =C2=A0Those pseudo-almost-refs hide them for "=
git diff",
>>>> "git grep", "git ls-files", perhaps "git submodule" where we *read=
*
>>>> from index, but not for "git apply", "git rm" or "git stash" where
>>>> those swicthes affect *writing*.
>>>
>>> I agree with you that it would not get rid of all switches. =C2=A0I=
 never
>>> expected it to. =C2=A0My major aim was to simplify things like the =
"diff"
>>> command, which I have trouble remembering the different variations =
of.
>=20
> Nearly everybody does, which is why I also believe his argument has m=
erit.

It's only "git diff" that have problems, because of peculiarity of it
that it comares 2 things.  What is second one, that can be confusing:
"git diff", "git diff --cached", "git diff HEAD":

                worktree
                  |   \
                  |    \  diff
                  |     v
       diff HEAD  |     index
                  |     /
                  |    /  diff --cached
                  v   v
                  HEAD  =20


I don't think anybody has problems understanding and remembering=20
"git grep --cached" and "git rm --cached"... and while you could use
"git grep NEXT", "git rm NEXT" doesn't make sense -- "--cached" is
target designator, not source designator here.
=20
>> You miss the point of this. =C2=A0The issue is that you have to lear=
n about
>> '--cached' and '--index' *anyway* (because pseudo-almost-refs do not
>> solve everything), and for consistency and backward compatibility we
>> need to support '--cached' for "git diff" etc., so you proposal brin=
gs
>> nothing but new thing to learn (and not only syntax, but quirks as w=
ell).
>>
>> So you only add to required knowledgebase, not reduce it.
>=20
> Though I already argued against this, I would reiterate it.  You do
> not have to learn about those switches to use Git.  You don't have to
> be able to do everything in Git before you can do anything.  I do not
> know of a single command I've ever used where I needed to know the
> difference - it almost never comes up in daily use for nearly all Git
> users. =20

In most cases you use "--cached".  Is it that much of a problem to
remember it (with possible exception of mentioned "git diff" complicati=
on)
compared to WHATEVER (NEXT or STAGE or INDEX)?

> Can you come up with an example other than 'apply' that takes=20
> both options?  If a user doesn't use 'apply' (and I think the vast
> majority doesn't), then a simpler alternative that is more universall=
y
> applicable would reduce the required knowledgebase for almost all Git
> users.

But you would need both of those options for "git apply", and pseudo-re=
fs
does not really work here in either case - it is target designator, not
source designator.=20
=20
There is no other command that takes both, but there is --index for sta=
sh:
"git stash --index apply".

>>>> Hrmmm... how this notation would explain differences between
>>>> "git reset --hard", "git reset --keep" and "git reset --merge"?
>>>
>>> I don't understand what "git reset --keep" and "git reset --merge" =
do.
>>> I've read the manpage but am still confused. =C2=A0One of my reason=
s for
>>> suggesting a notation is so that there is a clear mathematical
>>> representation of what the commands do. =C2=A0Once I understand the=
m, I can
>>> make an attempt at a notation that can explain them.
>>
>> What I meant here is that above notation wouldn't help explaining th=
e
>> differences between --hard, --keep and --merge. =C2=A0Perhaps a tabl=
e could
>> help there.
>>
>> But IMVHO is more important for documentation to tell *when* one wou=
ld
>> use one or another, not how they work.
>=20
> Just to I also have no idea how to use --keep and --merge. I think it
> would be useful to have both - I've read the one example of how to us=
e
> --keep, but I've never used it and if I ran into that specific
> use-case, I'm sure I wouldn't even remember that something was there
> to help.

"git reset --merge", as the name hints, is to be used to 'nuke' botched
merge.  "git reset --keep" is safe way of rewinding which won't nuke
your changes by accident... as far as I understand it.  The documentati=
on
is suboptimal at best, I certainly agree.
=20
>>>>> 3. Move the operations "checkout -- <file>" and "reset -- <file>"=
 to
>>>>> their own command names
[...]
>>> The manpage paragraph for "git checkout -- <file>" has in bold that
>>> this usage "does not switch branches". =C2=A0So, for me, it's a com=
pletely
>>> different usage and should be a different command.
>>
>> For me it is about "checking out" two different entities: a branch
>> (or related case of non-branch ref, e.g. "git checkout v1.7.3", or
>> "git checkout HEAD~2"), or a pathspec (file or directory). =C2=A0Che=
cking
>> out branch means making it current branch, checking out file means
>> making this version of a file current.
>>
>>> I wish I had a reasonable name to suggest for the new command.
>>
>> Good name is a required prerequisite here, unfortunately...
>=20
> Actually, I'm pretty sure even an amazing name wouldn't help here.

"Required" prerequisite does not mean "sufficient" prerequisite.

> I'm a bit surprised that you would reference the previous WTREE/NEXT
> discussions, but not the discussions we've had on this topic:
>=20
> http://thread.gmane.org/gmane.comp.version-control.git/121206/focus=3D=
121317
>=20
> I've brought up splitting checkout and simplifying some commands the
> way EasyGit has done and none other than Linus himself shot it down
> and that was nearly 2 years ago.  Sadly, the chances of getting any U=
I
> improvements of this nature in seem quite remote, and have been for
> some time.

As I wrote above (independently), some like context-aware grammar
(c.f. Perl), some loathe it ;-PPP

Besides, now we have "git status" hints...
=20
> I would like to thank Michael for taking so much time to propose a
> thoughtful response to the UI issues that so many people struggle wit=
h
> instead of just complaining, as most do.

Even if there would be no new commands like "git unadd", and there
wouldn't be NEXT / STAGE / INDEX nor WTREE / WORK / WORKTREE pseudo-sym=
refs,
perhaps it would lead to improved documentation; even if not pseudo-for=
mal
specification, at least mentioning gitcli(7) in more places.
=20
> I would love if we could compile suggestions like these and shoot for
> a Git 2.0 with a much nicer UI and help system.  However, it seems
> unlikely that Junio would go for this.  It seems somewhat more likely
> that what would happen is that a simpler, cleaner libgit2 based cli
> would emerge at some point with an 80% most-used functionality and
> super nice UI mentality, but that wouldn't be for some time.

--=20
Jakub Narebski
Poland
