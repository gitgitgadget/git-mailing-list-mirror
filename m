From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] Documentation/branch: split description into subsections
Date: Sun, 30 Jan 2011 15:33:55 -0600
Message-ID: <20110130213355.GB10039@burratino>
References: <AANLkTin3Tfcf=WJHJdSA9TwhFXQfaMrnm5+YEWWjo=qj@mail.gmail.com>
 <20110130160556.GI5713@localhost.localdomain>
 <20110130213258.GA10039@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Sm/Do28=?= Paulo Melo de Sampaio <jpmelos@gmail.com>,
	GIT Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Jan 30 22:34:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjeuZ-000712-1l
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 22:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697Ab1A3VeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 16:34:08 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45709 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488Ab1A3VeH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jan 2011 16:34:07 -0500
Received: by yxt3 with SMTP id 3so1729012yxt.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 13:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Y4DgmL26vSNUSQAXg+/V9mC4ybI/yvDr7V3O1Dn7YD8=;
        b=BAWK4f0cMG83BqT7hpnJiuCdAyJglvJZf0MlYO/J+TInFri/g7mBlLTpvsamcPowr7
         KBdHueHY5PvVlHYTliBsKAsMK4aIiXCqnrVIpl/tssnG+zQ8zpK5w1RZw5eVKLUMhWjW
         g4MT5Dr7uWTLzo8XL0DEEWJFLemCaIGvUwD+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ha40fx1N4ZxNNU8F3ygT5AU1Lj4fwgaZZyUTsv4QGPGInLVHlme9w5yAIFkojX/oOE
         ElbenZoREU5sc7K0W1WmSd7OUG8O5Li46WUSyWmrIl7qDdNjNKTc3PgVslL0YjPVTaYn
         ofyJGxPl//9pZziJIbvSqW5V15rbf5khbqymM=
Received: by 10.150.12.13 with SMTP id 13mr7170731ybl.59.1296423246239;
        Sun, 30 Jan 2011 13:34:06 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id p32sm13002187ybk.8.2011.01.30.13.34.04
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 Jan 2011 13:34:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110130213258.GA10039@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165702>

Add headings for each form of the "git branch" command.  Hopefully
this will make the description easier to read straight through without
getting lost and help technical writers to see what needs improvement
in the treatment of each form.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-branch.txt |   53 +++++++++++++++++++++++------------------
 1 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 9106d38..d3eeb94 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -18,25 +18,30 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-With no arguments, existing branches are listed and the current branch will
-be highlighted with an asterisk.  Option `-r` causes the remote-tracking
-branches to be listed, and option `-a` shows both.
+'git branch' [-r | -a]::
+	With no arguments, existing branches are listed and the current
+	branch will be highlighted with an asterisk.
+	Option `-r` causes the remote-tracking branches to be listed,
+	and option `-a` shows both.
 
-With `--contains`, shows only the branches that contain the named commit
-(in other words, the branches whose tip commits are descendants of the
-named commit).  With `--merged`, only branches merged into the named
-commit (i.e. the branches whose tip commits are reachable from the named
-commit) will be listed.  With `--no-merged` only branches not merged into
-the named commit will be listed.  If the <commit> argument is missing it
-defaults to 'HEAD' (i.e. the tip of the current branch).
-
-The command's second form creates a new branch head named <branchname>
-which points to the current 'HEAD', or <start-point> if given.
+'git branch' (--contains | --merged | --no-merged) [<commit>]::
+	With `--contains`, shows only the branches that contain the
+	named commit (in other words, the branches whose tip commits are
+	descendants of the named commit).  With `--merged`, only
+	branches merged into the named commit (i.e. the branches whose
+	tip commits are reachable from the named commit) will be listed.
+	With `--no-merged` only branches not merged into the named
+	commit will be listed.  If the <commit> argument is missing it
+	defaults to 'HEAD' (i.e.  the tip of the current branch).
 
+'git branch' <branchname> [<start-point>]::
+	The command's second form creates a new branch head named <branchname>
+	which points to the current 'HEAD', or <start-point> if given.
++
 Note that this will create the new branch, but it will not switch the
 working tree to it; use "git checkout <newbranch>" to switch to the
 new branch.
-
++
 When a local branch is started off a remote-tracking branch, git sets up the
 branch so that 'git pull' will appropriately merge from
 the remote-tracking branch. This behavior may be changed via the global
@@ -44,16 +49,18 @@ the remote-tracking branch. This behavior may be changed via the global
 overridden by using the `--track` and `--no-track` options, and
 changed later using `git branch --set-upstream`.
 
-With a '-m' or '-M' option, <oldbranch> will be renamed to <newbranch>.
-If <oldbranch> had a corresponding reflog, it is renamed to match
-<newbranch>, and a reflog entry is created to remember the branch
-renaming. If <newbranch> exists, -M must be used to force the rename
-to happen.
-
-With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
-specify more than one branch for deletion.  If the branch currently
-has a reflog then the reflog will also be deleted.
+'git branch' (-m | -M) <oldbranch> <newbranch>::
+	With a '-m' or '-M' option, <oldbranch> will be renamed to <newbranch>.
+	If <oldbranch> had a corresponding reflog, it is renamed to match
+	<newbranch>, and a reflog entry is created to remember the branch
+	renaming. If <newbranch> exists, -M must be used to force the rename
+	to happen.
 
+'git branch' (-d | -D) <branchname>::
+	With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
+	specify more than one branch for deletion.  If the branch currently
+	has a reflog then the reflog will also be deleted.
++
 Use -r together with -d to delete remote-tracking branches. Note, that it
 only makes sense to delete remote-tracking branches if they no longer exist
 in the remote repository or if 'git fetch' was configured not to fetch
-- 
1.7.4.rc3
