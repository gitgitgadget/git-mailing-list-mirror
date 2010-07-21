From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Wed, 21 Jul 2010 23:46:26 +0000
Message-ID: <AANLkTin2a_HoXLuUjq5oryMA4UhZrJ6VNyD3uOZhz5nP@mail.gmail.com>
References: <4C472B48.8050101@gmail.com>
	<AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com>
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com>
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com>
	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bryan Larsen <bryan.larsen@gmail.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 01:46:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obizi-000407-I5
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 01:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759075Ab0GUXq3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 19:46:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63620 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755340Ab0GUXq2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 19:46:28 -0400
Received: by iwn7 with SMTP id 7so7245567iwn.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 16:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=C1WRSvlMVrW0qAt3EL8ciftKdhnGP7GJrquNWmdfsm0=;
        b=mzw9+Suka4idJ/g3NUwJdf2yJCGv4jVlr2zmrYPS+a9z0qmueMB82x3Nj7Fn5FAjTG
         zgXCkiDNqSkXnw0dgbMbkC/eezll6Ogc+QkMNTukp24zpjia5BKx0darJyfveovnhkEs
         IQ8RdzzlFA7I0cbdS+80QVwFUm6KtHTESggz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Vs97I0gLy/k+Vin7emQiAvzvWpSkxS0NITh05JSpXmKDKcyI5ccGK5jePPKTrwjcQx
         ZGNTdBEcrG9QSfoCUqRFaDqBCTUgAluDdHq7V5dVYIxhMFtdxd5jtqpg4zrnqROYZdlR
         3DbHduDpPo/j5+K2u+Nsh4GoLsDAYMwluY03I=
Received: by 10.231.39.69 with SMTP id f5mr808022ibe.53.1279755986839; Wed, 21 
	Jul 2010 16:46:26 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 21 Jul 2010 16:46:26 -0700 (PDT)
In-Reply-To: <AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151433>

On Wed, Jul 21, 2010 at 21:09, Avery Pennarun <apenwarr@gmail.com> wrot=
e:
> On Wed, Jul 21, 2010 at 4:36 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> On Wed, Jul 21, 2010 at 19:56, Avery Pennarun <apenwarr@gmail.com> w=
rote:
>>> No amount of bugfixing in git submodule can fix this workflow, beca=
use
>>> it's not a result of bugs. =C2=A0(The bugs, particularly the
>>> disconnected-by-default HEADs on submodule checkouts, do make it a =
bit
>>> worse :( ) =C2=A0It would require a fundamental redesign to make th=
is work
>>> nicely with submodules.
>> [...]
>> I think most of those can be fixed, actually. The only requirement
>> that the git plumbing imposes on git-submodules is that a "commit"
>> entry exist in your tree, the rest is just (ugly plumbing).
>
> Sure. =C2=A0But this commit object (and the objects it points to) are=
 never
> automatically pushed, fetched, or fsck'd. =C2=A0They're second class
> citizens. =C2=A0As it turns out, this was a major design mistake in
> implementing the submodule commit objects.
>
> All the behaviour people *currently* get from submodules could have
> been obtained without using a new 'commit' object type at all. =C2=A0=
Just
> add a commitid to the horrible junk (including repo URLs, argh) that
> already needs to get pasted into .gitmodules, and have git-commit at
> the top level update .gitmodules automatically (as it currently
> updates the 'commit' tree entries). =C2=A0Problem solved (at least, s=
olved
> to exactly the extent that it is today).

Yeah, that does sound better than the current mess.

> What we *really* want is a way to have git actually recurse through
> commit objects when doing *any* operation, as if they were tree
> objects. =C2=A0If we had that, submodules could be beautiful (because=
 you'd
> push them to the same repo, etc and users would see none of the
> complexity). =C2=A0But this doesn't exist. =C2=A0And for backward com=
patibility
> at this point, we'd probably need to introduce an entirely new kind o=
f
> tree entry to support such a thing.
>
>> Thus, we could:
>>
>> =C2=A0 * Hack git-submodule (or its replacement) to check import the=
 tree
