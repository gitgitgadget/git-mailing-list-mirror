Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86D8120756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbdAJUmr (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:42:47 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34083 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750956AbdAJUmk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:42:40 -0500
Received: by mail-qk0-f177.google.com with SMTP id a20so188591765qkc.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 12:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LY9L+yRD2QmWaslz6xv3WzUXkiHIdqBjXYf3CoNnWQw=;
        b=Ic8k4jcwzElIp+6uxIHaUVlM9zbfC4uRzjpAAdinAijVdMGhBPhNrZXeTR8x7ZdRbp
         E8Hbdy2KICKOEyR57YaqqRfT355uj7Uv0w0mGu5FMb0MzrMP55Edwq5sU4O9lDi01NCL
         qZDNkxEPgnYNF2bBUcx4a0eSIHybgcQew9GsAw3WLn3pD6MwaT3rR8hl1a+JNe5r4ziF
         LsvHqOR12SIg+/iQtcnWAHShQSzczLxl09NkxJQJqaPX2HfFk7v9mBoRlNsRTMWBrOqc
         01KWTK6v7XSBUT5qeciCnUBmyyeQAIhko9cnsXwj20WATFMxetG07TmxkLFHV7ohkgAB
         W72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LY9L+yRD2QmWaslz6xv3WzUXkiHIdqBjXYf3CoNnWQw=;
        b=VqN8RopKtEXNTziz/fva9/VFnMvxifRhxvR4y+NHjTiCIcNOQdDhllZMS7GbeAJyHX
         AjMR5Kuzei2hTAhjqidemGIIZU8PXRRMPFNsSCMveetNpQUEtH4eunVZZnlvyXqYAqf9
         uFs5BgeAo5wMIBgHaPJoNXtVY68TRQm6BVWGwucxoGX7Z5hmkQ/dIS/h3MkF4TletUEN
         D2ZRPlVXLYNlEW+a0yiZjDYUpYN2Nb8mwVMN41aoh8ac0gEsEO09rUkCDeKwg44MK2Kd
         cwthGEGNMvapCFmKcQTQ5W1R6Yg4/kdD/ykzpZbH4RkjTOtBXVMSnSdQzQROMXh3r9h/
         2p8w==
X-Gm-Message-State: AIkVDXLnhlWnbIAxNWIuBnIEiydaccRGlr1sm83igvd4L2hNDPllsA7IcuFg6y+dLpod6Y+C
X-Received: by 10.55.112.65 with SMTP id l62mr5514240qkc.76.1484080959657;
        Tue, 10 Jan 2017 12:42:39 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id z189sm2238137qkb.42.2017.01.10.12.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 12:42:39 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org, gitster@pobox.com
Subject: [PATCH v5 01/14] .mailmap: Use my personal email address as my canonical
Date:   Tue, 10 Jan 2017 15:41:49 -0500
Message-Id: <20170110204202.21779-2-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170110204202.21779-1-hansenr@google.com>
References: <20170109232941.43637-1-hansenr@google.com>
 <20170110204202.21779-1-hansenr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I changed employers my work address changed from rhansen@bbn.com
to hansenr@google.com.  Rather than map my old work address to my new,
map them both to my permanent personal email address.  (I will still
use my work address in commits I submit so that my employer gets some
credit.)

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 9cc33e925..9c87a3840 100644
--- a/.mailmap
+++ b/.mailmap
@@ -192,6 +192,8 @@ Philippe Bruhat <book@cpan.org>
 Ralf Thielow <ralf.thielow@gmail.com> <ralf.thielow@googlemail.com>
 Ramsay Jones <ramsay@ramsayjones.plus.com> <ramsay@ramsay1.demon.co.uk>
 René Scharfe <l.s.r@web.de> <rene.scharfe@lsrfire.ath.cx>
+Richard Hansen <rhansen@rhansen.org> <hansenr@google.com>
+Richard Hansen <rhansen@rhansen.org> <rhansen@bbn.com>
 Robert Fitzsimons <robfitz@273k.net>
 Robert Shearman <robertshearman@gmail.com> <rob@codeweavers.com>
 Robert Zeh <robert.a.zeh@gmail.com>
-- 
2.11.0.390.gc69c2f50cf-goog

