X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	SUBJ_ALL_CAPS shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.4.4.1
Date: Wed, 22 Nov 2006 18:49:28 -0800
Message-ID: <7v7ixmop1j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 23 Nov 2006 02:49:49 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32115>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gn4em-00074m-IM for gcvg-git@gmane.org; Thu, 23 Nov
 2006 03:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757278AbWKWCtl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 21:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757281AbWKWCtl
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 21:49:41 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:20981 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1757278AbWKWCtk
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 21:49:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061123024939.REVE27894.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Wed, 22
 Nov 2006 21:49:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id q2pc1V0041kojtg0000000; Wed, 22 Nov 2006
 21:49:36 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

The latest maintenance release GIT 1.4.4.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.4.1.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.4.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.4.1.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.4.1-1.$arch.rpm	(RPM)

This contains mostly small post-release fixups.

----------------------------------------------------------------

Changes since v1.4.4 are as follows:

Alexandre Julliard (1):
      gitweb: Put back shortlog instead of graphiclog in the project list.

Chris Riddoch (1):
      Move --pretty options into Documentation/pretty-formats.txt

Jim Meyering (1):
      Run "git repack -a -d" once more at end, if there's 1MB or more of not-packed data.

Johannes Schindelin (1):
      Seek back to current filepos when mmap()ing with NO_MMAP

Junio C Hamano (7):
      git-checkout: do not allow -f and -m at the same time.
      git-checkout: allow pathspec to recover lost working tree directory
      convert-objects: set _XOPEN_SOURCE to 600
      git-fetch: follow lightweit tags as well.
      do_for_each_ref: perform the same sanity check for leftovers.
      trust-executable-bit: fix breakage for symlinks
      GIT 1.4.4.1

Linus Torvalds (2):
      git-pull: allow pulling into an empty repository
      "git fmt-merge-msg" SIGSEGV

Michal Rokos (1):
      archive: use setvbuf() instead of setlinebuf()

Paolo Ciarrocchi (2):
      Teach SubmittingPatches about git-commit -s
      Doc: Make comment about merging in tutorial.txt more clear

Petr Baudis (4):
      Fix git-for-each-refs broken for tags
      git-apply: Documentation typo fix
      Documentation: Define symref and update HEAD description
      Documentation: Correct alternates documentation, document http-alternates

Rene Scharfe (4):
      sparse fix: non-ANSI function declaration
      sparse fix: Using plain integer as NULL pointer
      git-apply: slightly clean up bitfield usage
      Document git-runstatus

