Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70F361FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751658AbdFHXlh (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:41:37 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33585 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751650AbdFHXlf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:41:35 -0400
Received: by mail-pf0-f173.google.com with SMTP id 83so22169563pfr.0
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9EgACBLpoPgX4XXYcp9j2TCvt69hLAmEi48C8Mrzw9M=;
        b=SSJQmoJ7/4b0uQYsM2X7d12da2Of1EmnGzggDgdeZfevKYYO2+P/Pi33UgZ3I26VDC
         W+EQr3AG8rTEX2cF/AYwb0IfHQ0vLvqLTqEu0GQ1qme8dKO2cVAMQ7ckSOvgAdR+O2zI
         7eDsIo67ZtzfFB+sTsr9N82n2XQJq80QTMDtKBE4eiaoTffwDjYN7XDsuRt9QH9mrbUz
         uPXeax2AxTc0Sh4fU2R0s8rx5lhqp4S3tYqo1kRunPk9TdHBOr/CuVi7UkPEj8qx0WE9
         uXhrkHnXxKlQgh29KcTQrNZkvRedalcYbuel9XLPO9qf5S9+6aLdYcyLrajQoX4dNwch
         Xj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9EgACBLpoPgX4XXYcp9j2TCvt69hLAmEi48C8Mrzw9M=;
        b=RgPtOFRHselwtvpsdpHs4kfm0CgwhKr8HpBhRPPXYXde6v7jUsk9H9ZxUzj7sebyCF
         70M9RfA+PYy659bI116rrOoeWlO4byjedU3RNyrP6ZpRxAg+YgZOxYFKpKM7WbrM/4YY
         GcszYVgHXjFLuPOznEYou8MR+Qt90ibL0HkNtDhpOWxnA4KeXL91OfTxy5ZrWH8Z3Btn
         JrXw86JeXzDvZZp8fN774R273RmX0Xcn3AdvmeDz+Sd/cyxteikfeMT4msGFoeMXbPb8
         rwLKmgEUw7mLgccp51zHaONhOuu/NGOGqeNjDtzlSurQ4kLZf/7IRjgPx8ovNK3dnWFK
         K6hA==
X-Gm-Message-State: AODbwcDGnWzaaGXuzXquk5vhOsxgYk5Im7vkH2AP6mZEOlYVvnf1EkFU
        K1aZJrlBx5lGaWb2qkqN4A==
X-Received: by 10.84.150.130 with SMTP id h2mr16476997plh.152.1496965289832;
        Thu, 08 Jun 2017 16:41:29 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:28 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 10/32] setup: add comment indicating a hack
Date:   Thu,  8 Jun 2017 16:40:38 -0700
Message-Id: <20170608234100.188529-11-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'GIT_TOPLEVEL_PREFIX_ENVIRONMENT' was added in (b58a68c1c setup: allow
for prefix to be passed to git commands) to aid in fixing a bug where
'ls-files' and 'grep' were not able to properly recurse when called from
within a subdirectory.  Add a 'NEEDSWORK' comment indicating that this
envvar should be removed once 'ls-files' and 'grep' can recurse
in-process.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 setup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/setup.c b/setup.c
index 884a74a54..aca1cf5d3 100644
--- a/setup.c
+++ b/setup.c
@@ -1057,6 +1057,12 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		die("BUG: unhandled setup_git_directory_1() result");
 	}
 
+	/*
+	 * NEEDSWORK: This was a hack in order to get ls-files and grep to have
+	 * properly formated output when recursing submodules.  Once ls-files
+	 * and grep have been changed to perform this recursing in-process this
+	 * needs to be removed.
+	 */
 	env_prefix = getenv(GIT_TOPLEVEL_PREFIX_ENVIRONMENT);
 	if (env_prefix)
 		prefix = env_prefix;
-- 
2.13.1.508.gb3defc5cc-goog

