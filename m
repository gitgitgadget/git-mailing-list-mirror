From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [ANNOUNCE] Stacked Git 0.15-rc2
Date: Fri, 21 Aug 2009 23:25:58 +0100
Message-ID: <b0943d9e0908211525t5b25c2b2td496c98a531ff45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl Wiberg <kha@treskal.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 22 00:26:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MecYi-0006dJ-DB
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 00:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933023AbZHUWZ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2009 18:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932982AbZHUWZ7
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 18:25:59 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:51567 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932973AbZHUWZ6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2009 18:25:58 -0400
Received: by bwz19 with SMTP id 19so672375bwz.37
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 15:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=r64dFF6D4dnPIRmf9DGf82pBvBaq4zwBqO9xsJZosro=;
        b=LL80jVceHo803Jw1B5wPLts+lc0CGOqig0kMb/QrT3/zfU5r9wZspJGvDjJBGFAAJN
         m50EIc8j7snLfzRDQ02szspvbteex3CQrPEothFRhOafttq0ah86n7DGUR+hFkrMPJvm
         bJy7Vx8kGAj/ynu0/gnNidzIsuY+Bhg0Z+INw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=AOg+xtdibTCHywEVvHZlMU9EtIwll+ob1zOBrfaVBynw7nRhlcRaYJG86xGFxQvZpG
         6vA6dqIayvWvo4CXSadeETWBc2lNLj7qzgMP4NWb73NDLLG+Vg7EVkkRvqU08P94JX+f
         OnyxFL1QZuIehMHFLbFg0RRJHZiv6Pv59gmPc=
Received: by 10.223.81.65 with SMTP id w1mr386235fak.46.1250893558807; Fri, 21 
	Aug 2009 15:25:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126766>

