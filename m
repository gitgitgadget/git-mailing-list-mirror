Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23C011F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfEHLbE (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:31:04 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42629 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbfEHLbA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:31:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id l25so21749288eda.9
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=MyXguMVOZzDKZ26wfblz1GvTms7i+mH82c6ZObZIiSA=;
        b=R+IOZ5bRqPY0Ega/U+e3xZyVesM61QlrldidD4fdhqi9ghanxOS95MR7NXKucEWS5S
         CdZve3/EuCMCmO31doFSwdhtKll7M55nHwOO41ehw2BzjuzPX7VAGfDZqa646hEUJYgO
         D6U5A98lw1Nryf15z01eNIpyPy+Jya8fNmImCuoQaqLNSkCVgrxewrGo9txmtu1SXZGt
         J2v2w+EgYWaScaNO+ggOyaU0343sKQyTrkWueKQCg8F+WfVI64FkezxDNwVLly+9YWx+
         7jJMhg9zlKdmSqEKa5n/5scTmiMvZ4uPrtbVW2UE+P0BccaPxJzo8Rfh4hVKjG1KLBgY
         K++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=MyXguMVOZzDKZ26wfblz1GvTms7i+mH82c6ZObZIiSA=;
        b=tDcGjG4rWWr3SA25Nym+T9xRc9YJyjIaVX3JhE3Cb/VMoBkBQXqbMdwWzMMxVk1paK
         6tGu3YoquGiIqXsN0hX2Wf/eyBPUKasI9NLw5SU5LopUEwq6ZN7baLUXwTWH5I8nMpn8
         5EEvAvQWfo3jxr+Dd8ZneJcwEMy+mfHbpDWTOHPHHD6jqm9C9esvq/DUGyFX+L8mDZOn
         I8s6h55Uu0QK0ngUR8oeGFxX0maflqPAiRN9KdDbi6OwFsaqI+xABvrM5q+FsJxJicp8
         Z6wNvDT5gM3ER3C0/QFzxSv25EWQClvsCge3njjj4UG3+Z5qazO1mar/Q/vVO6Y9Ea7B
         ff7w==
X-Gm-Message-State: APjAAAXH6cHpu7L0lrH3Eb4k4uQTdcb3jum/YcoT8nIxmc+j0Xab/DmA
        c5TO2/5Eg9SFJR1C9TttkILeeoCJeeA=
X-Google-Smtp-Source: APXvYqw4t0Eq4uYs/84D+qOULuzOK3t5A8l9sSoU0Oy6IYon6aqHoBUJGQoXlGzDHQnpMAr7hrjmEA==
X-Received: by 2002:a50:9968:: with SMTP id l37mr38772874edb.143.1557315059077;
        Wed, 08 May 2019 04:30:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f44sm5080079eda.73.2019.05.08.04.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:30:58 -0700 (PDT)
Date:   Wed, 08 May 2019 04:30:58 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 11:30:56 GMT
Message-Id: <828913e96c77ba4eb94b35cb4c1f1bf92b2e1c3f.1557315057.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.134.v2.git.gitgitgadget@gmail.com>
References: <pull.134.git.gitgitgadget@gmail.com>
        <pull.134.v2.git.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C4=B0smail=20D=C3=B6nmez?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/2] mingw: do not let ld strip relocations
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C4=B0smail=20D=C3=B6nmez?= <ismail@i10z.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C4=B0smail=20D=C3=B6nmez?= <ismail@i10z.com>

This is the first step for enabling ASLR (Address Space Layout
Randomization) support. We want to enable ASLR for better protection
against exploiting security holes in Git: it makes it harder to attack
software by making code addresses unpredictable.

The problem fixed by this commit is that `ld.exe` seems to be stripping
relocations which in turn will break ASLR support. We just make sure
it's not stripping the main executable entry.

Signed-off-by: İsmail Dönmez <ismail@i10z.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 3605fead53..f2ac755753 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -576,10 +576,12 @@ else
 		ifeq (MINGW32,$(MSYSTEM))
 			prefix = /mingw32
 			HOST_CPU = i686
+			BASIC_LDFLAGS += -Wl,--pic-executable,-e,_mainCRTStartup
 		endif
 		ifeq (MINGW64,$(MSYSTEM))
 			prefix = /mingw64
 			HOST_CPU = x86_64
+			BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
 		else
 			COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
 			BASIC_LDFLAGS += -Wl,--large-address-aware
-- 
gitgitgadget

