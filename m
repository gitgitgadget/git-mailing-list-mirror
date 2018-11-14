Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D69491F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 16:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbeKOCgF (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 21:36:05 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:46241 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKOCgE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 21:36:04 -0500
Received: by mail-pl1-f179.google.com with SMTP id t13so5060718ply.13
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 08:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wEV9cIgWs525ZKGNeYbV877/nXZqz6BNojCLkSUJYOg=;
        b=AVTrRYMBh+/sIYz1LW6eivzV9xw1jlm6xGbLSUFCXkZzW+vaPFIMNlED5PT5RT2O8y
         Vn8C7G6vnv0i0MKBxf8APO+THB6shZaXz6Gkzv/EYsuatXlLym6byOXAaiOOOLgfd/CX
         viP1c/lsUuTFPfEFR5FinwJOozgFrZiyVic+nohdNzy38tqaygD9BgG7V57Nl+cwFWmC
         UXJkuvIkiyl4mbJXN7XHH7ifNK0cPRtv6BZPrMJyCyuunU8Y7ZGY86X5j3WlRQiAxQGe
         ZN9oGgu7fcV2/kfzuSknu/F/iUGvVICq7uPMKuTJomc5FWSrMmwC5InYucIavmauRip5
         sJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wEV9cIgWs525ZKGNeYbV877/nXZqz6BNojCLkSUJYOg=;
        b=HZMnTUNylmHUjsZjgMynEPxrNJYz2CXMHUAu+mr/35ziCejXxdL3Oq3SBFrQXBnhUA
         jIrp/MMT8bifXDP8TxncufvSsXVtc6+YcGF5pu60auKIfnWDtwbvLktA0beRwIH0mbeV
         7zgyV8i9c7uPsqrywYaLtH4D1+Nf5hoD35yNfKoCX8j3XD0QwCKIjH5TeYjkqqjxzgwg
         DfLni3/Bu2d2gXosiAuKqles34eEi6vRm8C7eVyM0iltGoeBwcqdmhsQ8HpBPSuhY10T
         +XWtZNmGOlM2X8Pouf1ElTcsLv6D806HIf+Qm7uWwWqj7fo635h0/Y6VB54P12gipu9w
         jCtQ==
X-Gm-Message-State: AGRZ1gJhOLOYl8ALLUGfV13cCUcci2lpWXcvO1dQuCELIm39rX0thd5f
        DZp18ntOcQ2hCAY9BJ0B78sjqjO2
X-Google-Smtp-Source: AJdET5eIbaW5Jt2G4hLaAaPvm/A6cp5rztXiBs6TttmkA2QKnB08J3N8NDjPbsxSV20Rtz2GC0Ikxw==
X-Received: by 2002:a17:902:768b:: with SMTP id m11mr2658681pll.80.1542213129588;
        Wed, 14 Nov 2018 08:32:09 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id x23-v6sm23698374pfm.126.2018.11.14.08.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 08:32:08 -0800 (PST)
Date:   Wed, 14 Nov 2018 08:32:08 -0800 (PST)
X-Google-Original-Date: Wed, 14 Nov 2018 16:31:58 GMT
Message-Id: <49e408677ad8e1b34e4b13a5eb759b1ead69cd50.1542213121.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.73.v2.git.gitgitgadget@gmail.com>
References: <pull.73.git.gitgitgadget@gmail.com>
        <pull.73.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/5] t/lib-gettext: test installed git-sh-i18n if
 GIT_TEST_INSTALLED is set
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It makes very, very little sense to test the built git-sh-i18n when the
user asked specifically to test another one.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-gettext.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index eec757f104..9eb160c997 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -10,7 +10,12 @@ GIT_TEXTDOMAINDIR="$GIT_BUILD_DIR/po/build/locale"
 GIT_PO_PATH="$GIT_BUILD_DIR/po"
 export GIT_TEXTDOMAINDIR GIT_PO_PATH
 
-. "$GIT_BUILD_DIR"/git-sh-i18n
+if test -n "$GIT_TEST_INSTALLED"
+then
+	. "$(git --exec-path)"/git-sh-i18n
+else
+	. "$GIT_BUILD_DIR"/git-sh-i18n
+fi
 
 if test_have_prereq GETTEXT && ! test_have_prereq GETTEXT_POISON
 then
-- 
gitgitgadget

