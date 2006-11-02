X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] git-clone documentation didn't mention --origin as equivalent of -o
Date: Thu, 2 Nov 2006 12:11:56 +0100
Message-ID: <200611021111.57283.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 11:12:12 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-TUID: df6c4641292fcfbc
X-UID: 145
X-Length: 911
Content-Disposition: inline
X-OriginalArrivalTime: 02 Nov 2006 11:13:04.0155 (UTC) FILETIME=[DDBC06B0:01C6FE6F]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30724>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfaUQ-00047c-VJ for gcvg-git@gmane.org; Thu, 02 Nov
 2006 12:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752845AbWKBLMD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 06:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847AbWKBLMB
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 06:12:01 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:14182 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S1752845AbWKBLMA
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 06:12:00 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Thu, 2 Nov 2006 11:13:04 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GfaUJ-0003wf-00 for <git@vger.kernel.org>; Thu, 02 Nov
 2006 11:11:59 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 Documentation/git-clone.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index f973c64..e22a036 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -75,6 +75,7 @@ OPTIONS
 	this option is used, neither the `origin` branch nor the
 	default `remotes/origin` file is created.
 
+--origin::
 -o <name>::
 	Instead of using the branch name 'origin' to keep track
 	of the upstream repository, use <name> instead.  Note
-- 
1.4.3.2
