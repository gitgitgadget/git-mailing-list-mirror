X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH (again)] Fix show-ref usagestring
Date: Thu, 26 Oct 2006 21:39:05 +0200
Message-ID: <11618915452882-git-send-email-hjemli@gmail.com>
NNTP-Posting-Date: Thu, 26 Oct 2006 19:39:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.3.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30260>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdB4L-0003I2-Ul for gcvg-git@gmane.org; Thu, 26 Oct
 2006 21:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422847AbWJZTjK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 15:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422886AbWJZTjK
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 15:39:10 -0400
Received: from mail48.e.nsc.no ([193.213.115.48]:27900 "EHLO
 mail48.e.nsc.no") by vger.kernel.org with ESMTP id S1422847AbWJZTjJ (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 15:39:09 -0400
Received: from localhost.localdomain (ti231210a080-7372.bb.online.no
 [80.213.28.208]) by mail48.nsc.no (8.13.8/8.13.5) with ESMTP id
 k9QJd6Ab027729; Thu, 26 Oct 2006 21:39:06 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This describes the abbreviation possibilities for git-show-ref

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

Hopefully I can finally get it right :-)


 builtin-show-ref.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index f2912e8..59ac46b 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -3,7 +3,7 @@ #include "refs.h"
 #include "object.h"
 #include "tag.h"
 
-static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash] [--tags] [--heads] [--] [pattern*]";
+static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash[=<length>]] [--abbrev[=<length>]] [--tags] [--heads] [--] [pattern*]";
 
 static int deref_tags = 0, show_head = 0, tags_only = 0, heads_only = 0,
 	found_match = 0, verify = 0, quiet = 0, hash_only = 0, abbrev = 0;
-- 
1.4.3.2
