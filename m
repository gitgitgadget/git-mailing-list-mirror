From: Andreas Hartmetz <ahartmetz@gmail.com>
Subject: Re: git branch documentation improvements
Date: Fri, 7 May 2010 03:04:17 +0200
Message-ID: <201005070304.18141.ahartmetz@gmail.com>
References: <201005070024.41172.ahartmetz@gmail.com> <r2l2cfc40321005061559p9d3a5392rdc2b30f63a34ab9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 03:04:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OABzP-0008MG-HC
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 03:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065Ab0EGBEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 21:04:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:16541 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab0EGBEU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 May 2010 21:04:20 -0400
Received: by fg-out-1718.google.com with SMTP id d23so575842fga.1
        for <git@vger.kernel.org>; Thu, 06 May 2010 18:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=jpLfMo6xfJNY7f3/bAze6xpS4P5CrHdju6aegXRUM6M=;
        b=eI0iIH1xwKDCtvV2Vr62GgyASAtUrMTNumNVhjExSO+NSs56SUHuVwpntCFbqPYPWI
         N8+3RqOw2g9ZOIF7bofBU+sUizhtLIo8y7D9s3Ez3EYWAvpR+FGXo1XHB0nBOLlE+XkB
         DwPxUAboWqjRXbbS0dv2V3vDguBLyr6xI1tFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=Tkj0EormgZjtKjvqYXmZivZm0D7IwhMW8Es2ulDnk3vTU9gSDz2MQ/FRsLCaDBwsS6
         elz6bRW9v1AeZtAjzD8vDWBf+nFEOi/RKELN6mh06Khr/h6zzGWGA3WttqxlgGj5uBBO
         /ubI/tz9CfBM+6aBnDlPX20COhzJlG3GPy1EM=
Received: by 10.86.6.39 with SMTP id 39mr2772472fgf.4.1273194259271;
        Thu, 06 May 2010 18:04:19 -0700 (PDT)
Received: from rechenplan.localnet (brln-4dbc398e.pool.mediaWays.net [77.188.57.142])
        by mx.google.com with ESMTPS id l12sm18060009fgb.2.2010.05.06.18.04.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 18:04:18 -0700 (PDT)
User-Agent: KMail/1.13.3 (Linux/2.6.33-02063303-generic; KDE/4.4.75; x86_64; svn-1121149; 2010-04-29)
In-Reply-To: <r2l2cfc40321005061559p9d3a5392rdc2b30f63a34ab9b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146515>

On Friday 07 May 2010 00:59:22 Jon Seymour wrote:
> This patch would be easier to review, and thus more likely to be
> accepted, if the guidelines in SubmittingPatches had been followed,
> w.r.t. not using attachments to submit patches.
> 
Oops, sorry. I didn't see that file. Patch follows at the end.

> On Fri, May 7, 2010 at 8:24 AM, Andreas Hartmetz <ahartmetz@gmail.com> wrote:
> > Hello all,
> > 
> > Today I read the git branch documentation and noticed a few things,
> > mostly style and consistency related, that could easily be improved, so
> > I did just that.
> > Please consider merging the attached patch if it looks good, or tell me
> > what you don't like about it.
> > The most significant change is renaming <start-point> (or is it
> > <startpoint>...) to <branch-head> because even I as a relative beginner
> > know that a branch is defined by its (movable) head, and <start-point>
> > *does* actually specify the new branch head if I'm not mistaken.
> 
> While I agree with you start start-point is probably the wrong name
> for this parameter, I wonder whether branch-head might be too
> suggestive that the value of that parameter must itself be an existing
> branch head.
> 
> I think the term "head-commit" would be a more accurate way to
> describe the possible values of this parameter. That is, it is the
> commit that will become the head of the new branch.
> 
Yes, why not.

I noticed a problem in the second paragraph of the description of --track
where neither <start-point> nor <branch-head> nor <head-commit> works well.
Maybe I butchered the first sentence because it used to say "start point".
Either way, that first sentence looks fishy to me.
Any suggestions?

>From 3fa7cb87068cfba00c55f494b30f3773f4ce9c69 Mon Sep 17 00:00:00 2001
From: Andreas Hartmetz <ahartmetz@gmail.com>
Date: Fri, 7 May 2010 02:44:41 +0200
Subject: [PATCH] git-branch documentation improvements:
 - Use only present tense where possible
 - Use similar wording for similar things
 - Miscellaneous style improvements
 - Replace "<start-point>" with "<head-commit>" which is more in line with the
   how git actually works, and applies to all situations

Signed-off-by: Andreas Hartmetz <ahartmetz@gmail.com>
---
 Documentation/git-branch.txt |   61 ++++++++++++++++++++---------------------
 1 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 1940256..7878534 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -11,51 +11,50 @@ SYNOPSIS
 'git branch' [--color[=<when>] | --no-color] [-r | -a]
 	[-v [--abbrev=<length> | --no-abbrev]]
 	[(--merged | --no-merged | --contains) [<commit>]]
-'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
+'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<head-commit>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
 'git branch' (-d | -D) [-r] <branchname>...

 DESCRIPTION
 -----------