The second release candidate for StGit 0.15 is available from the
git://repo.or.cz/stgit.git or http://download.gna.org/stgit/. Bugs can
be reported on the Git mailing list or via the project bugs page
(https://gna.org/bugs/?group=3Dstgit).

StGit is a Python application providing similar functionality to Quilt
(i.e. pushing/popping patches to/from a stack) on top of Git. These
operations are performed using Git commands and the patches are stored
as Git commit objects, allowing easy merging of the StGit patches into
other repositories using standard Git functionality.

The main changes since release 0.15-rc1 (I may miss some important
features but they can be found in the log):

- Several Emacs mode improvements
- Two new commands: prev and next
- Bug-fixes

Acknowledgements:

Gustav H=E5llberg (62):
      stgit.el: Correct documentation for stgit-insert-patch-files
      stgit.el: Remove unused variable stgit-work-ewoc
      stgit.el: Refactor: remove unused argument to two functions
      stgit.el: Run "git rm" with "-q" to reduce spam
      stgit.el: Bugfix moving symlinks to/from index
      stgit.el: Make stgit-{index,worktree}-node buffer local
      stgit new: Do not open editor if --save-template was specified
      stgit.el: Add stgit-branch-name-face
      stgit.el: Move stgit-{un,}commit to \C-c\C-{u,c}
      stgit.el: Add "U" for stgit-revert-file
      stgit.el: Change key binding for stgit-repair from "R" to "\C-u g=
"
      stgit.el: Add "R" for stgit-resolve-file
      stgit.el: Refresh from work tree when index is empty
      stgit.el: Refactor: add stgit-find-copies-harder-diff-arg helper =
function
      stgit.el: Allow showing patch on Index and Work tree
      stgit.el: Open the destination file on applied renames or copies
      stgit.el: Forbid stgit-{delete,edit,mark,rename} on index and wor=
k tree
      stgit.el: Add customizable face for "Index" and "Work tree" title=
s
      stgit.el: Make it configurable where to show index and work tree
      stgit.el: Default to expanding index and work tree
      stgit.el: Garbage collect selected patches on reload
      stgit.el: Document stgit-select properly
      stgit.el: Allow operating on the end of each line
      stgit.el: Refactor: simplify temporary marker handling
      stgit.el: Fix face "spilling" in some places
      stgit.el: Refactor: simplify stgit-patch-pp a bit
      stgit.el: Add "t i/u" for showing files ignored by or unknown to =
git
      stgit.el: Move point properly after stgit-{file-toggle-index,relo=
ad}
      stgit.el: Handle negative argument to stgit-{un,}commit
      stgit.el: Rename stgit-expand-find-copies-harder to
stgit-find-copies-harder
      stgit.el: Handle unmerged files better
      stgit.el: Add "d" for a few diff commands, similar to git.el
      stgit.el: Ignore space in diff with prefix argument
      stgit.el: Set patch names to be word syntax throughout
      stgit.el: Add stgit-redo as C-c C-_ and C-c C-/
      stgit.el: Verify that we're running on Emacs 22 or later
      stgit.el: Default to showing index and work tree
      stgit.el: Bugfix listing copied/renamed files
      stgit.el: Abbreviate renames/copies with common prefix/suffix
      stgit.el: Move point correctly after stgit-revert-file
      stgit.el: Move point in sane way after stgit-file-toggle-index on=
 renames
      stgit.el: Allow moving ignored files to index
      stgit.el: Minor documentation corrections
      stgit.el: Bugfix mode change display
      stgit.el: Add better help text for stgit-mode
      stgit.el: Add C-c C-b for stgit-rebase
      stgit.el: Improve use of def{group,custom,face}
      stgit.el: Bugfix of stgit-move-patches to top of stack
      stgit.el: Fix problem where standard-output isn't bound correctly
      stgit.el: Bugfix "P" when point is not on a patch line
      stgit.el: Fix some incorrect indentation
      stgit.el: Add +/- to expand/collapse selected patches
      stgit.el: Allow revert on index and work tree
      stgit.el: Allow toggle-index on index and work tree
      stgit.el: Verify we're in stgit-mode before running commands
      stgit.el: Add stgit-toggle-mark
      stgit.el: Add menu bar menu
      stgit.el: Add flags to stgit-patches-marked-or-at-point
      stgit.el: Consistently use "marked" about marked patches
      stgit.el: Make sure "M" retains the order of the patches
      stgit.el: Allow "P" to operate on all marked files
      stgit.el: Improve stgit-mode help text slightly

David K=E5gedal (15):
      stgit.el: Use declare to hint the debugger and indentation
      stgit.el: Remove the unused allow-file parameter to stgit-patch-a=
t-point
      stgit.el: Rename stgit-toggle-patch-file-list to stgit-select-pat=
ch
      stgit.el: Use an 'entry-type text property
      stgit.el: Use a defstruct to store patch data
      stgit.el: Use ewoc to keep track of the patch list.
      stgit.el: Invalidate ewoc node when marking or unmarking instead
of modifying buffer directly
      stgit.el: Get rid of the stgit-patchsym property
      stgit.el: Refactor file list formatting
      stgit.el: Use ewoc to keep track of the file list.
      stgit.el: Add work tree and index as pseudo-patches
      stgit.el: Add the stgit-file-toggle-index command
      stgit.el: Add stgit-toggle-worktree to toggle visibility of
index and working tree
      stgit.el: Only refresh the relevant parts when the index or
worktree changes
      stgit.el: Add stgit-new-and-refresh command

Catalin Marinas (10):
      Merge commit 'kha/safe'
      Set the LESS environment if the pager is 'less'
      Fix the import --url command
      Merge commit 'kha/safe'
      Handle multi-line Subject header better
      Improve the description/diff splitting when parsing patches
      Only get the first line from 'git describe --all'
      Reverse commit 9876a650 - return the first line from git describe
      Add release notes file
      Add the next/prev commands to the RELEASENOTES file

Karl Wiberg (8):
      Karl got married
      t2800: Adapt to changes in git's conflict markers
      Work around performance bug in subprocess.Popen.communicate()
      Merge branch 'proposed' of git://github.com/gustavh/stgit
      Release notes: Turn the 0.15-rc1 release notes into 0.15 release =
notes
      Release notes: Reformat for better legibility, and update
      Documentation: Rename remaining link macros
      Tutorial: Use the new StGit repo URL in clone example

Hannes Eder (2):
      fix "stg float -s FILE" for FILE !=3D "-"
      Add 'stg prev' and 'stg next'

Chris Packham (1):
      Re-send [StGit BUG/PATCH] config.py: fix unset


--=20
Catalin
