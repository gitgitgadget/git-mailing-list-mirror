From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/2] More missed `code snippets`
Date: Sun, 10 Jan 2010 13:10:55 +0100
Message-ID: <bb5d5a8040d61fd10ed199114a0a24ea79d08981.1263123648.git.trast@student.ethz.ch>
References: <48822ef1fee0a734817bad9f63e122e4d1d66106.1263123648.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 10 13:11:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTwdf-00073u-1T
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 13:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753Ab0AJMLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 07:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752725Ab0AJMLT
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 07:11:19 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:30505 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752531Ab0AJMLS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 07:11:18 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 13:11:17 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 13:10:55 +0100
X-Mailer: git-send-email 1.6.6.218.g502b0
In-Reply-To: <48822ef1fee0a734817bad9f63e122e4d1d66106.1263123648.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136571>

Squashed into the corresponding commit of the original series.
---

Additionally, I reverted

   --- i/Documentation/git-bisect.txt
   +++ w/Documentation/git-bisect.txt
   @@ -26,7 +26,7 @@ on the subcommand:
     git bisect log
     git bisect run <cmd>...

   -This command uses `git rev-list --bisect` to help drive the
   +This command uses 'git rev-list --bisect' to help drive the
    binary search process to find which change introduced a bug, given an
    old "good" commit object name and a later "bad" commit object name.

per the review.

 Documentation/config.txt |    2 +-
 Documentation/git-gc.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git i/Documentation/config.txt w/Documentation/config.txt
index 6bfd9e1..3e96a27 100644
--- i/Documentation/config.txt
+++ w/Documentation/config.txt
@@ -747,7 +747,7 @@ diff.mnemonicprefix::
 	 compares a (c)ommit and the (w)ork tree;
 `git diff --cached`;;
 	compares a (c)ommit and the (i)ndex;
-`git-diff HEAD:file1 file2`;;
+`git diff HEAD:file1 file2`;;
 	compares an (o)bject and a (w)ork tree entity;
 `git diff --no-index a b`;;
 	compares two non-git things (1) and (2).
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 771807f..189573a 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -50,7 +50,7 @@ Housekeeping is required if there are too many loose objects or
 too many packs in the repository. If the number of loose objects
 exceeds the value of the `gc.auto` configuration variable, then
 all loose objects are combined into a single pack using
-'git repack -d -l'.  Setting the value of `gc.auto` to 0
+`git repack -d -l`.  Setting the value of `gc.auto` to 0
 disables automatic packing of loose objects.
 +
 If the number of packs exceeds the value of `gc.autopacklimit`,
-- 
1.6.6.218.g502b0
