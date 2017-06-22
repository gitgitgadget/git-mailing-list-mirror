Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3AF11FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753525AbdFVSoH (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:44:07 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35710 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbdFVSoF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:44:05 -0400
Received: by mail-pg0-f51.google.com with SMTP id 132so11348225pgb.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3ybxDyfGMpQBZjiarIw2ZB/j11GJ+Az7CntbKC4Ql6s=;
        b=kSWaDK/rSG+XIrdd5RlZLGKim2ML9Af7j6NZ1gTHhHIvSLXJZLE2fdVGmz77wqCuXx
         NUdm3b6gHnIh83Pe6ma4Z/XTwQHICQtjmmXzxWbUBjDNdkmJ42y2a3hwFPO1zX8SCM8q
         RVb8dpCdH4bAJ8vC4wjPiyGiGLXIPpcPZEtOPcetZjf5/Go3779/+cmSh+F/a+K5oguf
         F1Im8QO0KFw0lwoTt5pxeDNysv/c0XBE/caGAhVpEWzO97Uc5MkX+533pz4VRzIG1hcp
         PbFaPMT5yG/hfwJFViBE5Wx64MytPdUtdcZDNiNYSFcGNbVvM4I3pW4hZRCXGpgQ/Qd3
         Yrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3ybxDyfGMpQBZjiarIw2ZB/j11GJ+Az7CntbKC4Ql6s=;
        b=G767T4LNPAp/AiJpRyIBbV9ia0/WheOxVcQCUqxLeb3WYkuxmcKWYPzwQEEFYD9AwM
         rEMD8uvADlMCPsKaZX6/+NniA9BqkogsYAATljvmkTh0XvYim5ysOVziPLr/fkFblILH
         8v22kTyF67vhtfO/klSjke4LxY8+JnQj8dUneN0jxOGccQniBwlob0LE9T9PkIoEpjbH
         xvt6jSaamYMkmp4r6nPhsLcqx9bhrcKRtwIujaHOYq2VHVZrueICwmbxHKS7MLHIbBKr
         iuBGV/GYyTdVgBkf+cCmqvPd1z5vmyre/JFJABO0pkVeH8yp+M52XuF1upYgdVO3ZglR
         Dg9Q==
X-Gm-Message-State: AKS2vOz1Do/gAl4LbRFlenNsxP1Dg+SWbmRHiSkOaXv/9uwVUIhZ/9SN
        G2Xe8RoYtBqDu+vkfFJucw==
X-Received: by 10.98.88.132 with SMTP id m126mr4084614pfb.180.1498157044393;
        Thu, 22 Jun 2017 11:44:04 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g78sm5222211pfb.122.2017.06.22.11.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 11:44:03 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 02/20] setup: add comment indicating a hack
Date:   Thu, 22 Jun 2017 11:43:30 -0700
Message-Id: <20170622184348.56497-3-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.704.gde00cce3c-goog
In-Reply-To: <20170622184348.56497-1-bmwill@google.com>
References: <20170620191951.84791-1-bmwill@google.com>
 <20170622184348.56497-1-bmwill@google.com>
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
index 24a738b0d..b477faa44 100644
--- a/setup.c
+++ b/setup.c
@@ -1079,6 +1079,12 @@ const char *setup_git_directory_gently(int *nongit_ok)
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
2.13.1.704.gde00cce3c-goog

