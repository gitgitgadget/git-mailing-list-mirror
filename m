Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC11A1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 22:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbfFSWNm (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 18:13:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52582 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSWNm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 18:13:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so1015560wms.2
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 15:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IyamchNcg00xn+oiq0P3iZAPooCCEs7hIDIq0U3d3c8=;
        b=hENLZX7tNmuP6yt3WhKQX+wZcFQINjM9lltZrFfLuamX5tL6QgIebBS+kz53Hzw54m
         aNYerPqlADv1sNTSEbzTfh3qrHdomrA93JwAQbU39+PxBzDJYP29LaIVRE5su+j6mvGc
         W7pTO4GszhJfYRbg/uOW/SMo0Pqa7mhe//jnX9xvtdhEirg3Td+QhDfKLq73GDpgyxCV
         TR1dcyi+OwzidS+ayf57hIxlBGYIQ59Tk4lOCenoGwEm5idTHq8vPQ0EPXdzGmCcD1ox
         iv3xSIwfiX3lE3S76trqpX3G3FALPTqHOazwbyqCWr2sPJae3E5gvFwhPyXjFOvSHp8X
         yw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IyamchNcg00xn+oiq0P3iZAPooCCEs7hIDIq0U3d3c8=;
        b=CiUPZpKy1U69xGsw36glWl9q5Ogv8R1Uwi7EJnX1ZjjDf9vwnpIJhmwLFXmRzaGaIX
         eInpVSQSiKSQRI+7XKF2HuY2l+eB8oO0plApNzvrR3KFGyLC8W+p5HDHE/NPrO1J9JHt
         fG/Uwn4G1UwQOT85/QZsOMexlVdzoIOs2owfIrxjn14VHZyvRxkxQmwNVxENQeEiMh8w
         KJokhS/x/hYN+Ewcx61EHuZrEP9pCGz7vxL3qq2tM/shN3jtQh9ONPplcVzLdJM4/gN2
         xSih++zbjCdtt7HP1ltU8p5zB/PkS4yj0Kw657lRXRrR1ZfXANrFrHksP4CP1afo3WMw
         c87A==
X-Gm-Message-State: APjAAAWwdk6VFaGI+pRP6lpZJLehRJofgmSt5EY7zLwGMjV8VoUUrqe0
        WoH9RRWh+LkC0hHnqhSPXskwyOiD
X-Google-Smtp-Source: APXvYqya/TO9IdDm5+y9LW9j7k+Aw3Cm+VhLwbhyFdW792Z1ClcUnAJdjt+1aAVIb1V21IbZObsifQ==
X-Received: by 2002:a1c:e341:: with SMTP id a62mr10324822wmh.165.1560982419671;
        Wed, 19 Jun 2019 15:13:39 -0700 (PDT)
Received: from localhost.localdomain (67.170.124.78.rev.sfr.net. [78.124.170.67])
        by smtp.gmail.com with ESMTPSA id y133sm3872019wmg.5.2019.06.19.15.13.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 15:13:39 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] doc: improve usage string in MyFirstContribution
Date:   Thu, 20 Jun 2019 00:13:15 +0200
Message-Id: <20190619221315.7343-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We implement a command called git-psuh which accept arguments, so let's
show that it accepts arguments in the doc and the usage string.

While at it, we need to prepare "a NULL-terminated array of usage strings",
not just "a NULL-terminated usage string".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/MyFirstContribution.txt | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 895b7cfd4f..7512a35ba3 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -428,7 +428,7 @@ git-psuh - Delight users' typo with a shy horse
 SYNOPSIS
 --------
 [verse]
-'git-psuh'
+'git-psuh <arg>...'
 
 DESCRIPTION
 -----------
@@ -491,14 +491,16 @@ Take a look at `Documentation/technical/api-parse-options.txt`. This is a handy
 tool for pulling out options you need to be able to handle, and it takes a
 usage string.
 
-In order to use it, we'll need to prepare a NULL-terminated usage string and a
-`builtin_psuh_options` array. Add a line to `#include "parse-options.h"`.
+In order to use it, we'll need to prepare a NULL-terminated array of usage
+strings and a `builtin_psuh_options` array.
 
-At global scope, add your usage:
+Add a line to `#include "parse-options.h"`.
+
+At global scope, add your array of usage strings:
 
 ----
 static const char * const psuh_usage[] = {
-	N_("git psuh"),
+	N_("git psuh <arg>..."),
 	NULL,
 };
 ----
-- 
2.22.0

