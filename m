Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84F3C1F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfEHLbD (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:31:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33279 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfEHLbB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:31:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so21777717edb.0
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=j8V88721/2PumHPJ2ELxOkBogxH+i+VuMHTZqzmnrw0=;
        b=P24/6R/lwkNOADhur+gegbWbfmz0FWQ6oBO3AidwKmdgA+kfQWLj2oyu0dX5/ko91x
         /l2U9UZ6TfAnbj3WLzFFelm/UvIj6YeWTbjokgAYfjdRn+TbnZxlW06iiVKCQwgzsbxJ
         v4ah83q0UUfLwnTz9tpz3qJMq/uwJdEY6k1A3FNfsurV1+HZshm5O8c6aBfihT+PTyHR
         V3Sba4DDouN07IhyAQtADM4fuR5brplTJ4dCXF3k2UZQ1Z2FcNoT97yXlzkLC1MQQ6U4
         WycXGlsnmZBsTMQYkjGb8qkYoxk02USWV5C7odRFip6YN3V8OnEbPaEdvNF4rI7rDy4z
         5ClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=j8V88721/2PumHPJ2ELxOkBogxH+i+VuMHTZqzmnrw0=;
        b=gpJDGmAGmZ+lCw3eKG3hCxsw1BAOWt0K/bray68s/nmnYl+0bxgU/oXEVw4hkWafjc
         LCWtIdQxIcaNo9gJdR1hZvXLmTwyyqamgvKKoOoD0/94ARmKMuFJOC3I4k783EtAVeWB
         IYoFeuim3r4Gingt5QN1c7U1IgRZ7vBH/UuHRTbUEm74tEVsigAdEWoEtdcxp4ARL8Xw
         VvBkMi5y6/E7jCVO/xGbq3mDC/2ju8Z50zgdAGLbpu/AXJUwjiGbomqPOmQg/RCCn21C
         CYbfW/rCYDkdCjPhDAPf5ctbhyy77uXOCOTqdjFCBAwjDD+3sLRY5HqR4oTWrBLI9kxg
         wUPA==
X-Gm-Message-State: APjAAAWzu9fzEMS7wU1aulIT40I6+IcWX+FSjGKfDaaMQr3Wm6PpYZW1
        WDb6A5QFNQrEHSnSgRpNEUoD44YOoHQ=
X-Google-Smtp-Source: APXvYqzwQ+bSEYQhmEjU6Cg3+qfFXX1lnVV1wQu5HlNfXUzwTs8eZlBqprBzD5Y4W9G8lQZHs4PVFA==
X-Received: by 2002:a17:906:c78f:: with SMTP id cw15mr8870589ejb.179.1557315059780;
        Wed, 08 May 2019 04:30:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t2sm5439140eda.41.2019.05.08.04.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:30:59 -0700 (PDT)
Date:   Wed, 08 May 2019 04:30:59 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 11:30:57 GMT
Message-Id: <9f1da73829c2275f6f65f7a6e385426aa7afa6c5.1557315057.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.134.v2.git.gitgitgadget@gmail.com>
References: <pull.134.git.gitgitgadget@gmail.com>
        <pull.134.v2.git.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C4=B0smail=20D=C3=B6nmez?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/2] mingw: enable DEP and ASLR
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
index f2ac755753..ea0df3fe1b 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -573,6 +573,12 @@ else
 	ifneq ($(shell expr "$(uname_R)" : '1\.'),2)
 		# MSys2
 		prefix = /usr/
+		# Enable DEP
+		BASIC_LDFLAGS += -Wl,--nxcompat
+		# Enable ASLR (unless debugging)
+		ifneq (,$(findstring -O,$(filter-out -O0 -Og,$(CFLAGS))))
+			BASIC_LDFLAGS += -Wl,--dynamicbase
+		endif
 		ifeq (MINGW32,$(MSYSTEM))
 			prefix = /mingw32
 			HOST_CPU = i686
-- 
gitgitgadget
