Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 803D020248
	for <e@80x24.org>; Thu, 18 Apr 2019 13:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389002AbfDRNQv (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 09:16:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37341 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388406AbfDRNQu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 09:16:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id f53so1782991ede.4
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 06:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MdJ+878JtdS4/ikdv6uI0o7PA3z3qdb78nWrWOTgHog=;
        b=LHyI9DL9eg1YSKAJCTP0epwRIBb4uLjTctq8FRj3vFqC/gp22JpuvyNvnLKzX4zTtl
         W5yG/6P/lCTGpOGbX+pOczkZVZ7uxz1NO2WfL1GrMzVeF2/LOhkiMg3PNwCAIf5NEujO
         is9E9zcTH+2MFtFR5fU6dp3oc7e/J7z5/iS3OyTB8y1GA/yueuX+UR4CCyAvA+xlRSs1
         S7Lpx7ObgO5vWxvLMSIA9IUXzBZKYu9QRWnybZyKXsFDkqAtmf08u1bITnmqx2lkujOd
         zQc1nWxNAsNFLoHnuurH/9KXQRDSGIlps6GAK2dxdDFc9SaXV964k0d8vd3ELqDu485I
         CVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MdJ+878JtdS4/ikdv6uI0o7PA3z3qdb78nWrWOTgHog=;
        b=mR0xkTWoudm4/Pp+E3D1ThcRzo72BsJ32zISup9MmKbkYKDZkGQeyr8CUbigsYU1pj
         gz2VO5Kgzl4ps8/a7oeJ7fs65cGYinnolZka0a2kPcw055GQ99qpUJ2A21qfYhr3ThR1
         YXSmThgmK0T5384V8s7pcGNwuRzOYEhdMogRLcXeC147qgkUbcmzPL7vOlFKzUaGxyCq
         OwUaW0hatKdYAnguTFwK5HKxQYJ6evYI8jJKiSM9JIO5qzlcPEChkkmav/WllvRpWyFH
         t+Kt02D0iuArohpDH7kbInvUhwE+l3s00dCHUxa1clrMlKSGlNb/Yw6zaFK6cZYIGQDU
         54Yg==
X-Gm-Message-State: APjAAAXtenXwptEz2uh57lPVuYeIoo6s6ID5kS8G6Ym24ls7S4FQchO2
        Fq+aPYkcuHQCbV+iTZID+G40VIH+
X-Google-Smtp-Source: APXvYqzWXiYHeMgD13Aoenm0iEi55wJUvALtShUhJXD+MX3GZAuTUP0VHVRmZXtJK9HrbolVYVZ6xA==
X-Received: by 2002:a50:b4c9:: with SMTP id x9mr59700715edd.132.1555593408293;
        Thu, 18 Apr 2019 06:16:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k17sm381031eja.41.2019.04.18.06.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 06:16:46 -0700 (PDT)
Date:   Thu, 18 Apr 2019 06:16:46 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Apr 2019 13:16:34 GMT
Message-Id: <05d4ad62d6559f3b041884dfe89cd30d6fa268ba.1555593396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.168.v2.git.gitgitgadget@gmail.com>
References: <pull.168.git.gitgitgadget@gmail.com>
        <pull.168.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 6/8] check-docs: do not bother checking for legacy scripts'
 documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the recent years, there has been a big push to convert more and more
of Git's commands that are implemented as scripts to built-ins written
in pure, portable C, for robustness, speed and portability.

One strategy that served us well is to convert those scripts
incrementally, starting by renaming the scripts to
`git-legacy-<command>`, then introducing a built-in that does nothing
else at first than checking the config setting `<command>.useBuiltin`
(which defaults to `false` at the outset) and handing off to the legacy
script if so asked.

Obviously, those `git-legacy-<command>` commands share the documentation
with the built-in `git-<command>`, and are not intended to be called
directly anyway. So let's not try to ensure that they are documented
separately from their built-in versions.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6f90cec590..f5fc977ee8 100644
--- a/Makefile
+++ b/Makefile
@@ -3074,7 +3074,7 @@ check-docs::
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
 		git-merge-resolve | git-merge-subtree | \
 		git-fsck-objects | git-init-db | \
-		git-remote-* | git-stage | \
+		git-remote-* | git-stage | git-legacy-* | \
 		git-?*--?* ) continue ;; \
 		esac ; \
 		test -f "Documentation/$$v.txt" || \
-- 
gitgitgadget

