From: Scott Chacon <schacon@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Sun, 5 Jun 2011 11:39:00 -0700
Message-ID: <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
	<m339jps1wt.fsf@localhost.localdomain>
	<BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
	<201106051311.00951.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 05 20:39:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTIE8-0000Ka-UF
	for gcvg-git-2@lo.gmane.org; Sun, 05 Jun 2011 20:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755586Ab1FESjC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jun 2011 14:39:02 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51048 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645Ab1FESjB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2011 14:39:01 -0400
Received: by gwaa18 with SMTP id a18so1246989gwa.19
        for <git@vger.kernel.org>; Sun, 05 Jun 2011 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DBeleinNqpnOxtY2Alnx87OifehHuGSD+qlx9jrIB90=;
        b=Dmp16URYIzvuRUthSgNRU0e4c16hTT9PlCBgd4H1WEUtdCkrOId/wZ/ifbxgyabnCj
         alU/VJ6K4P4Cx4VYIWdulL38Q9wKdqI/G4T+0R5B3MMswd5JiBQnNbBnreOR0VIgFGCF
         KFnxgGfGvOpuUG26sP0LoAyev86g1Hf02/xZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=B29fE/ccxCzQLYo833XB3daJI4VpopRp46RdlmIZvth8+BGihXtzraHoitUHcqDIKY
         0x/5FGn0YU2R9cfT4AUS2gGhhsHsKqr/MlH1F9Si1YQEVYo8Axuufz7ucCClzh5nsfOw
         5ZdP1Wtu1q3xI6PYm9LN0hliukGXe/5+tLjZg=
Received: by 10.236.110.176 with SMTP id u36mr5320340yhg.162.1307299140129;
 Sun, 05 Jun 2011 11:39:00 -0700 (PDT)
Received: by 10.236.36.1 with HTTP; Sun, 5 Jun 2011 11:39:00 -0700 (PDT)
In-Reply-To: <201106051311.00951.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175083>

Hey,

