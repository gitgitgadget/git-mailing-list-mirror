Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 018EB2021E
	for <e@80x24.org>; Fri, 11 Nov 2016 11:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755424AbcKKLX6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 06:23:58 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43011 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751308AbcKKLX5 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 Nov 2016 06:23:57 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A4C5220980;
        Fri, 11 Nov 2016 06:23:56 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 11 Nov 2016 06:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=smtpout; bh=h/
        flHsFRx6DcimHeVERN7vyn2mQ=; b=mLwBitm4AxJGkvsO0lTVpITPWeXmsrm3s2
        7jDPDl8sqUsBXQGe1DPj+ZS0s/uOQ4ULutfpSbaZqdlHSot+Dp5oU3fJ/iNoYyTN
        zk8aN7wH02PMc9OzoIGFs0w3pNZVWKttm8wE3LkWFVSzqgxgalkI9jM5airBjvWE
        xdSarXou4=
X-ME-Sender: <xms:TKolWBKuorxDFh8FNp1BgfAaDevLsJuEPC-f97eudazkjASUEJxz2w>
X-Sasl-enc: SLtpICMHV6qo9wqYXlzmQtd+ualNqQKvuawSIZ9vQmzR 1478863436
Received: from localhost (x4e349635.dyn.telefonica.de [78.52.150.53])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3DC0E7E43A;
        Fri, 11 Nov 2016 06:23:56 -0500 (EST)
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] doc: fix location of 'info/' with $GIT_COMMON_DIR
Date:   Fri, 11 Nov 2016 12:23:32 +0100
Message-Id: <20161111112332.27727-1-ps@pks.im>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the introduction of the $GIT_COMMON_DIR variable, the
repository layout manual was changed to reflect the location for
many files in case the variable is set. While adding the new
locations, one typo snuck in regarding the location of the
'info/' folder, which is falsely claimed to reside at
"$GIT_COMMON_DIR/index".

Fix the typo to point to "$GIT_COMMON_DIR/info/" instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/gitrepository-layout.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 577ee84..a5f99cb 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -177,7 +177,7 @@ sharedindex.<SHA-1>::
 info::
 	Additional information about the repository is recorded
 	in this directory. This directory is ignored if $GIT_COMMON_DIR
-	is set and "$GIT_COMMON_DIR/index" will be used instead.
+	is set and "$GIT_COMMON_DIR/info" will be used instead.
 
 info/refs::
 	This file helps dumb transports discover what refs are
-- 
2.10.2

