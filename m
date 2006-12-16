X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Sat, 16 Dec 2006 15:10:53 -0800
Message-ID: <7vtzzva136.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 23:11:49 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34654>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvih0-0008Q9-VU for gcvg-git@gmane.org; Sun, 17 Dec
 2006 00:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422712AbWLPXK7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 18:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422770AbWLPXK7
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 18:10:59 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:43553 "EHLO
 fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1422712AbWLPXK5 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 18:10:57 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216231053.QTWB18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Sat, 16
 Dec 2006 18:10:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zbB51V00M1kojtg0000000; Sat, 16 Dec 2006
 18:11:05 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

At the end is a list of stuff merged to 'master' since the last
announcement.

----------------------------------------------------------------

Andy Parkins (1):
      git-status always says what branch it's on

Brian Gernhardt (2):
      Add --add option to git-repo-config
      Make git-diff documentation use [--] when it should.

Johannes Schindelin (3):
      INSTALL: no need to have GNU diff installed
      git-show: grok blobs, trees and tags, too
      Document git-merge-file

Junio C Hamano (7):
      Revert "git-diff: Introduce --index and deprecate --cached."
      git-svn: allow both diff.color and color.diff
      Update git-diff documentation
      git-fetch: make it work from within a subdirectory.
      git-reset: make it work from within a subdirectory.
      git-reset [--mixed] <tree> [--] <paths>...
      merge: give a bit prettier merge message to "merge branch~$n"

Luben Tuikov (1):
      Export PERL_PATH

Nicolas Pitre (2):
      repacked packs should be read-only
      make commit message a little more consistent and conforting

Quy Tonthat (1):
      git-clone documentation

Shawn Pearce (7):
      Bypass expensive content comparsion during rename detection.
      Avoid accessing a slow working copy during diffcore operations.
      Provide more meaningful output from 'git init-db'.
      Enable reflogs by default in any repository with a working directory.
      Teach bash the new features of 'git show'.
      Suggest use of "git add file1 file2" when there is nothing to commit.
      Align section headers of 'git status' to new 'git add'.

