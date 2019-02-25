Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 901B820248
	for <e@80x24.org>; Mon, 25 Feb 2019 20:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfBYUDN (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 15:03:13 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45854 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfBYUDN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 15:03:13 -0500
Received: by mail-lf1-f68.google.com with SMTP id h10so7818000lfc.12
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 12:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GfgffQqqOTLwvrmsIofFupimNbVLrb2SmoGlEkJUMws=;
        b=CBNIXcF56wTHJMqh3jVrVFQqaiK+/aIfvmwR3pv+gt5cfIEle0zm3+iMGyRVJsOqMZ
         GoB1dN3Sg85cl0CVqPcz7KNvtmmx+Y+/LH28h8qLWzcmTBVOzVLCkm4PkAUK1p3KsykF
         xN6S9B/UtrOhIuy51ihXeYaRgpwJhlkPqbGkQd0UFdTISRGf+NbtLjcPfjBApKDUiQa2
         EL74f1JvEPbdhlsx7KEgvD1eltRIjsbaADczIfhCw64RIC0K0wjZ+gjYRmitwUPwEoFn
         uQPiriUWLJqENXWmG/2zzel9V5wZdg+/GXNoktn4zaDBHhJEXfdOAxdDJuBsXbeFQelf
         icrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GfgffQqqOTLwvrmsIofFupimNbVLrb2SmoGlEkJUMws=;
        b=mBxqHLrQDvPdJrPaBEEsjdymlbYwMkGFylMcoDnwY9E2GybRPQZRiw7cTqy1Kk7iIj
         rmVSEJDPb5ioDGhuUJMKGMwYm7Es0j5JLhPPteMFyVYAhv/bPJakgbmEDpRq/VC48fuS
         +aecnpJFrPuAuE1S7/BSXsxhNqtR9VzRJoe68VSOMycjtpQuM297G3bcp3hBN1lplGD7
         UOUXxzaBwt9tFQOINRa+E3Nq2bWZN0Qhmfq8KJqILX2WlciCh5f5QWnlC7spBazbWbFo
         saD95YnhUJCSBjhfc+twM8hvHQj58khpOdFJg/s8AMdSAlkcRsJRDhCIW6vkGdGY0J1u
         OpSQ==
X-Gm-Message-State: AHQUAubHKFNfgkdn/GoWDHSHCWokGcUm0DYu4jR8Hib7/+uOhXDv7M3G
        Uop8Mb5NpPV9PQO1RbQpbGHNMnKX
X-Google-Smtp-Source: AHgI3IajiokAvwpsLhsq254ohdc6plXV77gbgBv4pLDefa+PYHQB1SVASxnAHBXVf1x/uM1Iql47zw==
X-Received: by 2002:a19:4848:: with SMTP id v69mr2475650lfa.35.1551124990469;
        Mon, 25 Feb 2019 12:03:10 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id c22sm2977168lfi.27.2019.02.25.12.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 12:03:09 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/3] Documentation/Makefile: add missing dependency on asciidoctor-extensions
Date:   Mon, 25 Feb 2019 21:02:39 +0100
Message-Id: <966fa6a7163fcc48d1df7365461d2ac57b98bc5c.1551123979.git.martin.agren@gmail.com>
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

asciidoctor-extensions.rb has never changed, but when it does -- such as
in the next commit --, it helps if the xml-files depend on it. We're
casting the net a bit too wide here, since we'll be rebuilding even with
AsciiDoc, which won't look at this file. But since this file changes so
rarely, that should be ok. It's better than missing a dependency.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 0f8054a115..a9697f5146 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -358,7 +358,7 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_XMLTO)$(RM) $@ && \
 	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
-%.xml : %.txt asciidoc.conf
+%.xml : %.txt asciidoc.conf asciidoctor-extensions.rb
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(TXT_TO_XML) -d manpage -o $@+ $< && \
 	mv $@+ $@
-- 
2.21.0

