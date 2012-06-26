From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 0/9] git p4 test fixes
Date: Mon, 25 Jun 2012 21:18:16 -0400
Message-ID: <1340673505-10551-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 03:23:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjKVE-0004Kg-RH
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 03:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757967Ab2FZBS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 21:18:29 -0400
Received: from honk.padd.com ([74.3.171.149]:40021 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757814Ab2FZBS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 21:18:28 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id DD50C2E87;
	Mon, 25 Jun 2012 18:18:27 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8FC4B31383; Mon, 25 Jun 2012 21:18:25 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc2.72.gebb7ee5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200612>

This is a series of accumulated minor annoyances in
the "git p4" tests.  I've been carrying these around for
a while, now.

The big line count change here is from splitting big chunks
of t9800 out into logically separate tests.

Pete Wyckoff (9):
  git p4 test: wait longer for p4d to start
  git p4 test: use real_path to resolve p4 client symlinks
  git p4 test: simplify quoting involving TRASH_DIRECTORY
  git p4 test: never create default test repo
  git p4 test: rename some "git-p4 command" strings
  git p4 test: check for error message in failed test
  git p4 test: copy source indeterminate
  git p4 test: cleanup_git should make a new $git
  git p4 test: split up big t9800 test

 t/lib-git-p4.sh                    |  11 +-
 t/t9800-git-p4-basic.sh            | 412 +------------------------------------
 t/t9805-git-p4-skip-submit-edit.sh |   9 +-
 t/t9806-git-p4-options.sh          |  17 +-
 t/t9808-git-p4-chdir.sh            |   4 +-
 t/t9810-git-p4-rcs.sh              |   8 +-
 t/t9812-git-p4-wildcards.sh        | 147 +++++++++++++
 t/t9813-git-p4-preserve-users.sh   | 153 ++++++++++++++
 t/t9814-git-p4-rename.sh           | 206 +++++++++++++++++++
 9 files changed, 539 insertions(+), 428 deletions(-)
 create mode 100755 t/t9812-git-p4-wildcards.sh
 create mode 100755 t/t9813-git-p4-preserve-users.sh
 create mode 100755 t/t9814-git-p4-rename.sh

-- 
1.7.11.rc2.72.gebb7ee5