-With no arguments, existing branches are listed and the current branch will
-be highlighted with an asterisk.  Option `-r` causes the remote-tracking
-branches to be listed, and option `-a` shows both.
+With no arguments, local branches are listed and the current branch is
+highlighted with an asterisk.  Option `-r` lists remote-tracking
+branches, and option `-a` lists both.

-With `--contains`, shows only the branches that contain the named commit
+With `--contains`, show only the branches that contain the named commit
 (in other words, the branches whose tip commits are descendants of the
 named commit).  With `--merged`, only branches merged into the named
 commit (i.e. the branches whose tip commits are reachable from the named
-commit) will be listed.  With `--no-merged` only branches not merged into
-the named commit will be listed.  If the <commit> argument is missing it
-defaults to 'HEAD' (i.e. the tip of the current branch).
+commit) are listed.  With `--no-merged` only branches not merged into
+the named commit are listed.  If the <commit> argument is missing it
+defaults to 'HEAD', the tip of the current branch.

-The command's second form creates a new branch head named <branchname>
-which points to the current 'HEAD', or <start-point> if given.
-
-Note that this will create the new branch, but it will not switch the
+The second form of the command creates a new branch head named <branchname>
+which points to the current 'HEAD', or <head-commit> if given.
+Note that this creates the new branch, but does not switch the
 working tree to it; use "git checkout <newbranch>" to switch to the
 new branch.

 When a local branch is started off a remote branch, git sets up the
 branch so that 'git pull' will appropriately merge from
 the remote branch. This behavior may be changed via the global
-`branch.autosetupmerge` configuration flag. That setting can be
-overridden by using the `--track` and `--no-track` options.
+`branch.autosetupmerge` configuration flag. You can override the
+flag using the `--track` and `--no-track` options.

-With a '-m' or '-M' option, <oldbranch> will be renamed to <newbranch>.
+With the '-m' or '-M' command, <oldbranch> is renamed to <newbranch>.
 If <oldbranch> had a corresponding reflog, it is renamed to match
 <newbranch>, and a reflog entry is created to remember the branch
-renaming. If <newbranch> exists, -M must be used to force the rename
-to happen.
+renaming. If <newbranch> exists, -M can be used to forwe overwriting
+it.

-With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
-specify more than one branch for deletion.  If the branch currently
-has a reflog then the reflog will also be deleted.
+With the `-d` or `-D` command, `<branchname>` is deleted.  You may
+specify more than one branch to delete.  If the branch currently
+has a reflog, the reflog is also be deleted.

-Use -r together with -d to delete remote-tracking branches. Note, that it
+Use -r together with -d to delete remote-tracking branches. Note that it
 only makes sense to delete remote-tracking branches if they no longer exist
-in the remote repository or if 'git fetch' was configured not to fetch
+in the remote repository, or if 'git fetch' was configured not to fetch
 them again. See also the 'prune' subcommand of linkgit:git-remote[1] for a
 way to clean up all obsolete remote-tracking branches.

@@ -79,7 +78,7 @@ OPTIONS

 -f::
 --force::
-	Reset <branchname> to <startpoint> if <branchname> exists
+	Reset <branchname> to <head-commit> if <branchname> exists
 	already. Without `-f` 'git branch' refuses to change an existing branch.

 -m::
@@ -119,27 +118,27 @@ OPTIONS
 -t::
 --track::
 	When creating a new branch, set up configuration to mark the
-	start-point branch as "upstream" from the new branch. This
-	configuration will tell git to show the relationship between the
+	<head-commit> branch as "upstream" from the new branch. This
+	configuration tells git to show the relationship between the
 	two branches in `git status` and `git branch -v`. Furthermore,
 	it directs `git pull` without arguments to pull from the
 	upstream when the new branch is checked out.
 +
-This behavior is the default when the start point is a remote branch.
-Set the branch.autosetupmerge configuration variable to `false` if you
+This behavior is the default when the <head-commit> is a remote branch.
+Set the branch.autosetupmerge configuration flag to `false` if you
 want `git checkout` and `git branch` to always behave as if '--no-track'
 were given. Set it to `always` if you want this behavior when the
-start-point is either a local or remote branch.
+<head-commit> is either a local or remote branch.

 --no-track::
 	Do not set up "upstream" configuration, even if the
-	branch.autosetupmerge configuration variable is true.
+	branch.autosetupmerge configuration flag is true.

 --set-upstream::
 	If specified branch does not exist yet or if '--force' has been
 	given, acts exactly like '--track'. Otherwise sets up configuration
 	like '--track' would when creating the branch, except that where
-	branch points to is not changed.
+	<branchname> points to is not changed.

 --contains <commit>::
 	Only list branches which contain the specified commit.
@@ -158,7 +157,7 @@ start-point is either a local or remote branch.
 	linkgit:git-check-ref-format[1].  Some of these checks
 	may restrict the characters allowed in a branch name.

-<start-point>::
+<head-commit>::
 	The new branch head will point to this commit.  It may be
 	given as a branch name, a commit-id, or a tag.  If this
 	option is omitted, the current HEAD will be used instead.
--
1.7.0.4
