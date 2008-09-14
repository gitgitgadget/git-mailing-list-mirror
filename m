From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Git at Better SCM Initiative comparison of VCS (long)
Date: Sun, 14 Sep 2008 18:43:06 +0400
Message-ID: <20080914144306.GF28210@dpotapov.dyndns.org>
References: <200809131906.18746.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexey Mahotkin <squadette@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 16:44:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kespu-0008T0-KJ
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 16:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbYINOnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 10:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752039AbYINOnP
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 10:43:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:21686 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbYINOnN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 10:43:13 -0400
Received: by nf-out-0910.google.com with SMTP id d3so919673nfc.21
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 07:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SVFP/iC4MV7pnJNg2HwZEqiDJKVoBZ0gCTYC9H1PntA=;
        b=Ge3hMo0VaYuT7xpRXjcb4g4Y+zUmQAN27unjUfuiFPM37DBtKtiFwPZhG0wqRPtove
         41rjDB9s3ffLGMK6y52qnIT4uOd5cB1wr8ifvQ9hNkOgd8lEWGoXnL0hFIOioIvmok8C
         a6F+xODH7zd8S1/vhCPzcm2QoLuXN4aEn32Zo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EtpYdws3o7KjOccYiZFd3sRGopdvLbgkEU3Pk959qPRAzaY30ssGNMXuC231Hi2XrD
         5NoKSL+UKmKos4OZebEsgPm21lXocIdEpt+mMyFjX54VmgR1put+Vp5YqUcaLYBCO+xA
         Xg5pmBS4qE+rldVLk1uMyYqbF0PV0xQXbF7DY=
Received: by 10.86.60.15 with SMTP id i15mr5042940fga.14.1221403390616;
        Sun, 14 Sep 2008 07:43:10 -0700 (PDT)
Received: from localhost ( [85.141.149.192])
        by mx.google.com with ESMTPS id 4sm6946206fge.8.2008.09.14.07.43.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 07:43:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200809131906.18746.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95845>

Hello Jakub,

I have added Alexey Mahotkin in CC, who is allegedly the author of that
information about Git that you can read on the better-scm site.

On Sat, Sep 13, 2008 at 07:06:16PM +0200, Jakub Narebski wrote:
> 
> I have thought about trying yet another time... but Git was already
> added; see http://better-scm.berlios.de/news/changes-2008-08-07/

Interesting, the site still mentions Git as missing in a few places.
For instance, when you click on Git in the list of alternatives, you
get this: http://better-scm.berlios.de/alternatives/git/
and then when you got to FAQ, you can read this:

| The reason it's not there is that while many people have complained
| about its absense, no one suitable has volunteered to become its
| champion and supplied a good enough patch. If you have a substantial
| amount of git expertise, have good English writing skills, and wish to
| volunteer, then we'll be happy to hear from you. If not - at least don't
| complain about it.
|
| In addition to everything that was said here, it seems that the
| originator and maintainer of the site and comparison is now banned
| from sending messages to vger.kernel.org, which hosts several
| Linux-kernel-related mailing-lists, including the git one. This has
| interfered with some of his Linux-related open-source work, including
| trying to find a "Better SCM" maintainer for git. This is unfortunate,
| but changing this situation, is currently beyond his control.

Source: http://better-scm.berlios.de/faq/#git-missing

I am surprised to hear that Shlomi Fish is banned...

> scm>     <section id="repos_operations">
> scm>         <title>Repository Operations</title>
> scm>         <section id="atomic_commits">
> scm>             <title>Atomic Commits</title>
> scm>             <expl>
> scm>                 Support for atomic commits means that if an
> scm>                 operation on the repository is interrupted
> scm>                 in the middle, the repository will not be
> scm>                 left in an inconsistent state. Are the
> scm>                 check-in operations atomic, or can
> scm>                 interrupting an operation leave the
> scm>                 repository in an intermediate state?
> scm>             </expl>
> 
> Here I think the explanation of a criterion (feature) is clear enough.
> I might have added that "interruption" include killing of a process
> during for example commit, lack of disk space for a full commit, or
> a network fail during network operation (fetch or push, or equivalent).

