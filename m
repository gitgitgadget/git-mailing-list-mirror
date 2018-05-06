Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91CCB200B9
	for <e@80x24.org>; Sun,  6 May 2018 20:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeEFUmf (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 16:42:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40930 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751814AbeEFUme (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 16:42:34 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D4B5060444;
        Sun,  6 May 2018 20:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525639353;
        bh=HV7rZpC5gOYSgpoytgYYXMfNfFSbjKRQ48abGi0cOZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ckyaAHBRZW6g735PW9JrIiM3PvYZDM5LH3PBl8IE/eb5vBjn94wHcPLcITG1L4daa
         kO+Co+HVEh85N+fD2ZD3KOk4uYYJX6y+wIOMT2HjeVBAGxKqOWZlRovQUs10vEFRnZ
         ZvnQnkvPMbsURxaefdsyoVXXsCImD296GGVEBeu3/o3lEC7hmkPkViSAt+naqisIB7
         HfFqnUI2jm7aoAUhUfmL3dMukY1Eqh8AelKWpXBVApGjheOOJVRWicUxzMFORraVwi
         NwixqAw3TAAB9SIwnxMoBUIVCKOeLE0Hw8jUcM4iywHtGvTKLdYDQzcDFyPGj/7jL0
         sUQuwYRfqrtXRm42tW4KT+TNApmOVqZ/1RwlIsxz0ECiPsPSpfAKdkk/po+3d4ifUC
         9Mu7XuGeSFpUEpK0Z1HWNZHcye62uC9/x0Mv4qp4xRODwOLzpESUPKDwQ2hLE670vn
         /GcMFuR1xEDaI2Y/hbL0UKhagPFHm5Z4Eq4zMRdicz/8I74zKZt
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH 1/2] Documentation: use 8-space tabs with Asciidoctor
Date:   Sun,  6 May 2018 20:42:25 +0000
Message-Id: <20180506204226.955739-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180504015202.GP13217@genre.crustytoothpaste.net>
References: <20180504015202.GP13217@genre.crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Asciidoctor expands tabs at the beginning of a line.  However, it does
not expand them into 8 spaces by default.  Since we use 8-space tabs,
tell Asciidoctor that we want 8 spaces by setting the tabsize attribute.
This ensures that our ASCII art renders properly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6232143cb9..bcd216d96c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -184,7 +184,7 @@ ASCIIDOC = asciidoctor
 ASCIIDOC_CONF =
 ASCIIDOC_HTML = xhtml5
 ASCIIDOC_DOCBOOK = docbook45
-ASCIIDOC_EXTRA += -acompat-mode
+ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
 ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
 DBLATEX_COMMON =
