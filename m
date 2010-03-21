From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/4] Documentation/urls: Remove spurious example markers
Date: Sun, 21 Mar 2010 18:30:18 +0100
Message-ID: <837485763fd0598576e0c9470ae80f05750900e4.1269192495.git.git@drmicha.warpmail.net>
References: <cover.1269192495.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 18:30:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtOym-00035z-Hu
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 18:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232Ab0CURaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 13:30:16 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:37451 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753220Ab0CURaM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Mar 2010 13:30:12 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 75F73E9C32;
	Sun, 21 Mar 2010 13:30:12 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sun, 21 Mar 2010 13:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=CG/o12/ypXTMZt+qL7HI9AqFIh8=; b=R/t82Ew3tEBAQ26WRVgPjpS0Sk0skJ3uT78m4d7rSpAvTMAcJmwaz2DFB1gUFvc+MzW/jtKD8CCjA2MrVaJbAZQhxfz37bet6O1yRsuiRIEAG2zbrqjAPJZ40cr9mPlBkzLmpFBHwgtsJTPGQ8BCzqJpG+4Vo+RQABlGqSe40yg=
X-Sasl-enc: lBdSZS2DPt1eRuDe+SYmJZJBHHA2IKph0qizQZdJymWt 1269192611
Received: from localhost (p3EE280DF.dip0.t-ipconnect.de [62.226.128.223])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AED87B75C;
	Sun, 21 Mar 2010 13:30:11 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.2.358.g30511
In-Reply-To: <cover.1269192495.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142843>

In urls.txt (which is included from git-{clone,fetch,push}.txt)
several item lists are surrounded by example block markers. This is
problematic for two reasons:

- None of these lists are example lists, so they should not be marked as
  such semantically.
- The html output looks weird (bulleted list with left sidebar).

Therefore, remove the example block markers. Output by the man backend
is uneffected.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/urls.txt |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index d813ceb..459a394 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -4,7 +4,6 @@ GIT URLS[[URLS]]
 One of the following notations can be used
 to name the remote repository:
 
-===============================================================
 - rsync://host.xz/path/to/repo.git/
 - http://host.xz{startsb}:port{endsb}/path/to/repo.git/
 - https://host.xz{startsb}:port{endsb}/path/to/repo.git/
@@ -14,7 +13,6 @@ to name the remote repository:
 - ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/
 - ssh://{startsb}user@{endsb}host.xz/~user/path/to/repo.git/
 - ssh://{startsb}user@{endsb}host.xz/~/path/to/repo.git
-===============================================================
 
 SSH is the default transport protocol over the network.  You can
 optionally specify which user to log-in as, and an alternate,
@@ -23,18 +21,14 @@ username expansion, as does the native git protocol, but
 only the former supports port specification. The following
 three are identical to the last three above, respectively:
 
-===============================================================
 - {startsb}user@{endsb}host.xz:/path/to/repo.git/
 - {startsb}user@{endsb}host.xz:~user/path/to/repo.git/
 - {startsb}user@{endsb}host.xz:path/to/repo.git
-===============================================================
 
 To sync with a local directory, you can use:
 
-===============================================================
 - /path/to/repo.git/
 - file:///path/to/repo.git/
-===============================================================
 
 ifndef::git-clone[]
 They are mostly equivalent, except when cloning.  See
-- 
1.7.0.2.358.g30511
