From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git at Better SCM Initiative comparison of VCS (long)
Date: Sun, 14 Sep 2008 19:48:05 +0200
Message-ID: <200809141948.07160.jnareb@gmail.com>
References: <200809131906.18746.jnareb@gmail.com> <20080914144306.GF28210@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Alexey Mahotkin <squadette@gmail.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 19:49:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kevix-00016F-Dh
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 19:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131AbYINRsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 13:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753305AbYINRsS
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 13:48:18 -0400
Received: from gv-out-0910.google.com ([216.239.58.188]:42794 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623AbYINRsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 13:48:16 -0400
Received: by gv-out-0910.google.com with SMTP id e6so763671gvc.37
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=pwJgqB6J0CPGykH5pxpvGa9SgBno+C5J/jgl6VbNTpM=;
        b=tfDqDQBojp6k2En3Y03fyLUiZatgNfgP/d25wcs6PlnxYydkaJtIAA4dDBbaGcznkV
         LQqIakYMnOAaivRo2kOEVkJQ3gZ03XfcgYeaywYa+MboHb0PoZIuUHeTFmh59qdg47fx
         FWp5BdivS3WStGPwgviXOzrpIa6nH7Tfe8ajs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dUQtkA2vO0VtyfzbKeceKaJrym7BJE4DU8z5WF3X4iFVYKyJZDLCMnJOhKeWlA/ins
         6SKWPCykyr4eVN0c9zHL1oWyDQ2E6UydyTAUO3o5L70PkDFnyVZk7xv02V/D51U0YI7a
         R+GtS1l4cNNDvAkQI4ZYqHXIuuM3jq35D4zSY=
Received: by 10.103.221.5 with SMTP id y5mr4767358muq.34.1221414492565;
        Sun, 14 Sep 2008 10:48:12 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.251.193])
        by mx.google.com with ESMTPS id w5sm5243449mue.10.2008.09.14.10.48.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 10:48:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080914144306.GF28210@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95850>

On Sun, 14 Sep 2008, Dmitry Potapov wrote:
> 
> I have added Alexey Mahotkin in CC, who is allegedly the author of that
> information about Git that you can read on the better-scm site.

Did you forwarded him my original email, I should I do it?


I'm sorry about that, I should have tried to find original author
of Git entry on Better SCM Initiative comparison table, and CC him.
As excuse I have the fact that while instructions how to add new
SCM to the table are easy to find and quite detailed, this is not
the case for trying to correct information in it, including how to
find original authors.

By the way, perhaps I haven't stressed this like I should, but the
most important thing I wanted to ask git list about, besides insight
in my comments and proposal for changes, was if it is possible
using current hooks infrastructure to restrict changes coming from
some account in such a way as to allow it only if all changes are
restricted to specified directory.  In short if "Repository Permissions"
_can_ be implemented on per-directory and/or per-file basis (never
mind the fact that it is better to use social means rather than
technical restrictions, and distributed SCM are good at social solution
of a 'honors system').


> On Sat, Sep 13, 2008 at 07:06:16PM +0200, Jakub Narebski wrote:
> > 
> > I have thought about trying yet another time... but Git was already
> > added; see http://better-scm.berlios.de/news/changes-2008-08-07/
> 
> Interesting, the site still mentions Git as missing in a few places.
> For instance, when you click on Git in the list of alternatives, you
> get this: http://better-scm.berlios.de/alternatives/git/
> and then when you got to FAQ, you can read this:
> 
> | The reason it's not there is that while many people have complained
> | about its absense, no one suitable has volunteered to become its
> | champion and supplied a good enough patch. [...]

Well, I have also noticed that, and I have planned on mentioning this
discrepancy when sending corrections for Git for SCM comparison table
to Shlomi Fish / Better SCM Initiative.

> | In addition to everything that was said here, it seems that the
> | originator and maintainer of the site and comparison is now banned
> | from sending messages to vger.kernel.org, which hosts several
> | Linux-kernel-related mailing-lists, including the git one. This has
> | interfered with some of his Linux-related open-source work, including
> | trying to find a "Better SCM" maintainer for git. This is unfortunate,
> | but changing this situation, is currently beyond his control.
> 
> Source: http://better-scm.berlios.de/faq/#git-missing
> 
> I am surprised to hear that Shlomi Fish is banned...

Well, anti-SPAM filter at vger.kernel.org is rather heavy handed; it
stopped a few legitimate posts of mine, and even a few patches.
However admins are responsive and reasonable, so I wonder why Shlomi
Fish couldn't solve this issue.

I wonder if it is perhaps a case of strange email headers, or
something...