My initial reaction was to say that killing a process with -9 is not
what you expect to see in practice, but a second later, I realized how
wrong I was. Lack of memory may cause that the process gets killed with
-9, and it has been observed in practice (at least, in case of Mercury
repo): http://norman.walsh.name/2007/08/09/mercurial

Another thing that is not clear in the above criterion is what exactly
"inconsistent state" (or "intermediate state") means. For instance, if
Git gets killed during commit, you may have to remove .git/index.lock
manually. AFAIK, Mercury leaves the 'journal' file and you have to
run "hg recovery". Does it mean that the commit is not atomic?

Another thing here is that "git commit" is local, so I am not sure
if this question includes network operations...

> scm>         <section id="move">
> scm>             <title>Files and Directories Moves or Renames</title>
> scm>             <expl>
> scm>                 Does the system support moving a file or directory to
> scm>                 a different location while still retaining the history
> scm>                 of the file? <b>Note:</b> also see the next section
> scm>                 about intelligent merging of renamed paths.
> scm>             </expl>
> 
> In my opinion this criterion is next to worthess without more in depth
> clarification of what does it mean to "support" moves or renames; as
> entries for different systems are written by different people, if it
> is not clear how to check if some feature is supported, some might
> write 'no' for some system A, and some other person can write 'yes'
> for other system B, even if the support is better in system A than in
> system B (and would be considered enough, i.e. 'yes' answer, by the
> creator of this criterion).
> 
> For me the support for renames/moves and copying (see next section)
> means that:
> 
>  0.) When examining or going to some point in the history (some old
>      revision/version of a project) the state you get is _exactly_
>      the same as it was at that time, exactly the same as it was
>      recorded (comitted) then.
> 
>      For example tricks with moving *,v files in the CVS repository
>      break this assertion.

IMHO, the above assertion is assumed when we talk about renaming, as
the system that is not capable of that will not be qualified as an
SCM. Yet, there is still plenty way to interpret the above criterion.
Even in CVS, the history of the file does not disappear when you move
a file. You can just write, this file move was renamed from old-name,
so anyone can get old history without any problem. Of course, it will
require some an additional step taken manually. But if the requirement
is to see all log history with one $scm log command, you can just copy
old log into log of a newly added file. Of course, you cannot run $scm
annotate on that file and see who changed what line, but there is no
such a requirement above.

So, I agree, it should be better defined.

> 
>  1.) When examining history of a project as a whole version control
>      system tells you that file was renamed (moved). I would consider
>      having there renaming represented as copy + delete to be only
>      a partial support of this feature.

If files moving is interpreted in the sense of preserving the old history
then copy + delete fully satisfies that criterion.

However, if you defined support of file movement as ability to see that
some file when you look at the history of the whole project then
certainly copy + delete representation would not satisfy it.

So, perhaps, it should be two separate points:
- ability to preserve history of rename (with detail clarification
  of what it means)
- ability to show renames in the project history

> 
> scm>                 <s id="git">
> scm>                     Renames are supported for most practical
> scm>                     purposes.  Git even detects renames when a file has been
> scm>                     changed afterward the rename.  However, due to a peculiar
> scm>                     repository structure, renames are not recorded
> scm>                     explicitly, and Git has to deduce them (which works well
> scm>                     in practice).
> scm>                 </s>
> 
> First, a correction to above statement.  It is not due to "a peculiar
> repository structure", but due to "a design decision" (perhaps with
> link to some explanation why it was implemented this way; I planned
> to make a wiki page about 'rename tracking' vs. 'rename detection'
> with references to various mailing list messages etc., but to this
> day it was not created).

Agreed.

> 
> 
> Second, we can think about how the above statement could be improved.
> 

<long and detail explanation of how git works>

> 
> ...Now only put the above in a few short sentences to be used in
> "Better SCM Initiative" comparison table...

Git tracks content rather than file-ids, and therefore it uses heuristics
for rename detection.  This approach has an advantage of being able to
preserve history for code lines between files, which usually happens much
more often than file renaming.

