From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 12/17] Documentation/git-ls-remote.txt: Add -h and -t.
Date: Fri, 9 Dec 2005 00:28:05 +0100
Message-ID: <11340844853230-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
References: <11340844853961-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <nikolai@bitwi.se>
X-From: git-owner@vger.kernel.org Fri Dec 09 00:30:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkVCK-0004lM-Iu
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 00:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbVLHX2X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 18:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbVLHX2W
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 18:28:22 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:19662 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932732AbVLHX2P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 18:28:15 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20051208232814.VWYT17186.mxfep02.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Fri, 9 Dec 2005 00:28:14 +0100
Received: from c-fa2b70d5.018-10-67626713.cust.bredbandsbolaget.se (HELO puritan.petwork) ([213.112.43.250])
  by ironport.bredband.com with ESMTP; 09 Dec 2005 00:28:33 +0100
X-BrightmailFiltered: true
X-IronPort-AV: i="3.99,232,1131318000"; 
   d="scan'208"; a="16674753:sNHT37480869"
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id BC1D8ADFF7;
	Fri,  9 Dec 2005 00:28:05 +0100 (CET)
In-Reply-To: <11340844853961-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13392>

-h and -t are aliases for --heads and --tags to git-ls-remote.

Signed-off-by: Nikolai Weibull <nikolai@bitwi.se>

---

 Documentation/git-ls-remote.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

763853d9c9f2b9c0f5c76138f081d13640a24666
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index c0a80d4..66fe60f 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -17,7 +17,7 @@ Displays the references other repository
 
 OPTIONS
 -------
---heads --tags::
+-h|--heads, -t|--tags::
 	Limit to only refs/heads and refs/tags, respectively.
 	These options are _not_ mutually exclusive; when given
 	both, references stored in refs/heads and refs/tags are
-- 
0.99.9l
