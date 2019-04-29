Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 698D81F453
	for <e@80x24.org>; Mon, 29 Apr 2019 21:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfD2V5C (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 17:57:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33691 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbfD2V5A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 17:57:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so1871579edb.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 14:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=VGgA1BE4XPfaJ6kS1ksrSfbmPe1I1zHp/61+638siEg=;
        b=Jo521YENr/vsGx+f1gG26HeX/M7xpK8HMiAD/6o4R+QBSzgJ632ox45wI4/gLEdw+Q
         Y8agU3QcP56eflpkeV3PzU3KNbSocO/kZvDesvy//at02DhEeLo6tQrIraTF71DY7r4B
         u56bk1NeMLsKi/0oEPh6/QRNmNSNSG6jKGyzedXs8yJqOoViwxceBWCgnYGCt2LsqKwz
         M/ESXCdI588xADtGCm5J/vKbT4OmmeSDZj5FYEvrNV+ctyTpKp3Kq4Ci6t7vn+B4uxlf
         7RJN2XUp/fWzhYp6hvUG/jd2+FhmDrEsQgSbDrLx7rU4JhyKXODxesYKuEldY+rCsC86
         wm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=VGgA1BE4XPfaJ6kS1ksrSfbmPe1I1zHp/61+638siEg=;
        b=EwYKAFWFKxOaSY87oC0p5HmWNFLGgJYruOQk9sj3xrFFNTvUuG8DF+4HLoV5T6Qz7Y
         eFzrn8Bpg9L0+NYKGzMnkZMXtjn6x/Z7xxl2mscwEgG4kSvwjc28uuRXtZTtPwOLldto
         iFppqBcKONJeSzX0zO0AQ06/gCYo4WTRJkPkO3npNzQhp+G441JCwoUEqr+ort6MUsgk
         3NOTtGxFpGiUMYcwmmDEZMrjfrSjtVzrvQxW63bNgA+fgPXDksvzsBP8GPPauGx93NPW
         kXx+PxEGMVihQj/AZZL2KaPrROSuc0U5Mbt/YMaVqJvZIEc3NGFBnXfkvr3hBTjTPQpk
         cLyA==
X-Gm-Message-State: APjAAAUoTjo/cMC2wROGCeW2Wi6okKShweAi8Lvh/YYx3yRXtiV15EkW
        d4kk3iTEtXnw5P2665nV2hHmGr7w
X-Google-Smtp-Source: APXvYqwwl8ISXTO1DSLuS0cSh8jBqfeQNYFKU00r7JmX/MKnewlAqxTJ5BO3MUMq8jz3Q2gbPprIdA==
X-Received: by 2002:a50:cc46:: with SMTP id n6mr30150650edi.11.1556575018570;
        Mon, 29 Apr 2019 14:56:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j10sm6073584eja.58.2019.04.29.14.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 14:56:58 -0700 (PDT)
Date:   Mon, 29 Apr 2019 14:56:58 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 21:56:55 GMT
Message-Id: <e142c1396ec3541486317819e885cf42be24af34.1556575015.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.134.git.gitgitgadget@gmail.com>
References: <pull.134.git.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C4=B0smail=20D=C3=B6nmez?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] mingw: enable DEP and ASLR
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

Enable DEP (Data Execution Prevention) and ASLR (Address Space Layout
Randomization) support. This applies to both 32bit and 64bit builds
and makes it substantially harder to exploit security holes in Git by
offering a much more unpredictable attack surface.

ASLR interferes with GDB's ability to set breakpoints. A similar issue
holds true when compiling with -O2 (in which case single-stepping is
messed up because GDB cannot map the code back to the original source
code properly). Therefore we simply enable ASLR only when an
optimization flag is present in the CFLAGS, using it as an indicator
that the developer does not want to debug in GDB anyway.

Signed-off-by: İsmail Dönmez <ismail@i10z.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index e7c7d14e5f..a9edcc5f0b 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -570,6 +570,12 @@ else
 	ifeq ($(shell expr "$(uname_R)" : '2\.'),2)
 		# MSys2
 		prefix = /usr/
+		# Enable DEP
+		BASIC_LDFLAGS += -Wl,--nxcompat
+		# Enable ASLR (unless debugging)
+		ifneq (,$(findstring -O,$(CFLAGS)))
+			BASIC_LDFLAGS += -Wl,--dynamicbase
+		endif
 		ifeq (MINGW32,$(MSYSTEM))
 			prefix = /mingw32
 			HOST_CPU = i686
-- 
gitgitgadget
