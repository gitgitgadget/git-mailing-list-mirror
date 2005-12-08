From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 5/17] Documentation/git-verify-pack.txt: added documentation for --.
Date: Fri, 9 Dec 2005 00:28:05 +0100
Message-ID: <1134084485547-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
References: <11340844853670-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <nikolai@bitwi.se>
X-From: git-owner@vger.kernel.org Fri Dec 09 00:30:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkVCN-0004lM-Uf
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 00:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730AbVLHX2S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 18:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbVLHX2R
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 18:28:17 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:14542 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932730AbVLHX2N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 18:28:13 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20051208232812.VWYO17186.mxfep02.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Fri, 9 Dec 2005 00:28:12 +0100
Received: from c-fa2b70d5.018-10-67626713.cust.bredbandsbolaget.se (HELO puritan.petwork) ([213.112.43.250])
  by ironport.bredband.com with ESMTP; 09 Dec 2005 00:28:32 +0100
X-BrightmailFiltered: true
X-IronPort-AV: i="3.99,232,1131318000"; 
   d="scan'208"; a="16674749:sNHT62766117"
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id 5ADDDADFED;
	Fri,  9 Dec 2005 00:28:05 +0100 (CET)
In-Reply-To: <11340844853670-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13398>

The -- option has been added to the documentation of git-verify-pack.

Signed-off-by: Nikolai Weibull <nikolai@bitwi.se>

---

 Documentation/git-verify-pack.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

ab7a137fa6d4629578c0d2b580189d58d556fa13
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index cd74ffd..d032280 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -8,7 +8,7 @@ git-verify-pack - Validate packed git ar
 
 SYNOPSIS
 --------
-'git-verify-pack' [-v] <pack>.idx ...
+'git-verify-pack' [-v] [--] <pack>.idx ...
 
 
 DESCRIPTION
@@ -25,6 +25,8 @@ OPTIONS
 -v::
 	After verifying the pack, show list of objects contained
 	in the pack.
+--::
+	Do not interpret any more arguments as options.
 
 OUTPUT FORMAT
 -------------
-- 
0.99.9l
