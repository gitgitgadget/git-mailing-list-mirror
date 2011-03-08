From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/3] git-log.txt,rev-list-options.txt: -n/--max-count is commit limiting
Date: Tue,  8 Mar 2011 09:31:25 +0100
Message-ID: <4c0ad5a9af1d18e59a7e820349a531f220cbf776.1299572814.git.git@drmicha.warpmail.net>
References: <4D75E92C.1090506@drmicha.warpmail.net>
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 09:35:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwsNf-0002EB-LL
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 09:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756221Ab1CHIe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 03:34:56 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:59834 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753459Ab1CHIez (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2011 03:34:55 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 01A0220B19;
	Tue,  8 Mar 2011 03:34:54 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 08 Mar 2011 03:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=Wt83idOTH+mbEZa11NfzpmbDRRY=; b=ZyD91xK8ItMH9eEvDh5Qeasn8hWROsdw9S9xcl3X3lkmMylA1D8pXIYFFGZBdbP+ZFmt80t5iSTjRXWIOhVebJeryFFpOm6VtfDgZedJ4U2XLJChLKOvvSTRHt5xIuGbdYVLkz98Lll38nidCd0e0VYgKV7Ysmwv5qsGeKZ/UOE=
X-Sasl-enc: nN1vhO3UwbsJSS4VTxb9Kl+iv1uWJY8QPpSH7sZzu366 1299573294
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7608C407B0B;
	Tue,  8 Mar 2011 03:34:54 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.299.g567d7.dirty
In-Reply-To: <4D75E92C.1090506@drmicha.warpmail.net>
In-Reply-To: <2862dfc9969beb42636ec44292d3509ddb215285.1299572814.git.git@drmicha.warpmail.net>
References: <2862dfc9969beb42636ec44292d3509ddb215285.1299572814.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168643>

and therefore applied after commit ordering and formatting options, in
particular --reverse. Say so.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-log.txt          |    1 +
 Documentation/rev-list-options.txt |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index ff41784..48c1715 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -25,6 +25,7 @@ OPTIONS
 
 -<n>::
 	Limits the number of commits to show.
+	Note that this is a commit limiting option, see below.
 
 <since>..<until>::
 	Show only commits between the named two commits.  When
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 76add13..adcafa0 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -158,7 +158,8 @@ Commit Limiting
 
 Besides specifying a range of commits that should be listed using the
 special notations explained in the description, additional commit
-limiting may be applied.
+limiting may be applied. Note that they are applied before commit
+ordering and formatting options, such as '--reverse'.
 
 --
 
-- 
1.7.4.1.299.g567d7.dirty
