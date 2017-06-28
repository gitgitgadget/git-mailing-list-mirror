Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31F212023D
	for <e@80x24.org>; Wed, 28 Jun 2017 00:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753544AbdF1A5J (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 20:57:09 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35084 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753444AbdF1A5D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 20:57:03 -0400
Received: by mail-pf0-f182.google.com with SMTP id c73so24668353pfk.2
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 17:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZHtOY9MVdmZm37IsBHWMZOfvdVzsdiZ2ZSOjl5ygML8=;
        b=ZYettQnw/CdCt0IATq0rrje/Yg+QIcZpaSJb5Y5u0qiguGpBSYSjSmBFI3EVZW+M+Z
         oUxppD9rafUioYPel+8P9b7ifLLgDEw74flRU5eGCVMbs2+R6LRuHpT/L4YKaN/MzJQW
         SfeaatuYovOn6YCw8p0i2QZhAmdrLIAEjJ4tko2c6dyFn92nnQJBsa3x/RmF+90QuV6Y
         IOWxv1KT/8p5B36KsUkUua0RQo6gZUaRPLDAf9RDcxej0iucRWTjNmI+LrI2ezoB+Acf
         8Ydf2jleAgR5tntwWIw07nozCXAlEV2VXKR2xFiQ19rToyS5u2jZ303EuWPWXs2fGkQb
         QLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZHtOY9MVdmZm37IsBHWMZOfvdVzsdiZ2ZSOjl5ygML8=;
        b=aiXeid2lDD31UIHj2YzWkkFPoT3Dsh6MWDiyfvlyHvfa2W6a0c+Y4grR5N37UyJ2p8
         8Ms13eoape6O/Vu5UqXoT26a2CADh7Qijlupp9zk2R8URVyfrpXqi+tbYcg+aPwgJAp1
         yS2cMhZyhN1J0J2qnkyTJGaerCUeXYSSvGQIU/d82W3wj1I1xM7OHYqLvXqzPDmuvhww
         LE54u3ZILO0jRWODCDnW7gRcg3i6rtVovVnyq49Fp6b9zcVjtaikZslsC/KyssQIGoTj
         FaFjSxQ+NdaGZTtJD2SXKhOvfNdZOyF5jTh2ZOO9Hx/soaCYHSr2SkFcQMVB+EO9xfY0
         5FGw==
X-Gm-Message-State: AKS2vOz7LQn4ZJxi1nPez88bBMUv3D+SxnYALc9bi4fAMUP3xeJTiXoz
        7C7sLtOQkZWSCf9O
X-Received: by 10.98.200.27 with SMTP id z27mr7926152pff.136.1498611422831;
        Tue, 27 Jun 2017 17:57:02 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ac62:ae13:b066:f242])
        by smtp.gmail.com with ESMTPSA id a4sm842412pfc.22.2017.06.27.17.57.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 17:57:02 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/6] Documentation/diff: reword color moved
Date:   Tue, 27 Jun 2017 17:56:49 -0700
Message-Id: <20170628005651.8110-5-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170628005651.8110-1-sbeller@google.com>
References: <20170628005651.8110-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is easier for the casual reader.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt       | 6 ++++--
 Documentation/diff-options.txt | 7 ++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 29e0b9fa69..3d89be2d84 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1052,8 +1052,10 @@ This does not affect linkgit:git-format-patch[1] or the
 command line with the `--color[=<when>]` option.
 
 diff.colorMoved::
-	If set moved lines in a diff are colored differently,
-	for details see '--color-moved' in linkgit:git-diff[1].
+	If set to either a valid `<mode>` or a true value, moved lines
+	in a diff are colored differently, for details of valid modes
+	see '--color-moved' in linkgit:git-diff[1]. If simply set to
+	true the default color mode will be used.
 
 color.diff.<slot>::
 	Use customized color for diff colorization.  `<slot>` specifies
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index d2c6a60af2..d4dc46ee2f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -252,9 +252,10 @@ plain::
 	Similarly 'color.diff.oldMoved' will be used for removed lines
 	that are added somewhere else in the diff.
 zebra::
-	Blocks of moved code are detected. The detected blocks are
-	painted using the 'color.diff.{old,new}Moved' alternating with
-	'color.diff.{old,new}MovedAlternative'.
+	Blocks of moved code are detected greedily. The detected blocks are
+	painted using either the 'color.diff.{old,new}Moved' color or
+	'color.diff.{old,new}MovedAlternative'. The change between
+	the two colors indicates that a new block was detected.
 dimmed_zebra::
 	Similar to 'zebra', but additional dimming of uninteresting parts
 	of moved code is performed. The bordering lines of two adjacent
-- 
2.13.0.31.g9b732c453e

