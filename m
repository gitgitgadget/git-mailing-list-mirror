Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D93C1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 19:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeKUGNl (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 01:13:41 -0500
Received: from srv1.79p.de ([213.239.234.118]:60278 "EHLO srv1.79p.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbeKUGNk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 01:13:40 -0500
Received: from srv1.79p.de (localhost [127.0.0.1])
        by srv1.79p.de (Postfix) with ESMTP id 05413220193;
        Tue, 20 Nov 2018 20:42:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: by srv1.79p.de (Postfix, from userid 1000)
        id E24C0220194; Tue, 20 Nov 2018 20:42:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
        s=mail2018; t=1542742970;
        bh=1TPBDTFVcy5oNslw+zSQYsGmdZWF/ZBD0W6Ca3AWY3w=;
        h=From:Date:To:CC:Subject:From;
        b=RzLTBMk0nct0wNAbnTA3hwGqZq1I14hxK4M5esxaUhyQwOVveXNkzZiBBEjps0Guv
         okSaL3IxZAfjmSKQU5KoTMAoDpTkzIRVy6mlhEKBokcNbGj8cg4xRlsNrs2tydR+bN
         KhlmHCtAXXRwIhNU4QM0wXOqRTF2G+36OWNIz8BkKZ4FN2ZwIkgn8pj3Shl0KnN9Xe
         SSa3JdKjfkoqo85Xh1xgRppK699Zm7oBUA+14IMc0vKyQylwy/ZaSudt+O8oQkHn1i
         hfLsc2GpWpujE740CuoKHNemhitwwFLe7hhzN+5+QVLFshKh2XZ1m9QsvPiMb5efzS
         g31OQG/Lr6awA==
From:   Sven Strickroth <email@cs-ware.de>
Date:   Tue, 20 Nov 2018 20:40:38 +0100
To:     git@vger.kernel.org
CC:     gitster@pobox.com
Message-ID: <15b7df69-25d8-c168-dd43-a43b7fee23d2@cs-ware.de>
Subject: [PATCH] .mailmap: record canonical email address for Sven Strickroth
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index f165222a78..a30f409f39 100644
--- a/.mailmap
+++ b/.mailmap
@@ -235,6 +235,8 @@ Steven Grimm <koreth@midwinter.com> <sgrimm@sgrimm-mbp.local>
 Steven Grimm <koreth@midwinter.com> koreth@midwinter.com
 Steven Walter <stevenrwalter@gmail.com> <swalter@lexmark.com>
 Steven Walter <stevenrwalter@gmail.com> <swalter@lpdev.prtdev.lexmark.com>
+Sven Strickroth <email@cs-ware.de> <sven@cs-ware.de>
+Sven Strickroth <email@cs-ware.de> <sven.strickroth@tu-clausthal.de>
 Sven Verdoolaege <skimo@kotnet.org> <Sven.Verdoolaege@cs.kuleuven.ac.be>
 Sven Verdoolaege <skimo@kotnet.org> <skimo@liacs.nl>
 SZEDER Gábor <szeder.dev@gmail.com> <szeder@ira.uka.de>
-- 
2.19.1.windows.1