>> =C2=A0 =C2=A0 that contains that "commit" into one central .git
>
> This part is relatively easy, I think - at least in concept, although
> I bet there would be widespread implementation tweaks - and would
> clean up a lot of the mess. =C2=A0However it would require a change t=
o the
> .git/index file format to remember when a subdir is a commit and not =
a
> "normal" tree so that it doesn't silently commit the next thing as a
> tree instead.
>
>> =C2=A0 * Fix git status / git commit so that you could commit into
>> =C2=A0 =C2=A0 submodules, i.e.:
>>
>> =C2=A0 =C2=A0 for each submodule in this-commit:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 chdir $submodule && commit
>> =C2=A0 =C2=A0 done && cd $root && commit -m"bumping submodules"
>
> After making the earlier change to get rid of the extra .git subdirs,
> this next requirement would actually be considerably more work,
> because 'git commit' would need to know how to update a subcommit
> without changing HEAD. =C2=A0You certainly couldn't just code it up a=
s a
> recursive "git commit" as you imply (and as you could do right now).
>
>> =C2=A0 * Make git-push push the submodule contents and the
>> =C2=A0 =C2=A0 superprojects. You'd just need to have commit access t=
o the url
>> =C2=A0 =C2=A0 listed in .gitmodules.
>
> This is really a *killer* problem, and you're making it sound easy.
> Let's imagine that my app has 25 different submodules - not
> unreasonable at all in a world with dozens of ever-changing ruby gems
> and suchlike.
>
> Now, if I want to branch my project, I might have to branch 25
> projects just so I can push my changes? =C2=A0It's totally awful. =C2=
=A0And the
> awfulness is multiplied many times over if .gitmodules has hard-coded
> repo paths, because then I have to update the repo path in my branch
> but not the other branch, and merging will have conflicts. =C2=A0You =
might
> think that my .git/config could just override .gitmodules, but then
> some guy trying to fetch my branch will fail to fetch the submodules
> from my branch and get errors and have no idea what's going on.
>
> And you might think that using relative repo paths in .gitmodules
> would work, but that's only if I branched all 25 submodules in the
> *first* place. =C2=A0In real life, most subprojects point at the orig=
inal
> project's home repo by default (because nobody thinks they'll be
> patching 25 subprojects when they start, and they're probably right),
> but then you have to individually change the URLs when you decide you
> need to patch them, and life gets complicated and ugly, especially
> when the next guy goes to fork your project and now needs to fork som=
e
> subprojects but not others.
>
> There is no good solution to the submodule problem if each submodule
> has to go in its own repo. =C2=A0I've been thinking about this for ye=
ars
> now, and watching lots of discussions about it on the git mailing
> list, and I just can't see any other option. =C2=A0All the submodules=
 have
> to get pushed to and fetched from the same repo by default. =C2=A0Any=
thing
> else is insane.

Yeah, bundling the submodules in the upstream repo so only one person
ever has to worry about gathering them up and pushing them to the
central repo sounds better for most uses than the current submodule
implementation.

OTOH, I have some submodules that I track on GitHub that would really
inflate the size of the repo that's tracking them. So there are
definitely use cases for having the tree somewhere remotely as well,
especially for large submodules like game art, which some people have
reported submodules for.

> One option might be to store the submodule commit refs as refs in you=
r
> superproject. =C2=A0That wouldn't actually be so bad, except for the
> aforementioned problem that fetch/push/clone/etc don't actually trace
> through commit objects when deciding what objects to send you, so
> fetching the ref of the superproject wouldn't autofetch the subprojec=
t
> refs. =C2=A0Also, you could accidentally delete one of the subproject=
 refs
> and lose tons of history without ever realizing it. =C2=A0That's erro=
r
> prone and confusing... and clutters up your repo refs list with
> administrative stuff you didn't actually want in the first place.
>
>> What's missing from that (which would be nice) is the ability to che=
ck
>> out a subdirectory from another repository. That could (I think) be
>> done by just adding a normal "tree" entry, and then specifying that
>> that tree can be found in git://... instead of the main tree.
>
> Actually that's already easy with submodules (and git-subtree makes i=
t
> easy too, though slightly different). =C2=A0Just fetch the commit fro=
m the
> other repo, and do:
>
> =C2=A0 git checkout FETCH_HEAD -- subdirname
>
>>> If we can get some kind of consensus in principle that git-subtree =
is
>>> a good idea to merge into git core, I can prepare some patches and =
we
>>> can talk about the details.
>>
>> From having looked at it briefly it looks very nice. But it looks to
>> me as if the main differences between git-submodule and git-subtree
>> are in the porcelain, not the plumbing.
>
> No. =C2=A0The fundamental difference is exactly one: git-subtree uses
> normal 'tree' entries (rather than commits) in its trees, so that all
> the git tools recurse through them like any other tree. =C2=A0Thus yo=
u
> don't need any extra refs, extra .git dirs, etc. =C2=A0That allows yo=
u to
> bypass all the useless behaviour git has around 'commit' entries.
> This is very much a plumbing difference.
>
> The git-submodule porcelain happens to independently be kind of
> annoying and inconvenient, but that would be much easier to fix if it
> weren't for the plumbing-related problems.
>
>> It would be a lot less confusing to users of Git in the long term if
>> we would at least try to unify these two approaches instead of havin=
g
>> two mutually incompatible ways of doing essentially the same thing.
>
> True. =C2=A0But I don't have the time, and implementing the new 'comm=
it'
> entry semantics sounds like a lot of work (as opposed to arguing abou=
t
> them, which I guess I'm good at but which seems unproductive).
>
> In productive terms: git-subtree is solving problems for real users
> right now. =C2=A0It might solve more problems for more users if it we=
re
> integrated into the core and thus made "official." =C2=A0Nothing prec=
ludes
> making submodules better later.

Sure, don't get me wrong. git-subtree looks very useful, and I have no
objection to having it in git.git, and even if it's not optimal for
everything good working software now shouldn't be held up by some
theoretical pie-in-the-sky system.
