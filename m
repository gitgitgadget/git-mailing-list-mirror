Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6694820248
	for <e@80x24.org>; Mon, 25 Feb 2019 20:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfBYUDL (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 15:03:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36395 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfBYUDK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 15:03:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id v10so8602557lji.3
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 12:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DMhQ99lNvvHlz/VawqsaKcXTGpHmvwJLeps0M5mcryY=;
        b=UrNw0y99G38DrJZ4Spj94c/yoHJgqUUwcUau92ilsRu56vcB93D1UhR5qLneMMVgSX
         wFP2ua8n/jXPwR2DKTzc7nExKC2qsKV8ojUG0c846vwtegntFM3OKIA/eEPPNOX32hSx
         HbOJfgCZ8pVV4Zn9bIhexVoRZKCwleM2V+X6yvfWAUzzZhJ1E74PlY6szfzzFoEzkCAv
         zQq2Vq75lIBwDHsOYjBtuZuVXiOCmk0HGRttNiOhsLR/JCfhSDyguH1UMsPUPZpzN8h1
         kz47QaHyX9jGSTLV6oKus+LbxSIqTFbWccDbjT4Pevr/HyiSnzqeJpu553sPiwkJkA44
         F7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DMhQ99lNvvHlz/VawqsaKcXTGpHmvwJLeps0M5mcryY=;
        b=Cie0CgJWG921JRGnkHYgoncLUom0cZQohi5FuIEU2d9GPng7BsTp4rQ6W6B1YKcc6/
         HJNLgH65dQAslNFiZNVx+VrUyvb+GEGyZL/HLGq5vh56jU5DFluiZO+Y81DhjUiYKZLO
         N+/3bu7+in0Fi6OaeejSObrOrDslur6P1j+cG9HieoliH0/wuqK5bhs2jPe3qtG6H62A
         9pQ/oFkyUf6+q/vulHv8d7UyqoaJ0O2oFQ+IjyVA7nGXg9qG0NPC6c4gMIKLOSC9cl7Z
         rW46W73PmlQPifvLxYWIgy8IOO1fVB+VETND0eJhM3mag6qKTMoEDftWKWVu190eYD0B
         lkCA==
X-Gm-Message-State: AHQUAubfx9mdwQmc51/4JwJTK0VayZ1cuFf8hioewMLXOMazCuuSUW+d
        kx54rsdirhCB/jnZxU9f4Awbivp+
X-Google-Smtp-Source: AHgI3IbZKr3I9HvXQKAz90Oor618sgPKwxnNPwS0rx5NnAxaEbbuZpPDdvuYGBFB44Lbjy5PAunwbA==
X-Received: by 2002:a2e:6801:: with SMTP id c1mr11765524lja.81.1551124988309;
        Mon, 25 Feb 2019 12:03:08 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id c22sm2977168lfi.27.2019.02.25.12.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 12:03:07 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/3] Documentation/Makefile: add missing xsl dependencies for manpages
Date:   Mon, 25 Feb 2019 21:02:38 +0100
Message-Id: <e960fec4b492f3edf7bade35862333af5e8704d7.1551123979.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1551123979.git.martin.agren@gmail.com>
References: <cover.1551123979.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These stylesheets very rarely change, but when they do, it really helps
if the manpages depend on them. We're casting the net a bit too wide
here, since we'll only ever use a subset of the stylesheets, but since
these files change so rarely, that should be ok. It's better than
missing a dependency.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 26a2342bea..0f8054a115 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -354,7 +354,7 @@ $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf
 manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
-%.1 %.5 %.7 : %.xml manpage-base-url.xsl
+%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
 	$(QUIET_XMLTO)$(RM) $@ && \
 	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
-- 
2.21.0

