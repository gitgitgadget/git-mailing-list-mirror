Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1E1D1F600
	for <e@80x24.org>; Thu, 20 Jul 2017 14:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965645AbdGTOTx (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 10:19:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35510 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965632AbdGTOTt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 10:19:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id t3so2731038wme.2
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1qD01O2xDLON6QT4JFLnSzIttyxGRVskeK3SGEyA3dY=;
        b=b2hiQKqCmSm2W+vfTuPqLAAXK7icbDsgbyWxNd0vEM2ngqmb42RL9pZ25bWchpHvtu
         jjkge34+JpmYupiEaVEtmyQAp0tU+Id96bJDN3ZtR3X97kSy2I1hsPuaHGuiNPYGHUmI
         9JMDE4gss3DjeWqG7bXWyLVYhbnkR/TXv10Av7182QNY5tP+zpyXAKNSmp6U0FxmsYyL
         4OM+JbZGLxt2g9OY0NNkcV9UNW0DucOvdIG9umN9U3pW94HnYzY8o/3FIbqUuAvUPOTM
         na5CSrggrO8ISs5NGlH89peOxcQzNcVYSUAHl9pdTwDB36baegkwkJafz1YfRCl7xdci
         GsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1qD01O2xDLON6QT4JFLnSzIttyxGRVskeK3SGEyA3dY=;
        b=rWpwkYMGAjxZM76NUQWbivjYAdqmlT3/frk0hqwMFBupXJGrmhor/Rb5FpLteKlxiJ
         pLLQrOozEem6PZwoid2CxZnmo4XLIH8YW4ZoU5ejuYZjdAmDfgIfXLkH3VrMF9ZbzF69
         pGKI48YKM7FTlkbN2r8iiGeBHuI5bkX4b0/0ahcqabC0733H2/5ZZSFnotuCOPNxvZRi
         pJ/mBlur4ugVShoI68DKur+r6aFWNldXB+MOPcYXTmfZQStIXFX7zxV0sE0J5LvL20vJ
         on1yz/3Y7ZhhPZjssGtI70ARF1CVoaQyZz4JM93d+RfiDhhFKAdAOJsBWoQ17QP98QDZ
         hakQ==
X-Gm-Message-State: AIVw1109Vhg7zfcx6dtEgQrE8T2IrXNh07bhi7QWMM0T2rOwyGw2tQ57
        +2RVOjRLyxrRkxXJOzE=
X-Received: by 10.80.148.211 with SMTP id t19mr1234227eda.128.1500560388274;
        Thu, 20 Jul 2017 07:19:48 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l24sm1630566eda.11.2017.07.20.07.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2017 07:19:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/6] RelNotes: remove duplicate mention of PCRE v2
Date:   Thu, 20 Jul 2017 14:19:26 +0000
Message-Id: <20170720141927.18274-6-avarab@gmail.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c
In-Reply-To: <20170720141927.18274-1-avarab@gmail.com>
References: <20170720141927.18274-1-avarab@gmail.com>
In-Reply-To: <xmqq7ez6hk2y.fsf@gitster.mtv.corp.google.com>
References: <xmqq7ez6hk2y.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That we can link to PCRE v2 is already covered above in "Backward
compatibility notes and other notable changes", no need to mention it
twice.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/RelNotes/2.14.0.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/2.14.0.txt b/Documentation/RelNotes/2.14.0.txt
index 0e363f2af3..fb6a3dba31 100644
--- a/Documentation/RelNotes/2.14.0.txt
+++ b/Documentation/RelNotes/2.14.0.txt
@@ -88,8 +88,7 @@ UI, Workflows & Features
    learned to say "it's a pathspec" a bit more often when the syntax
    looks like so.
 
- * Update "perl-compatible regular expression" support to enable JIT
-   and also allow linking with the newer PCRE v2 library.
+ * Update "perl-compatible regular expression" support to enable JIT.
 
  * "filter-branch" learned a pseudo filter "--setup" that can be used
    to define common functions/variables that can be used by other
-- 
2.13.2.932.g7449e964c

