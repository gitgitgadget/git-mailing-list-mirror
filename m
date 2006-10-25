X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: andyparkins@gmail.com
Subject: (unknown)
Date: Wed, 25 Oct 2006 15:49:52 +0100
Message-ID: <E1Gck4m-0003J1-00@dvr.360vision.com>
NNTP-Posting-Date: Wed, 25 Oct 2006 14:50:12 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-OriginalArrivalTime: 25 Oct 2006 14:52:52.0317 (UTC) FILETIME=[3F2FD8D0:01C6F845]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30061>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gck4u-0006bH-IA for gcvg-git@gmane.org; Wed, 25 Oct
 2006 16:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932390AbWJYOt5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 10:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWJYOt5
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 10:49:57 -0400
Received: from mail.360visiontechnology.com ([194.70.53.226]:48663 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S932390AbWJYOty
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 10:49:54 -0400
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Wed, 25 Oct 2006 15:52:52 +0100
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1Gck4m-0003J1-00 for <git@vger.kernel.org>; Wed, 25 Oct
 2006 15:49:52 +0100
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org

From b149c0fca7399030225750958bf5c962c3796b44 Mon Sep 17 00:00:00 2001
From: Andy Parkins <andyparkins@gmail.com>
Date: Wed, 25 Oct 2006 15:49:50 +0100
Subject: [PATCH] Make new builtin cherry match documentation for "+" and "-"
To: git@vger.kernel.org
X-TUID: 218b478df3f8d847
X-UID: 128
X-Length: 1090
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610251549.51121.andyparkins@gmail.com>

"+" and "-" don't match the documentation, where "+" means the patch /is/ in
upstream, "-" means it isn't
Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 builtin-log.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 840c742..8ded627 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -519,12 +519,12 @@ int cmd_cherry(int argc, const char **ar
 
 	while (list) {
 		unsigned char sha1[20];
-		char sign = '+';
+		char sign = '-';
 
 		commit = list->item;
 		if (!get_patch_id(commit, &patch_id_opts, sha1) &&
 		    lookup_object(sha1))
-			sign = '-';
+			sign = '+';
 
 		if (verbose) {
 			static char buf[16384];
-- 
1.4.2.3