On Sun, Jun 5, 2011 at 4:10 AM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> On Sun, 5 Jun 2011, Michael Nahas wrote:
>> On Sat, Jun 4, 2011 at 5:49 PM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>>> Michael Nahas <mike.nahas@gmail.com> writes:
>>>
>>>> Quick list of recommendations:
>>>>
>>>> 1. Pick aliases for the next commit and the working tree that act =
like
>>>> =C2=A0 =C2=A0commits on the command-line.
>>>
>>> No go. =C2=A0This was asked for many times, and each time shot down=
=2E
>>> Those "aliases" / pseudo-refs looks like commits but do not behave
>>> exactly like commits. =C2=A0This would increase connfusion.
>>
>> I'm glad it was discussed. =C2=A0I think users would know that those
>> commits were special (they are writeable after all), but I'm sure mo=
re
>> informed people than I made the same arguments.
>
> Perhaps we should add conclusion / summary of this discussion either
> somewhere on git wiki (http://git.wiki.kernel.org), or e.g. on gitcli=
(7)
> manpage, so that it won't get reiterated again and again. =C2=A0It is=
 sort
> of frequently asked question^W request.

Can you cite any of these threads please?  I also thought this was a
reasonable suggestion and don't remember these previous discussions.
Also, to be fair, I've been pretty active in this community for a long
time now and I honestly don't ever remember seeing the 'gitcli'
manpage, so don't feel too bad Michael.

>
>>>> 2. Adopt a (semi-)formal notation for describing what commands do.
>>>
>>> Whom it would help? =C2=A0Not an ordinary user.
>>
>> I think it would help experts in discussing exactly what happens. =C2=
=A0For
>> ordinary users that are hitting an intricate case (or don't know
>> English very well), it would be good if there was something that wou=
ld
>> tell them mathematically what occurs.
>
> Well, semi-formal notation could help, but I am not sure if it would
> really be easier to understand than textual description.

I think some notational format like this would be way, way easier to
understand than, for instance, the current git-reset page, which is
almost impossible to follow.

> What about (well, more rarely used) "git reset <commit> -- <path>"?
> But I quite like "git unadd" alias, even if "git unadd <commit> <path=
>"
> looks strange; we have precedent in the form of "git stage" command
> (alias).
>

I actually sort of dislike the idea of an alias, even though I'm
probably mostly to blame for the introduction of the 'git stage' alias
in the first place.  I do feel, however, that 'reset' and 'checkout'
are horribly and confusingly overloaded and introducing a couple of
new porcelain commands to do a subset of their functionality in a
safer and more friendly manner would be hugely helpful.  I would
actually like to start treating 'reset' as more of a plumbing command,
since it is so incredibly confusing and does so many different things.
 I think it would be better to introduce things like 'unadd' or
'unstage', 'revert-file' to revert file contents in the work tree,
'uncommit' to do 'reset HEAD~', 'unmerge' to do a 'reset --hard' but
check that we are in a conflicted merge state, etc.

Not just aliases, but commands that run 'reset' or 'checkout' in the
background but have command specific options and help pages.  Knowing
that 'reset' is how you do all of these things is not intuitive.
Knowing that some options to 'reset' and 'checkout' are work tree
unsafe and others are safe is not intuitive in addition to scaring
people into not using or figuring out the other options because
they're scared of the unsafe invocations.

>> (And renaming "git checkout -- <path>" to some
>> yet-to-be-named other command.)
>
> I think this one could be left as is, at least until a really good na=
me
> for said replacement appears ("git revert" means something else, and
> "git revert-file" is a bit long, and can be confused with currently
> not existing but proposed and discussed "git revert <revision> <paths=
pec>".)

I would really like to not introduce more ways of making one command
do totally different things depending on if it gets a file path
limiter or not.


>>>> My recommendations are:
>>>>
>>>> 1. Pick aliases for the next commit and the working tree that act =
like
>>>> commits on the command-line.
> [...]
>>>> For the alias for the next commit and working tree, I suggest "NEX=
T"
>>>> and "WTREE".=C2=A0 Creating these aliases will make the interface =
more
>>>> regular. It will remove oddities like "diff --cached FOO" and repl=
ace
>>>> them with "diff NEXT FOO" and mean that "diff" and "diff FOO" can =
be
>>>> explained as "diff WTREE NEXT" and "diff WTREE FOO".
>>>
>>> This idea ws proposed multiple time on git mailing list, and every
>>> time it was rejected.
> [...]
>> That this idea has been brought up multiple times says that it does
>> have some merit. =C2=A0But apparently not enough merit.
>
> No, this only means that people *think* it has merit. =C2=A0And perha=
ps
> that they are poisoned by Subversion's pseudo-refs ;-P

Just for the record, I've never used Subversion, have a pretty solid
understanding of Git internals and I thought this was a good idea.
=46or example, implementation details aside, I think having something
like WTREE and NEXT available would help users understand that there
are these 3 trees that are important and useful in Git and re-inforce
a very non-SVN style workflow in that manner.

Having people learn '--cached', which just makes no sense in most
contexts, is confusing.  It's great that it's there, but it's not
necessary to know the difference to use git in almost any
circumstances.  I never remember what the difference is, but I rarely,
if ever, run into a case where I need to use one where I haven't just
memorized the invocation I need. For example, 'rm --cached', and 'diff
--cached' are just commands I use because I know what they do, not
because I remember the semantics of --cached over --index (if --index
even is applicable in these cases, which I don't think it is).

>
>>> BTW. both index and worktree have their own "aliases", namely ':0:'
>>> for index (stage 0), and ':' or ':/' for top tree.
>>
>> Really? =C2=A0Where can these aliases be used?
>
> Well, actually they _currently_ cannot be used in many places.
>
> You can view version of file as it is in the index with
>
> =C2=A0$ git show :0:path/to/file
>
> You can add file from a top of project directory (given new enough gi=
t;
> I think it isn't in any released git version yet) with
>
> =C2=A0$ git add :/path/to/file
>
> independently on subdirectory you are in (i.e. --full-tree).
>
>
> But the main point was meant to be that even if there was some merit
> to the pseudo-tree-ish aliases, ':0:' or '::' or ':0' would be better
> that NEXT / STAGE / INDEX that looks like symbolic refs and therefore
> commits but ain't, and ':/' would be better that WORK / WTREE.

Please be kidding.

I just don't understand how you can honestly suggest to someone that
"git show :0:/path/to/file.txt" makes more sense to anyone then "git
show NEXT:/path/to/file.txt" would.  I have no idea if ':0:' or '::'
work anywhere, but if they ever do, I guarantee they will be used by
practically nobody.

>>> Second, it doesn't solve issue of needing --cached and/or --index
>>> swiches completely. =C2=A0Those pseudo-almost-refs hide them for "g=
it diff",
>>> "git grep", "git ls-files", perhaps "git submodule" where we *read*
>>> from index, but not for "git apply", "git rm" or "git stash" where
>>> those swicthes affect *writing*.
>>
>> I agree with you that it would not get rid of all switches. =C2=A0I =
never
>> expected it to. =C2=A0My major aim was to simplify things like the "=
diff"
>> command, which I have trouble remembering the different variations o=
f.

Nearly everybody does, which is why I also believe his argument has mer=
it.

> You miss the point of this. =C2=A0The issue is that you have to learn=
 about
> '--cached' and '--index' *anyway* (because pseudo-almost-refs do not
> solve everything), and for consistency and backward compatibility we
> need to support '--cached' for "git diff" etc., so you proposal bring=
s
> nothing but new thing to learn (and not only syntax, but quirks as we=
ll).
>
> So you only add to required knowledgebase, not reduce it.

Though I already argued against this, I would reiterate it.  You do
not have to learn about those switches to use Git.  You don't have to
be able to do everything in Git before you can do anything.  I do not
know of a single command I've ever used where I needed to know the
difference - it almost never comes up in daily use for nearly all Git
users.  Can you come up with an example other than 'apply' that takes
both options?  If a user doesn't use 'apply' (and I think the vast
majority doesn't), then a simpler alternative that is more universally
applicable would reduce the required knowledgebase for almost all Git
users.


>>> Hrmmm... how this notation would explain differences between
>>> "git reset --hard", "git reset --keep" and "git reset --merge"?
>>
>> I don't understand what "git reset --keep" and "git reset --merge" d=
o.
>> I've read the manpage but am still confused. =C2=A0One of my reasons=
 for
>> suggesting a notation is so that there is a clear mathematical
>> representation of what the commands do. =C2=A0Once I understand them=
, I can
>> make an attempt at a notation that can explain them.
>
> What I meant here is that above notation wouldn't help explaining the
> differences between --hard, --keep and --merge. =C2=A0Perhaps a table=
 could
> help there.
>
> But IMVHO is more important for documentation to tell *when* one woul=
d
> use one or another, not how they work.

Just to I also have no idea how to use --keep and --merge. I think it
would be useful to have both - I've read the one example of how to use
--keep, but I've never used it and if I ran into that specific
use-case, I'm sure I wouldn't even remember that something was there
to help.

>>>> 3. Move the operations "checkout -- <file>" and "reset -- <file>" =
to
>>>> their own command names
>>>>
>>>> This is my biggest and most important suggestion.
>>>>
>>>> "checkout -- foo.txt" copies foo.txt from NEXT to WTREE. Similarly=
,
>>>> "reset -- foo.txt" will copy foo.txt from HEAD to NEXT.
>>>
>>> =C2=A0"checkout HEAD -- foo.txt" copies foo.txt from HEAD to NEXT a=
nd WTREE
>>>
>>> =C2=A0"checkout HEAD^ -- foo.txt" copies foo.txt from HEAD^ to NEXT=
 and WTREE
>>> =C2=A0"reset HEAD^ -- foo.txt" copies foo.txt from HEAD^ to NEXT
>>>
>>>> These are operations to designate/undesignate files in the next co=
mmit
>>>> and should be grouped with others like them: "add", "rm" and "mv".=
 (In
>>>> fact, the man page for "reset -- <file>" even says that it is the
>>>> opposite of "add"!)
> [...]
>
>>>>=C2=A0For the other, my best suggestion is "head-to-next", but I'm =
sure
>>>> someone can do better.
>>>
>>> I'd rather remember that "git checkout" is about checking out
>>> something to a working area.
>>
>> Now that I've separated these two usages of "checkout" in my brain,
>> "git checkout <branch>" is all about changing to a different branch.
>> That files in the working tree change is just incidental to moving t=
o
>> the new branch.
>>
>> The manpage paragraph for "git checkout -- <file>" has in bold that
>> this usage "does not switch branches". =C2=A0So, for me, it's a comp=
letely
>> different usage and should be a different command.
>
> For me it is about "checking out" two different entities: a branch
> (or related case of non-branch ref, e.g. "git checkout v1.7.3", or
> "git checkout HEAD~2"), or a pathspec (file or directory). =C2=A0Chec=
king
> out branch means making it current branch, checking out file means
> making this version of a file current.
>
>> I wish I had a reasonable name to suggest for the new command.
>
> Good name is a required prerequisite here, unfortunately...

Actually, I'm pretty sure even an amazing name wouldn't help here.
I'm a bit surprised that you would reference the previous WTREE/NEXT
discussions, but not the discussions we've had on this topic:

http://thread.gmane.org/gmane.comp.version-control.git/121206/focus=3D1=
21317

I've brought up splitting checkout and simplifying some commands the
way EasyGit has done and none other than Linus himself shot it down
and that was nearly 2 years ago.  Sadly, the chances of getting any UI
improvements of this nature in seem quite remote, and have been for
some time.

I would like to thank Michael for taking so much time to propose a
thoughtful response to the UI issues that so many people struggle with
instead of just complaining, as most do.

I would love if we could compile suggestions like these and shoot for
a Git 2.0 with a much nicer UI and help system.  However, it seems
unlikely that Junio would go for this.  It seems somewhat more likely
that what would happen is that a simpler, cleaner libgit2 based cli
would emerge at some point with an 80% most-used functionality and
super nice UI mentality, but that wouldn't be for some time.

Scott
