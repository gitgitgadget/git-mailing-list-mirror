From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Wed, 14 Feb 2007 15:54:02 -0800
Message-ID: <7vtzxojnxh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 15 00:54:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHTwv-0002iW-B5
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 00:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbXBNXyG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 18:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbXBNXyF
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 18:54:05 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:33969 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbXBNXyE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 18:54:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214235403.VRDJ4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 18:54:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Pbu21W00r1kojtg0000000; Wed, 14 Feb 2007 18:54:03 -0500
X-maint-at: 204d409247e7bbc7848569462aa11a87e373c8d6
X-master-at: 78e90f89e39b112af2670516f80586163dcd56ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39774>

The next maintenance release from 'maint' branch will be 1.5.0.1
when we accumulate enough fixes worth to cut one.

The next feature release from 'master' will be 1.5.1.  I'd like
to have 6 to 8 weeks between releases, so that will be around
end of March or mid-April.  Maybe we can talk about what the
theme for that release should be in a separate thread.

Now the big release is over, I should be able to slow a little
bit down for a few days.


* The 'maint' branch has these fixes since v1.5.0

 Alexandre Julliard (2):
  git-daemon: Avoid leaking the listening sockets into child processes.
  sha1_file.c: Round the mmap offset to half the window size.

 Junio C Hamano (8):
  Documentation: Drop full-stop from git-fast-import title.
  cmd-list: add git-remote
  Makefile: update check-docs target
  Clarify two backward incompatible repository options.
  Still updating 1.5.0 release notes.
  Add RelNotes 1.5.0.1
  Make sure packedgitwindowsize is multiple of (pagesize * 2)
  GIT-VERSION-FILE: check ./version first.

 Nicolas Pitre (1):
  Minor corrections to release notes


* The 'master' branch has these since v1.5.0; this includes all
  of the above.

 Alexandre Julliard (2):
  git-daemon: Avoid leaking the listening sockets into child processes.
  sha1_file.c: Round the mmap offset to half the window size.

 Andy Parkins (2):
  Only show log entries for new revisions in hooks--update
  The "table-of-contents" in the update hook script should match the body

 Johannes Schindelin (2):
  Teach revision machinery about --reverse
  teach diff machinery about --ignore-space-at-eol

 Junio C Hamano (18):
  git-diff/git-apply: make diff output a bit friendlier to GNU patch (part 2)
  Make merge-base a built-in.
  Allow in_merge_bases() to take more than one reference commits.
  Remove git-resolve.
  Remove git-diff-stages.
  Add link to v1.5.0 documentation.
  blame: --show-stats for easier optimization work.
  Documentation: Drop full-stop from git-fast-import title.
  cmd-list: add git-remote
  Makefile: update check-docs target
  Document --ignore-space-at-eol option.
  Add RelNotes 1.5.1
  Point top-level RelNotes link at 1.5.1 release notes being prepared.
  Clarify two backward incompatible repository options.
  Still updating 1.5.0 release notes.
  Add RelNotes 1.5.0.1
  Make sure packedgitwindowsize is multiple of (pagesize * 2)
  GIT-VERSION-FILE: check ./version first.

 Nicolas Pitre (1):
  Minor corrections to release notes
