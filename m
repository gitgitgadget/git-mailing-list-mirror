From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 8/17] Documentation/git-cherry-pick: Add --replay and --no-commit.
Date: Fri, 9 Dec 2005 00:28:05 +0100
Message-ID: <11340844851758-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
References: <1134084485683-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <nikolai@bitwi.se>
X-From: git-owner@vger.kernel.org Fri Dec 09 00:30:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkVCQ-0004lM-7a
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 00:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbVLHX2V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 18:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbVLHX2V
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 18:28:21 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:19406 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932733AbVLHX2P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 18:28:15 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20051208232814.VWYS17186.mxfep02.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Fri, 9 Dec 2005 00:28:14 +0100
Received: from c-fa2b70d5.018-10-67626713.cust.bredbandsbolaget.se (HELO puritan.petwork) ([213.112.43.250])
  by ironport.bredband.com with ESMTP; 09 Dec 2005 00:28:32 +0100
X-BrightmailFiltered: true
X-IronPort-AV: i="3.99,232,1131318000"; 
   d="scan'208"; a="16674750:sNHT148815216"
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id 83FEAADFF0;
	Fri,  9 Dec 2005 00:28:05 +0100 (CET)
In-Reply-To: <1134084485683-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13388>

Signed-off-by: Nikolai Weibull <nikolai@bitwi.se>

---

 Documentation/git-cherry-pick.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

e0a7bc3c18f904afade2da6146aeba4c5aa68340
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index a7a883b..744f2c9 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -24,7 +24,7 @@ OPTIONS
 	With this option, `git-cherry-pick` will let you edit the commit
 	message prior committing.
 
--r::
+-r|--replay::
 	Usually the command appends which commit was
 	cherry-picked after the original commit message when
 	making a commit.  This option, '--replay', causes it to
@@ -32,7 +32,7 @@ OPTIONS
 	when you are reordering the patches in your private tree
 	before publishing.
 
--n::
+-n|--no-commit::
 	Usually the command automatically creates a commit with
 	a commit log message stating which commit was
 	cherry-picked.  This flag applies the change necessary
-- 
0.99.9l
