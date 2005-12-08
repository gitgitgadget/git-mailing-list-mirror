From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 13/17] Documentation/git-repack.txt: Add -l and -n.
Date: Fri, 9 Dec 2005 00:28:05 +0100
Message-ID: <11340844852496-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
References: <11340844853230-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <nikolai@bitwi.se>
X-From: git-owner@vger.kernel.org Fri Dec 09 00:30:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkVCI-0004lM-Tm
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 00:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732AbVLHX2a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 18:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932733AbVLHX2a
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 18:28:30 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:34766 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932732AbVLHX2X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 18:28:23 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20051208232819.VWZJ17186.mxfep02.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Fri, 9 Dec 2005 00:28:19 +0100
Received: from c-fa2b70d5.018-10-67626713.cust.bredbandsbolaget.se (HELO puritan.petwork) ([213.112.43.250])
  by ironport.bredband.com with ESMTP; 09 Dec 2005 00:28:33 +0100
X-BrightmailFiltered: true
X-IronPort-AV: i="3.99,232,1131318000"; 
   d="scan'208"; a="16674759:sNHT383221656"
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id CAB8BADFF8;
	Fri,  9 Dec 2005 00:28:05 +0100 (CET)
In-Reply-To: <11340844853230-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13396>

This adds documentation for the -l and -n options to git-repack.

Signed-off-by: Nikolai Weibull <nikolai@bitwi.se>

---

 Documentation/git-repack.txt |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

74b49b4c4f2e04066f36011215106627f3405338
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 0c1ae49..9060fe8 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,7 @@ objects into pack files.
 
 SYNOPSIS
 --------
-'git-repack' [-a] [-d]
+'git-repack' [-a] [-d] [-l] [-n]
 
 DESCRIPTION
 -----------
@@ -39,6 +39,13 @@ OPTIONS
 	After packing, if the newly created packs make some
 	existing packs redundant, remove the redundant packs.
 
+-l::
+        Pass the `--local` option to `git pack-objects`, see
+        gitlink:git-pack-objects[1].
+
+-n::
+        Do not update the server information with
+        `git update-server-info`.
 
 Author
 ------
-- 
0.99.9l