> > scm>     <section id="repos_operations">
> > scm>         <title>Repository Operations</title>
> > scm>         <section id="atomic_commits">
> > scm>             <title>Atomic Commits</title>
> > scm>             <expl>
> > scm>                 Support for atomic commits means that if an
> > scm>                 operation on the repository is interrupted
> > scm>                 in the middle, the repository will not be
> > scm>                 left in an inconsistent state. Are the
> > scm>                 check-in operations atomic, or can
> > scm>                 interrupting an operation leave the
> > scm>                 repository in an intermediate state?
> > scm>             </expl>
> > 
> > Here I think the explanation of a criterion (feature) is clear enough.
> > I might have added that "interruption" include killing of a process
> > during for example commit, lack of disk space for a full commit, or
> > a network fail during network operation (fetch or push, or equivalent).
> 
> My initial reaction was to say that killing a process with -9 is not
> what you expect to see in practice, but a second later, I realized how
> wrong I was. Lack of memory may cause that the process gets killed with
> -9, and it has been observed in practice (at least, in case of Mercurial
> repo): http://norman.walsh.name/2007/08/09/mercurial

Well, kill -9 might be not very common, but interrupting for example
fetch process which looks to take too long, or some operation that you
found shouldn't be run, with ^C is I think more common.

> Another thing that is not clear in the above criterion is what exactly
> "inconsistent state" (or "intermediate state") means. For instance, if
> Git gets killed during commit, you may have to remove .git/index.lock
> manually. AFAIK, Mercury leaves the 'journal' file and you have to
> run "hg recovery". Does it mean that the commit is not atomic?

IMHO "atomic commits" (or rather "atomic operations", see below) is
about commit being either in full, or not done at all.  The fact
that SCM might need some manual steps to recover from failure shouldn't
factor in evaluating this criterion.

> Another thing here is that "git commit" is local, so I am not sure
> if this question includes network operations...

Well, I think this session would be better titled "Atomic Operations"
or just "Atomicity".  Although I'm not sure if for example in Git
all operations are atomic under all conditions...

But even if we leave it "Atomic Commits", as for centralized SCM
commit includes network operation, to have centralized and distributed
SCM on equal footing, for distributed SCM this in my opinion should
mean both atomic commit, and atomic push.  (And that should be stated
explicitly in the description...)

> > scm>         <section id="move">
> > scm>             <title>Files and Directories Moves or Renames</title>
> > scm>             <expl>
> > scm>                 Does the system support moving a file or directory to
> > scm>                 a different location while still retaining the history
> > scm>                 of the file? <b>Note:</b> also see the next section
> > scm>                 about intelligent merging of renamed paths.
> > scm>             </expl>
> > 
> > In my opinion this criterion is next to worthess without more in depth
> > clarification of what does it mean to "support" moves or renames; as
> > entries for different systems are written by different people, if it
> > is not clear how to check if some feature is supported, some might
> > write 'no' for some system A, and some other person can write 'yes'
> > for other system B, even if the support is better in system A than in
> > system B (and would be considered enough, i.e. 'yes' answer, by the
> > creator of this criterion).
> > 
> > For me the support for renames/moves and copying (see next section)
> > means that:
> > 
> >  0.) When examining or going to some point in the history (some old
> >      revision/version of a project) the state you get is _exactly_
> >      the same as it was at that time, exactly the same as it was
> >      recorded (comitted) then.
> > 
> >      For example tricks with moving *,v files in the CVS repository
> >      break this assertion.
> 
> IMHO, the above assertion is assumed when we talk about renaming, as
> the system that is not capable of that will not be qualified as an
> SCM. Yet, there is still plenty way to interpret the above criterion.
> Even in CVS, the history of the file does not disappear when you move
> a file. You can just write, this file move was renamed from old-name,
> so anyone can get old history without any problem. Of course, it will
> require some an additional step taken manually. But if the requirement
> is to see all log history with one $scm log command, you can just copy
> old log into log of a newly added file. Of course, you cannot run $scm
> annotate on that file and see who changed what line, but there is no
> such a requirement above.

I have written this obvious requirement (that it is "obvious" can be
seen in the fact that it got number '0' -- zero -- and not '1'; but
perhaps it was too subtle) to exclude CVS "support" for renames by
copying *,v file to new name, as after this operation if you would
checkout old revision you would get extra file, the new name one.
So this 'solution' wouldn't satisfy this requirement.

> So, I agree, it should be better defined.

Nice to be in agreement.

It would be best if there was some automated test for each criterion,
or at least description how to check if SCM fulfils it; not necessary
visible in the table by default.

