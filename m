Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 596971F597
	for <e@80x24.org>; Sat,  4 Aug 2018 22:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbeHEAUi (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 20:20:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35303 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeHEAUi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 20:20:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so5021759pfh.2
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 15:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9EimhKscsXnr0MC02mDoBMXk/upbLgPCxmseVWEUOd4=;
        b=n/ox82wUdS1PqWX+qu6lul5qipUTKtGP/AHvf9fv3gjxiNtiLuDnUBFM6l7+LwegLd
         LAeM/nsz1eEPU7fjYdh2sd/cCfraI8QdPUWa3IULgo5AVQcUfkNMWIcD+4qcMk8lR21y
         mn9xBgFVuF8MeoSesSJ5IwC9I9ykbDgOu/xnZLvASfvX2B+kPeFmLRmVMbjeFAjtw1DH
         r2MC0vtcOijBzQWD2Ocwb3dbb7HykBUJWPhB0xoM04QZPWPa2CjlvaaZxHHwTgu8vSo8
         sfohQP3gxtBAx8E44Kt8bFDt0PaFlBBR16Pt77aH3Bxu0PSF9SfUqEQI5fMjHHY7aRKj
         PBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9EimhKscsXnr0MC02mDoBMXk/upbLgPCxmseVWEUOd4=;
        b=Cwm0TgsPTdxZoAThy5t9yXK+kymEu9w+spnI76JQjapSLaykEBzE94bicuCHpBMTMr
         WmNYiHgqNUzNc9rbVVREBIsmDQUCk+cWIyOjUg1HHXUSNWLS6gDYTcNBiv4uNJ/WCq/p
         +pp3mLqqANmf11j4JKQSU2GfPBuH+WjmM9PrQaiowTIi3sY3APG1yjMfuNG0fgPJubbi
         +DMdJFWSFIxNas0PvhY+wTF7mdpk2P6sd8B6/AHyDKkUSNvMRn1SRPla9iniVUX7PiHX
         MOQgANNt6Lxd5I6hes+xShyA1cBTVtJoZRTRFy3w4LqS9lCKEakx9SVILmeoONdSM3Vp
         aJBg==
X-Gm-Message-State: AOUpUlE+GVMd3/4eGkRK9vt3L0BxfCeUJWH+Vv2cYaY0tSj3arRrjBpa
        urCMi0aUTnQJ+u9xVvaR5mhgwQ1q
X-Google-Smtp-Source: AAOMgpffTRkvjwhJLDfE5dt5BIFlUMWY93EwFwKb0zRuC78zyp8jXoMYNqHfYj6nclmwpa26GQ3HnA==
X-Received: by 2002:a63:5204:: with SMTP id g4-v6mr9111086pgb.274.1533421107520;
        Sat, 04 Aug 2018 15:18:27 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id j72-v6sm13868344pge.19.2018.08.04.15.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 15:18:26 -0700 (PDT)
Date:   Sat, 04 Aug 2018 15:18:26 -0700 (PDT)
X-Google-Original-Date: Sat, 04 Aug 2018 22:18:19 GMT
Message-Id: <d5d9db3c1124d29e26864596a8c36f0dc4de8a7e.1533421100.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.15.git.gitgitgadget@gmail.com>
References: <pull.15.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/4] line-log: optimize ranges by joining them when possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Technically, it is okay to have line ranges that touch (i.e. the end of
the first range ends just before the next range begins). However, it is
inefficient, and when the user provides such touching ranges via
multiple `-L` options, we already join them.

When we traverse the history, though, we never join ranges, even they
become "touchy-feely" due to added lines (which are "removed" from
line-log's point of view because it traverses the commit history into
the past).

Let's optimize also this case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 line-log.c          | 4 ++++
 t/t4211-line-log.sh | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/line-log.c b/line-log.c
index d8d09b5ee..bc7ef69d6 100644
--- a/line-log.c
+++ b/line-log.c
@@ -68,6 +68,10 @@ void range_set_append_unsafe(struct range_set *rs, long a, long b)
 
 void range_set_append(struct range_set *rs, long a, long b)
 {
+	if (rs->nr > 0 && rs->ranges[rs->nr-1].end + 1 == a) {
+		rs->ranges[rs->nr-1].end = b;
+		return;
+	}
 	assert(rs->nr == 0 || rs->ranges[rs->nr-1].end <= a);
 	range_set_append_unsafe(rs, a, b);
 }
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 61ff37430..ebaf5ea86 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -119,7 +119,7 @@ q_to_lf () {
 	tr Q '\012'
 }
 
-test_expect_failure 'close to overlapping ranges' '
+test_expect_success 'close to overlapping ranges' '
 	test_seq 5 >a1.c &&
 	git add a1.c &&
 	git commit -m "5 lines" a1.c &&
-- 
gitgitgadget

