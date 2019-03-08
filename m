Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D222F202BB
	for <e@80x24.org>; Fri,  8 Mar 2019 15:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfCHPvV (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 10:51:21 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41190 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfCHPvV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 10:51:21 -0500
Received: by mail-ed1-f66.google.com with SMTP id x7so16770476eds.8
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 07:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fxDdFXOovv2IXcHzAzYH/IfMSiCt5yAu9UAtYQ1l73g=;
        b=ekx194H4U+aN1I2gR7AGF6m9Q4FxlxvAGPSy/KfbuuH4zgg/frDTK/9Q0cSKbFsOul
         LdbSf1KQXZdGJPpTqDWfoYN4GlRmDAeZhL6w1Uf8JMMDJxZfQPg/vtmcTudSEQMi/ztR
         /URPwiS+9l3C4eI2zPzShi4GIo01dEj6nLKY8Oj2LSqqdBAGTo9Kkl5v784slffUvfW0
         6oFobC0Pyvk+H2y4w0ywySj9cpbZpabHgwt1DqYr3f72AlOzs+nvTp2nYD9jloeKjwbj
         /FLczTbAGVGBp4h8vtXBFann1rln6o+l1XieCDsdtllZT9m0zPgYyW+xr4mK9ev9Hf5I
         jImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fxDdFXOovv2IXcHzAzYH/IfMSiCt5yAu9UAtYQ1l73g=;
        b=TJXgr31Mj/pwvaGDQg5E4B4Ww5+LfP8a00qFht9QB23HUmtTqhGipc/TdTHBNzvEH9
         NAwr2B0+K1jxzOn438uXOHn4zZ7YN/LO2cua6mGSu6MCfYO3w7OJ7yj/t2EKDO/rhJw/
         45PZSh4FFRvuexDxDxD+P8vldIFoXq8671mCYaHtmuxzEFRF9u7F4MFPz2B4I73Ovw5q
         TDE64TH8XYRKU2qiqQZTizRDQGKBW+mOzN0oEFUu4zA4N0qQktIeAGHbwr/YF/Qgdl5U
         yeY75UPnPJletAJCui1+co0oFYfqBDu89ix8YLB1dd3xb8zuVRc5MdTFWBUKYs1Ufk15
         /uUg==
X-Gm-Message-State: APjAAAVF8SxCdCUPx8/vujCLZb19n/fQhvGj9EDJxgsjEiwoWN+Yd+H3
        fZkdkPQssRRI8BwNMEWDUE+ZGN65
X-Google-Smtp-Source: APXvYqwjG8LKlbB+pcH/98u4f52jf3o/TjV9Z5YqZ0Fy/WpHpp2zqeuVXeHfYJZ4sjOJLGMs+Xdhkw==
X-Received: by 2002:a17:906:5212:: with SMTP id g18mr12133374ejm.149.1552060279537;
        Fri, 08 Mar 2019 07:51:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y55sm2372513edc.75.2019.03.08.07.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 07:51:19 -0800 (PST)
Date:   Fri, 08 Mar 2019 07:51:19 -0800 (PST)
X-Google-Original-Date: Fri, 08 Mar 2019 15:51:17 GMT
Message-Id: <ba1a87e845919804c86a7859abb85ec50125628f.1552060278.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.160.git.gitgitgadget@gmail.com>
References: <pull.160.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mingw: allow building with an MSYS2 runtime v3.x
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

Recently the Git for Windows project started the upgrade process to
a MSYS2 runtime version based on Cygwin v3.x.

This has the very notable consequence that `$(uname -r)` no longer
reports a version starting with "2", but a version with "3".

That breaks our build, as df5218b4c30b (config.mak.uname: support MSys2,
2016-01-13) simply did not expect the version reported by `uname -r` to
depend on the underlying Cygwin version: it expected the reported
version to match the "2" in "MSYS2".

So let's invert that test case to test for *anything else* than a
version starting with "1" (for MSys). That should safeguard us for the
future, even if Cygwin ends up releasing versionsl like 314.272.65536.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index c8b0e34c31..0207e895a4 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -569,7 +569,7 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	NO_GETTEXT = YesPlease
 	COMPAT_CLFAGS += -D__USE_MINGW_ACCESS
 else
-	ifeq ($(shell expr "$(uname_R)" : '2\.'),2)
+	ifneq ($(shell expr "$(uname_R)" : '1\.'),2)
 		# MSys2
 		prefix = /usr/
 		ifeq (MINGW32,$(MSYSTEM))
-- 
gitgitgadget
