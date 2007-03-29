From: Theodore Ts'o <tytso@mit.edu>
Subject: [GIT PULL] git mergetool fixes
Date: Thu, 29 Mar 2007 11:44:14 -0400
Message-ID: <11751830653554-git-send-email-tytso@mit.edu>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 17:45:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWwoK-0004BP-B7
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 17:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbXC2Pok (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 11:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbXC2Poj
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 11:44:39 -0400
Received: from thunk.org ([69.25.196.29]:36591 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030254AbXC2Poa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 11:44:30 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HWwte-0007Ix-8M; Thu, 29 Mar 2007 11:50:42 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HWwnZ-0000xI-Bb; Thu, 29 Mar 2007 11:44:25 -0400
X-Mailer: git-send-email 1.5.1.rc2.1.g8afe-dirty
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43447>

Hi Junio,

Please pull from:

        git://repo.or.cz/git/mergetool.git

To receive the following fixes (see below).  They are mostly cleanups
and portability fixes.  They also include Arjen Laarjoven's support
for Apple Mac OS X's opendiff GUI merge tool.

----

Theodore Ts'o (11):
      Fix minor formatting issue in man page for git-mergetool
      mergetool: Replace use of "echo -n" with printf(3) to be more portable
      mergetool: Don't error out in the merge case where the local file is deleted
      mergetool: portability fix: don't assume true is in /bin
      mergetool: portability fix: don't use reserved word function
      mergetool: factor out common code
      mergetool: Remove spurious error message if merge.tool config option not set
      mergetool: Fix abort command when resolving symlinks and deleted files
      mergetool: Add support for Apple Mac OS X's opendiff command
      mergetool: Make git-rm quiet when resolving a deleted file conflict
      mergetool: Clean up description of files and prompts for merge resolutions

                                                - Ted
