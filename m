Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2876720248
	for <e@80x24.org>; Sun, 24 Mar 2019 15:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfCXPw2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 11:52:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50678 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfCXPw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 11:52:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so6513998wmi.0
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 08:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dZKZAgHAaFOn3B61rud3slAFxRIYHbSAzh78HP3T4BU=;
        b=g5teVSebuDP5VPS7+toSyLIRDm2vdsFwSjSapmRtysGbOfjgbosGADbEvJlgXNQ4Yz
         /h8njApPky4eEue9eumxj8sGTy2yjWywmWDBywImj5GR3JN6K5Igj3vbRioG3d/hH6rQ
         sxAaB/wE+c1bnWKP9rjyj0JF+WfEeL8wU8YnhI/U2AGeUL6EDxEm86TdWlTGdIR3JnX5
         JlWA+ys2B6OrlPJuVfTAwVuWO/zoP3G2mtF3MGWyX6m0m0cgjMSu9t9/G3t1CXCJzuEM
         zIAXIEZ6tN9/wicx7bngxtdyCsvu/0n3ADDwBD/GVYQQQ5Hfk1OiXGzX0ubhICWYFcEh
         ejOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dZKZAgHAaFOn3B61rud3slAFxRIYHbSAzh78HP3T4BU=;
        b=cHy1BrJVAAp5HSFIduYqgiShBNGef9AX4I5Krhv6YTPPmIOUGSLn2WskNRIw8IPABL
         MBb/mze+WfrLHdkDtc4S3pqUoxwjImYz5qbK4700Wm33+70pdqPXtsXxv0YwqriFF2Bz
         9vIBTXDTxTaAMqbLP18XVFajCibbvcvT8ujntOW0E3I7FD9yqVy8cbQ68gjaOQAgvLl5
         YscHTOCni/YlZdi0XhIHyOOjAWTV8ALDndZmUXW98+D1v/FFRxdNPB7/Zy4+G0XdOYhL
         RyG1RkcFJG64XjRnPTZm5ckPtzDwqY3IxnSDuZLqVMRZumLF9Y7NK0NuAl1jXOKbbU2x
         V9CA==
X-Gm-Message-State: APjAAAWkTwZuqVU0eYePWcwhq3Vez5/C1vgsmoKKUPk2Qj2WTCgekGL4
        jTcqW77ZXZ1ezUC1kD8A5z99CKQr
X-Google-Smtp-Source: APXvYqxe9lvmkmavNmFnobPorDJYUeDm9UkWSu4ud4LHnPSN7PjxoEEsXe+CJHjV9jjNodKsOFu7HQ==
X-Received: by 2002:a1c:a54b:: with SMTP id o72mr2878599wme.60.1553442746320;
        Sun, 24 Mar 2019 08:52:26 -0700 (PDT)
Received: from localhost.localdomain (x4d0c479e.dyn.telefonica.de. [77.12.71.158])
        by smtp.gmail.com with ESMTPSA id y1sm31197407wrd.34.2019.03.24.08.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Mar 2019 08:52:25 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/3] Documentation/technical/api-config.txt: fix formatting
Date:   Sun, 24 Mar 2019 16:52:18 +0100
Message-Id: <20190324155219.2284-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190324155219.2284-1-szeder.dev@gmail.com>
References: <20190324155219.2284-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some more recent versions of Asciidoctor issue the following warning
while building the documentation:

      ASCIIDOC technical/api-config.html
  asciidoctor: WARNING: api-config.txt: line 232: unterminated listing block

This highlight an issue where the length of the '----' lines
surrounding a code example don't match, and the rest of the document
is rendered in monospace.

Fix this by making sure that the length of those lines match.

The page rendered with AsciiDoc doesn't have this formatting issue.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/technical/api-config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index fa39ac9d71..7d20716c32 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -229,7 +229,7 @@ A `config_set` can be used to construct an in-memory cache for
 config-like files that the caller specifies (i.e., files like `.gitmodules`,
 `~/.gitconfig` etc.). For example,
 
----------------------------------------
+----------------------------------------
 struct config_set gm_config;
 git_configset_init(&gm_config);
 int b;
-- 
2.21.0.539.g07239c3a71.dirty