> >  1.) When examining history of a project as a whole version control
> >      system tells you that file was renamed (moved). I would consider
> >      having there renaming represented as copy + delete to be only
> >      a partial support of this feature.
> 
> If files moving is interpreted in the sense of preserving the old history
> then copy + delete fully satisfies that criterion.
> 
> However, if you defined support of file movement as ability to see that
> some file when you look at the history of the whole project then
> certainly copy + delete representation would not satisfy it.

Well, I would consider 'copy + delete' as "good enough" solution; not
perfect, but enough for most cases.

> So, perhaps, it should be two separate points:
> - ability to preserve history of rename (with detail clarification
>   of what it means)
> - ability to show renames in the project history

That are points '1' and '2' on my list, perhaps stated bit differently:
showing renames in full history / history of project as whole, and
following history of a single file across renames.
 
> > scm>                 <s id="git">
> > scm>                     Renames are supported for most practical
> > scm>                     purposes.  Git even detects renames when a file has been
> > scm>                     changed afterward the rename.  However, due to a peculiar
> > scm>                     repository structure, renames are not recorded
> > scm>                     explicitly, and Git has to deduce them (which works well
> > scm>                     in practice).
> > scm>                 </s>
[...]
 
> > Second, we can think about how the above statement could be improved.
> > 
> 
> <long and detail explanation of how git works>
> 
> > 
> > ...Now only put the above in a few short sentences to be used in
> > "Better SCM Initiative" comparison table...
> 
> Git tracks content rather than file-ids, and therefore it uses heuristics
> for rename detection.  This approach has an advantage of being able to
> preserve history for code lines between files, which usually happens much
> more often than file renaming.

I would rather write

  Renames are supported for most practical purposes[1]. By design Git
  does heuristic <i>rename detection</i> (based on similarity score of
  pathnames and file contents), instead of doing rename tracking (which
  usually is based on some kind of file-ids).  This approach allows for
  more generic content tracking of code movement (which usually happens
  much often than wholesame file renaming), e.g. in "git blame -C -C".

  Footnotes:
  [1] "git log --follow <i>filename</i>" works only for very simple
      history currently; rename detection gets confused by empty files
      and files consisting mainly of boilerplate (e.g. license text).

But this also could be I think improved.