> scm>                 <s id="git">
> scm>                     No. As detailed in the <a
> scm>                         href="http://git.or.cz/gitwiki/GitFaq#rename-tracking">Git
> scm>                         FAQ</a>:
> scm>                     "Git has a rename command git mv, but that is just a
> scm>                     convenience. The effect is indistinguishable from removing
> scm>                     the file and adding another with different name and the
> scm>                     same content."
> scm>                 </s>
> 
> This is of course NOT TRUE.  If the author bother checking (which
> would be helped if there was available simple shell script, or simple
> Perl script, testing 'intelligent_renames' criterion) he/she would
> notice that git does apply change to renamed file, both if file
> itself is renamed, and if directory it is in gets renamed.

Sure. But it just demonstrates that the line of reasoning, which was
clearly based on unstated assumption of how file-id tracking performs
merge in this situation leads to the wrong conclusion for Git as it is
the content tracking system, so Git does that differently.

Perhaps, it would make sense to extend GitFaq to better cover that
point, because people with other SCM background could easily conclude
that Git cannot do "intelligent merge" after reading about git-mv.

> scm>         <section id="changesets">
> scm>             <title>Changesets' Support</title>
> scm>             <expl>
> scm>                 Does the repository support changesets? Changesets are a way
> scm>                 to group a number of modifications that are relevant to each
> scm>                 other in one atomic package, that can be cancelled or 
> scm>                 propagated as needed.
> scm>             </expl>
> 
> Here it is not entirely clean what creator of "Better SCM Initiative"
> comparison table had on mind, what he meant by this.  Not all version
> control systems are changeset based; some are snapshot based.  I guess
> that for snapshot based SCM the above requirement is equivalent to
> "Whole tree commits".

Yes, it is irrelevant to being changeset or snapshot based. It is
whether modification to more than one file can be commited (and
propogated) atomically. I also suppose that those changes should be
shown in history as a single change (not many changes too different
files that took place in the same time and the same commit comment).

However, the whole tree commit is a more strict requirement than
just being able to commit a group of changes atomically. For example,
"svn ci" creates a changeset and atomically store all its modification
on the server. Yet, it is not the whole tree commit, because the result
tree may differ from the tree that you commiting (files that are not
modified by changeset may differ).

> scm>                 <s id="git">
> scm>                     Yes, Changesets are supported, 
> scm>                     and there's some flexibility in creating them.
> scm>                 </s>
> scm>            </compare>
> scm>         </section>
> 
> [Again, Git part was re-wrapped for better readibility]
> 
> In my opition, such an _empty_ addition ("there's some flexibility in
> creating them") is totally unnecessary; it adds no solid information
> (what does it mean "some flexibility") and should be removed.

Agreed. I suspect the author implied by that Git allows to stage
and commit separately chunk without commiting the whole file.
Yet, as it is worded above, it is useless.

> scm>         <section id="tracking_uncommited_changes">
> scm>             <title>Tracking Uncommited Changes</title>
> scm>             <expl>
> scm>                 Does the software have an ability to track the changes in the
> scm>                 working copy that were not yet committed to the repository?
> scm>             </expl>
> 
> This also should be made more clean.  Does it mean for example ability
> to tell which files have changed, or ability to diff working copy to
> either last comitted changes, or to any revision available in repository?

Also, ability to diff one or more specified files in the working copy to
some specified revision.

> scm>     <section id="technical_status">
> scm>         <title>Technical Status</title>
> scm>         <section id="documentation">
> scm>             <title>Documentation</title>
> scm>             <expl>
> scm>                 How well is the system documented? How easy is it to
> scm>                 get started using it?
> scm>             </expl>
> scm>             <compare>
> scm>                 <s id="git">
> scm>                     Medium. The short help is too terse and obscure.
> scm>                     The man pages are extensive, but tend to be confusing.
> scm>                     The are many tutorials.
> scm>                 </s>
> scm>             </compare>
> scm>         </section>
> 
> That of course depends on your opinion.  I would say "Good", now that
> there is "Git User's Manual" distributed with Git, and now that there
> started semi-official "Git Community Book" (http://book.git-scm.com).

Interesting that versioncontrolblog, which, if I am not mistaken, is
Alexey's site, states for Git Documentation:

| Good. There is extensive documentation for every command, and many
| tutorials.

http://www.versioncontrolblog.com/comparison/Git/index.html

So, I am not sure were the word "Medium" came from.


Dmitry
