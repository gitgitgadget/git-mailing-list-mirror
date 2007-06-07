From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Wed, 06 Jun 2007 19:08:56 -0700
Message-ID: <7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net>
References: <7v4pmgqrut.fsf@assigned-by-dhcp.cox.net>
	<7vhcqccnbm.fsf@assigned-by-dhcp.cox.net>
	<7vveepz8pr.fsf@assigned-by-dhcp.cox.net>
	<7vmyzv1acz.fsf@assigned-by-dhcp.cox.net>
	<7vejl0546b.fsf@assigned-by-dhcp.cox.net>
	<7v4plqoyg5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 04:09:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw7Qv-0008Bw-82
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 04:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935415AbXFGCI6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 22:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935438AbXFGCI6
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 22:08:58 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:50842 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935415AbXFGCI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 22:08:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070607020856.OISV9600.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 22:08:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8S8w1X00U1kojtg0000000; Wed, 06 Jun 2007 22:08:57 -0400
X-maint-at: 23fcdc79713c47a6a0d50762b9311c9933a60d3f
X-master-at: d44c782bbd6b0e806e056f9e8ff8cd8e426e67a3
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49339>

It has been slow on the stable front.

* The 'maint' branch has these fixes since the last announcement.

 Johannes Sixt (1):
  Accept dates before 2000/01/01 when specified as seconds since the epoch

 Michael Milligan (1):
  git-cvsimport: Make sure to use $git_dir always instead of .git sometimes

 Sam Vilain (1):
  fix documentation of unpack-objects -n


* The 'master' branch has these since the last announcement
  in addition to the above.

 Geert Bosch (1):
  Unify write_index_file functions

 Johannes Schindelin (5):
  Update to SubmittingPatches
  git-fsck: learn about --verbose
  Move buffer_is_binary() to xdiff-interface.h
  merge-recursive: refuse to merge binary files
  t5000: skip ZIP tests if unzip was not found

 Johannes Sixt (1):
  Makefile: Remove git-merge-base from PROGRAMS.

 Jon Loeliger (1):
  Add the --numbered-files option to git-format-patch.

 Josh Triplett (1):
  Fix typo in git-mergetool

 Junio C Hamano (4):
  Remove git-applypatch
  Release Notes: start preparing for 1.5.3
  git-apply: what is detected and fixed is not just trailing spaces.
  git-branch --track: fix tracking branch computation.

 Lars Hjemli (2):
  Add git-submodule command
  Add basic test-script for git-submodule

 Martin Koegler (1):
  gitweb: Handle non UTF-8 text better

 Matthias Lederhofer (2):
  add git-filter-branch to .gitignore
  make clean should remove all the test programs too

 Matthijs Melchior (1):
  Teach git-tag about showing tag annotations.

 Petr Baudis (1):
  git-applymbox: Remove command

 Pierre Habouzit (1):
  $EMAIL is a last resort fallback, as it's system-wide.

 Randal L. Schwartz (1):
  Add test-sha1 to .gitignore.

 Sam Vilain (1):
  Don't assume tree entries that are not dirs are blobs