BTW. I wouldn't mention problem with 'new files in renamed directories',
which is IMHO separate issue, and contrary to what Mark Shuttleworth
wrote in "Renaming is the killer app of distributed version control"
(http://www.markshuttleworth.com/archives/123) that part of rename
support is not that important.  Especially that I doubt that it was
tested / checked for other SCM in the table.

> > scm>                 <s id="git">
> > scm>                     No. As detailed in the <a
> > scm>                         href="http://git.or.cz/gitwiki/GitFaq#rename-tracking">Git
> > scm>                         FAQ</a>:
> > scm>                     "Git has a rename command git mv, but that is just a
> > scm>                     convenience. The effect is indistinguishable from removing
> > scm>                     the file and adding another with different name and the
> > scm>                     same content."
> > scm>                 </s>
> > 
> > This is of course NOT TRUE.  If the author bother checking (which
> > would be helped if there was available simple shell script, or simple
> > Perl script, testing 'intelligent_renames' criterion) he/she would
> > notice that git does apply change to renamed file, both if file
> > itself is renamed, and if directory it is in gets renamed.
> 
> Sure. But it just demonstrates that the line of reasoning, which was
> clearly based on unstated assumption of how file-id tracking performs
> merge in this situation leads to the wrong conclusion for Git as it is
> the content tracking system, so Git does that differently.

Well, if you are not sure, test it.  I did this; admittedly you has
to take care for your test files to have some more content to better
resemble real-life examples for Git contents similarity based rename
detection to work.

Side note: I _think_ that usually if rename detection fails, 3-way
merge would fail too, where by fail I mean the situation where it
is hard to resolve textual conflict, not that there is conflict.

> Perhaps, it would make sense to extend GitFaq to better cover that
> point, because people with other SCM background could easily conclude
> that Git cannot do "intelligent merge" after reading about git-mv.

That is a fact that the section in GitFaq about tracking renames
http://git.or.cz/gitwiki/GitFaq#rename-tracking should be cleaned up
(for example "git annotate" is now just a convenient shortcut to
"git blame -c"; it is no longer alternate implementation), and perhaps
even rewritten.  I think that the whole reasoning about rename tracking
vs rename detection, perhaps with famous Linus Torvalds post on that
matter (if I can find it) should be put on separate page, as it will
be I think quite lenghty, while GitFaq should contain only bare-bones
consequences of such decision (and link to details).

> > scm>         <section id="changesets">
> > scm>             <title>Changesets' Support</title>
> > scm>             <expl>
> > scm>                 Does the repository support changesets? Changesets are a way
> > scm>                 to group a number of modifications that are relevant to each
> > scm>                 other in one atomic package, that can be cancelled or 
> > scm>                 propagated as needed.
> > scm>             </expl>
> > 
> > Here it is not entirely clean what creator of "Better SCM Initiative"
> > comparison table had on mind, what he meant by this.  Not all version
> > control systems are changeset based; some are snapshot based.  I guess
> > that for snapshot based SCM the above requirement is equivalent to
> > "Whole tree commits".
> 
> Yes, it is irrelevant to being changeset or snapshot based.

Errr... what I meant to say that description is clearly inspired by
changeset based SCM, but the criterion is important also for snapshot
based; it is simply not without any doubts that it refers to the
visible UI feature, and not underlying repository design (engine).

> It is whether modification to more than one file can be commited (and
> propogated) atomically. I also suppose that those changes should be
> shown in history as a single change (not many changes too different
> files that took place in the same time and the same commit comment).
> 
> However, the whole tree commit is a more strict requirement than
> just being able to commit a group of changes atomically. For example,
> "svn ci" creates a changeset and atomically store all its modification
> on the server. Yet, it is not the whole tree commit, because the result
> tree may differ from the tree that you commiting (files that are not
> modified by changeset may differ).

I think the gist of intent was to have revisions (revision identifiers)
refer to the state of a whole repository (or to changes to the set of
files as a whole: a changeset).

I agree that "whole tree commit" has slightly different semantics than
"supporting changesets".

> > scm>                 <s id="git">
> > scm>                     Yes, Changesets are supported, 
> > scm>                     and there's some flexibility in creating them.
> > scm>                 </s>
> > scm>            </compare>
> > scm>         </section>
> > 
> > [Again, Git part was re-wrapped for better readibility]
> > 
> > In my opition, such an _empty_ addition ("there's some flexibility in
> > creating them") is totally unnecessary; it adds no solid information
> > (what does it mean "some flexibility") and should be removed.
> 
> Agreed. I suspect the author implied by that Git allows to stage
> and commit separately chunk without commiting the whole file.
> Yet, as it is worded above, it is useless.

Hmmm... now that you stated that possibility I see how this wording can
refer to it.  Nevertheless it is irrelevant to the criterion discussed;
also Darcs which also has extra flexibility (chunk selection in
interactive git-add / git-commit were inspired by Darcs feature) doesn't
have any extra wording.

> > scm>         <section id="tracking_uncommited_changes">
> > scm>             <title>Tracking Uncommited Changes</title>
> > scm>             <expl>
> > scm>                 Does the software have an ability to track the changes in the
> > scm>                 working copy that were not yet committed to the repository?
> > scm>             </expl>
> > 
> > This also should be made more clean.  Does it mean for example ability
> > to tell which files have changed, or ability to diff working copy to
> > either last comitted changes, or to any revision available in repository?
> 
> Also, ability to diff one or more specified files in the working copy to
> some specified revision.

Right.

I'm not sure now if "Tracking Uncommitted Changes" is a good name for
this feature / criterion, but I don't have definite idea for change...

> > scm>     <section id="technical_status">
> > scm>         <title>Technical Status</title>
> > scm>         <section id="documentation">
> > scm>             <title>Documentation</title>
> > scm>             <expl>
> > scm>                 How well is the system documented? How easy is it to
> > scm>                 get started using it?
> > scm>             </expl>
> > scm>             <compare>
> > scm>                 <s id="git">
> > scm>                     Medium. The short help is too terse and obscure.
> > scm>                     The man pages are extensive, but tend to be confusing.
> > scm>                     The are many tutorials.
> > scm>                 </s>
> > scm>             </compare>
> > scm>         </section>
> > 
> > That of course depends on your opinion.  I would say "Good", now that
> > there is "Git User's Manual" distributed with Git, and now that there
> > started semi-official "Git Community Book" (http://book.git-scm.com).
> 
> Interesting that versioncontrolblog, which, if I am not mistaken, is
> Alexey's site, states for Git Documentation:
> 
> | Good. There is extensive documentation for every command, and many
> | tutorials.
> 
> http://www.versioncontrolblog.com/comparison/Git/index.html
> 
> So, I am not sure were the word "Medium" came from.

Backward compatibility^W^W Old impressions die hard, I would guess...
And the meme that git documentation is not user friendly is hard to
fight.


Thank you very much for your comments.
-- 
Jakub Narebski
Poland
