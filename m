Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 694FC1F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 18:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbdAaSnV (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 13:43:21 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36586 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbdAaSnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 13:43:16 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so119264wmd.3
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 10:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCWICl7X0VZeKaNsV6hp7JX7ZMPMYUKERVX8C6O8VGw=;
        b=YC4AwEKBgfSQibqozfrfUW/pq9yTexOGXwcU/jnNbWUj419JcWuVg5DVYn+wPL3zLv
         DtHyZfBhKkEnWG8siDAKdBUhQwM+TFiE/3Pag5hqwovay6XG8Vp43rjbnF9RPfW7zoKz
         TsJBjwc8l8IAwdMIGgeR2Gm3VKpiUfvf6GNDhAC0Nis702W5YWx3LQ7PIGZrziG/QBQH
         i36m+OLBC1A/NNi0ZsmJ4J7/ok/i9oiL60nZxo8Y8MXDDJSWfuHUoj5+iGn/kJB4KNwB
         leCymy3VidIQQ6cT0aw8BwsRWUxgYORQMX5m+eYiZUV++e6XquS6S6fWdJ9ZD6b5jfH4
         jZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCWICl7X0VZeKaNsV6hp7JX7ZMPMYUKERVX8C6O8VGw=;
        b=X/GmfW8njVgGrCzoBM9tSKayeFx+M8bZpQ1Zh5mXsE6fLk1zEvO/D3rMv/mNov7E6v
         1vUF87lqILPUomblgvnBtn9JTq8GpwhdN+HYwIjVEEi6MdtsWXyzFO1YuW0MK/JX9mQx
         mswuNBoRGKmPyD2wQhxJTvk7EARwV7+Irpi5OPRoCbrUW0fxo5yKNiLf3FUnjIqiR7M2
         GtQ8FqTYYaF9hTjD/4XPpMjobF5u4Lyu3IXmEf/qgitWWA5xBhVidB6+Qjx32hN8NMvA
         Bdv+0VAIavchtNS7MB9yizO/03EdqpQdCNcA2j3PxtW26Up78nqzF3sRRSEOHLP1Dv6f
         cEgg==
X-Gm-Message-State: AIkVDXL6V7qO6kH3Z+PID73WM/OFwfARHhjIOdlx071TZxe2W0i6xK9hje5BRoKSyzrJAw==
X-Received: by 10.28.238.140 with SMTP id j12mr18808789wmi.35.1485888190101;
        Tue, 31 Jan 2017 10:43:10 -0800 (PST)
Received: from localhost.localdomain (x590c3414.dyn.telefonica.de. [89.12.52.20])
        by smtp.gmail.com with ESMTPSA id y80sm29960412wrb.12.2017.01.31.10.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jan 2017 10:43:09 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] =?UTF-8?q?.mailmap:=20update=20G=C3=A1bor=20Szeder's=20em?= =?UTF-8?q?ail=20address?=
Date:   Tue, 31 Jan 2017 19:42:12 +0100
Message-Id: <20170131184212.22687-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 9c87a3840..ab59b2fac 100644
--- a/.mailmap
+++ b/.mailmap
@@ -225,6 +225,7 @@ Steven Walter <stevenrwalter@gmail.com> <swalter@lexmark.com>
 Steven Walter <stevenrwalter@gmail.com> <swalter@lpdev.prtdev.lexmark.com>
 Sven Verdoolaege <skimo@kotnet.org> <Sven.Verdoolaege@cs.kuleuven.ac.be>
 Sven Verdoolaege <skimo@kotnet.org> <skimo@liacs.nl>
+SZEDER Gábor <szeder.dev@gmail.com> <szeder@ira.uka.de>
 Tay Ray Chuan <rctay89@gmail.com>
 Ted Percival <ted@midg3t.net> <ted.percival@quest.com>
 Theodore Ts'o <tytso@mit.edu>
-- 
2.11.0.555.g967c1bcb3

