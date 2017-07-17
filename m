Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3FD020357
	for <e@80x24.org>; Mon, 17 Jul 2017 20:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbdGQULf (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 16:11:35 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33731 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdGQULe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 16:11:34 -0400
Received: by mail-lf0-f65.google.com with SMTP id t72so26599lff.0
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 13:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wqGgWG0RDQlbd+kjzTujhcVanUgLp0E0e0LzdG4NYXU=;
        b=Pv760MiZGDGb08cH1TQWgFY0RvG2aldUK04eDAKU0Y81QQlMYt/ZgldFAnvx/oiJQ8
         0ysgbgDm7r1iBq1HT1u8UOLQD74R7MD4aAZmZb8gVfpT1rcgP3Q78k8eFha5E9L5dtCK
         XwuM36ckJRaTS9+Csn5zcFMGMl91RppzS5Ip0qHkbCjVRZ+AWxShktdWBq2HBWywSb6N
         uJpgO33xZHoRv0I5xofmpM0ZqVEA6iNy1eC2bEywgSvAYimsYvX/mCVszydP+Y5VAb1S
         30Wy4kEUsfhoPo2l8RHzPPFvRjLToC6xs+s1OLZ+Cp7i1Gp46GxEs7pxCFgV8Aj6jxCd
         0Chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wqGgWG0RDQlbd+kjzTujhcVanUgLp0E0e0LzdG4NYXU=;
        b=ifmOElEAcS7OOAibAJgxR4xz36X/apv3DWCUWiBy+F4HhetLhs2at2UNQsw79PP4t8
         r9oCsfykDJHT3VRJ5M4T3B5+ehdvgtWQYc8A3r4uaGp7w/fbj44V5JwXdolJcyioddW7
         IXaY+r6pSA7FNgamopmqF4BYi97bXhEHrZo8ndTQGy4ZRIkyRJhFb7xLXCYaavr68Grh
         aVBE6GA5S2LEuI/rBjWmOn81egCDarRomxQ0IG+Zz3wiWxRZ8MddutAx9ZCafh+OTIwe
         p0HAQD21TP3CMbp4L6YUhFT9YDYZnjF2BEfbZRxymRXSAgvr4Ic5aMc9knaNhm1QtIy8
         coRQ==
X-Gm-Message-State: AIVw112gmbQ3tpmhfJD8TvorxYlCdttWUoYdpplxrtLDEwrwtcYT4oUY
        Y/1/bF5Z7uwl9ytR
X-Received: by 10.25.212.69 with SMTP id l66mr6473542lfg.56.1500322293103;
        Mon, 17 Jul 2017 13:11:33 -0700 (PDT)
Received: from localhost.localdomain (c83-248-253-33.bredband.comhem.se. [83.248.253.33])
        by smtp.gmail.com with ESMTPSA id l12sm30752ljb.39.2017.07.17.13.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 13:11:32 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 03/10] builtin.h: document SUPPORT_SUPER_PREFIX
Date:   Mon, 17 Jul 2017 22:10:45 +0200
Message-Id: <715342d85810ddae1372fb4a1c5e300d323a2b58.1500321657.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.rc0
In-Reply-To: <cover.1500321657.git.martin.agren@gmail.com>
References: <cover.1499723297.git.martin.agren@gmail.com> <cover.1500321657.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 74866d75 ("git: make super-prefix option", 2016-10-07) introduced
SUPPORT_SUPER_PREFIX as a builtin flag without documenting it. The next
patch will add another flag, so document SUPPORT_SUPER_PREFIX, thereby
bringing the documentation up to date with the available flags.

While at it, correct '3 more things to do' to '4 more things to do'.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin.h b/builtin.h
index 62f22b547..7bcc08456 100644
--- a/builtin.h
+++ b/builtin.h
@@ -51,9 +51,13 @@
  *	on bare repositories.
  *	This only makes sense when `RUN_SETUP` is also set.
  *
+ * `SUPPORT_SUPER_PREFIX`::
+ *
+ *	The builtin supports `--super-prefix`.
+ *
  * . Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.
  *
- * Additionally, if `foo` is a new command, there are 3 more things to do:
+ * Additionally, if `foo` is a new command, there are 4 more things to do:
  *
  * . Add tests to `t/` directory.
  *
-- 
2.14.0.rc0

