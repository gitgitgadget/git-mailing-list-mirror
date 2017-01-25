Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 596A21F437
	for <e@80x24.org>; Wed, 25 Jan 2017 00:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbdAYAVU (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 19:21:20 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34681 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbdAYAVT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 19:21:19 -0500
Received: by mail-pf0-f177.google.com with SMTP id e4so53359631pfg.1
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 16:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=07cgEOod3gwuxaF6KXto8wqlNPfORoTi/49JvPVRHPI=;
        b=OiPg4+SM/1EL0/IcFqVJTjFc9F13Grq6teIcLJ6h35qD0wgh4NpgUlbfE0maL1gJjO
         +IY/vfm7lSKOXufqa0nx9QX9FB/bgKXoEVxcthIXqgVZ3DgfZht+TNcZd13etZOts8v5
         z0ZXfx3R5MjDMboRSpUzDvDpfP4u05obVxE3Kkc2qlxTMpEEi8utjwxjXtlQ/FysXB9d
         nSiVMLWUcwsyEGbLMnP684tUX/YB9ve0xrXzDt+ZC+xaK25qO3LeqAd8S+Xiu+7ne3eQ
         LcL4ZdcnP4OJ1S0kDaJE0LegYjCOETbJngq9TqqSCC+AZMMhYvkm9Fu5SFVKi0P0ys3D
         1cLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=07cgEOod3gwuxaF6KXto8wqlNPfORoTi/49JvPVRHPI=;
        b=rDv3AuiisUgqoj49i6fL2kr7dHsXRk2RxP8DjAzDFnGIF2LKr3R3pG+kfx2cvMm3q1
         JvW7RQcLszoKM97kUCb9nHP+dM8nOJy71HSqNlUpC1MWNMVedPPjG/N+D9L2fQo+ksJW
         bHAiRyyENEwSJTYcyf2Q7+DufAJ4CCi2hH5ZdUn1d1hnOuMwzDlVNaK01ijadjalEQSo
         HPXexwBsoZxV0yx/maMVh2CdChhQ0rU3PH6vhfrE0d8vb5zXRx6t7U/ls0uLiJIGgllJ
         JJ9eTFpwfD5jyQwRwvnWNGJU6jZRmyBjJA8OVUbKOt+g3S7U3/btv3B6IpggXGC0GQnB
         e02Q==
X-Gm-Message-State: AIkVDXK1r+wXEijQENBqMzdwEwWzqUWSEBVSXKhdORWnpGKzmlpf0i/jFRmMb/brDLPZF890
X-Received: by 10.98.217.209 with SMTP id b78mr42665892pfl.53.1485303678770;
        Tue, 24 Jan 2017 16:21:18 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6936:a216:cb1:3482])
        by smtp.gmail.com with ESMTPSA id a2sm45451297pfc.72.2017.01.24.16.21.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Jan 2017 16:21:17 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     cornelius.weig@tngtech.com
Cc:     j6t@kdbg.org, bitte.keine.werbung.einwerfen@googlemail.com,
        git@vger.kernel.org, gitster@pobox.com,
        thomas.braun@virtuell-zuhause.de, john@keeping.me.uk,
        Stefan Beller <sbeller@google.com>
Subject: 
Date:   Tue, 24 Jan 2017 16:21:16 -0800
Message-Id: <20170125002116.22111-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.495.g04f60290a0.dirty
In-Reply-To: <923cd4e4-5c9c-4eaf-0fea-6deff6875b88@tngtech.com>
References: <923cd4e4-5c9c-4eaf-0fea-6deff6875b88@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


>
>> Do not PGP sign your patch, at least *for now*. (...)
>

And maybe these 2 small words are the bug in the documentation?
Shall we drop the "at least for now" part, like so:

---8<---
From 2c4fe0e67451892186ff6257b20c53e088c9ec67 Mon Sep 17 00:00:00 2001
From: Stefan Beller <sbeller@google.com>
Date: Tue, 24 Jan 2017 16:19:13 -0800
Subject: [PATCH] SubmittingPatches: drop temporal reference for PGP signing

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/SubmittingPatches | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 08352deaae..28da4ad2d4 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -216,12 +216,12 @@ that it will be postponed.
 Exception:  If your mailer is mangling patches then someone may ask
 you to re-send them using MIME, that is OK.
 
-Do not PGP sign your patch, at least for now.  Most likely, your
-maintainer or other people on the list would not have your PGP
-key and would not bother obtaining it anyway.  Your patch is not
-judged by who you are; a good patch from an unknown origin has a
-far better chance of being accepted than a patch from a known,
-respected origin that is done poorly or does incorrect things.
+Do not PGP sign your patch. Most likely, your maintainer or other
+people on the list would not have your PGP key and would not bother
+obtaining it anyway. Your patch is not judged by who you are; a good
+patch from an unknown origin has a far better chance of being accepted
+than a patch from a known, respected origin that is done poorly or
+does incorrect things.
 
 If you really really really really want to do a PGP signed
 patch, format it as "multipart/signed", not a text/plain message
-- 
2.11.0.495.g04f60290a0.dirty

