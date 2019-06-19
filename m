Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 088591F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfFSVGO (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:06:14 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37378 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbfFSVGL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:06:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id w13so1296746eds.4
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 14:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VdLnT0ez1EMIfdC3FCjWfNOpGA2/FA1Og7dzu2n+60A=;
        b=cUf4Pxzfv7eC14nnvEouhwBA9pLT2NhTZLJZmHVTpSahbimbwksU2vWav9bXJQofRQ
         yPIPtc1GmljSz1xwr4Z7ilWqlbi9O1ePTpPBjBOXpVJgKboCzstXvDCl23ae8EqeNW2z
         JT6Sb4oSibAzHyX3f3i6byOWcqnhsEAdXBFQVRkm3ZKnqqgVvuf2eckdEwchRSED14fQ
         seDMQ4uUbcB/M8ZoWvKDcHGb+jJIjHjgFlShuuzk0nHw+ebI0I7dpc5lO6AGnlvb04lK
         n+UVBEtiUJq1CYrVZU9DOzmoaZeHcz/OPHRKPgTAN8fogy8FdFJmkQ7OvsTuGdaT8DFM
         tZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VdLnT0ez1EMIfdC3FCjWfNOpGA2/FA1Og7dzu2n+60A=;
        b=C4GOurD3kr/phMf0RkPqc7+TbFOHvHhHS/ivSHNLua983zQ61tE2x6CiNWqHnXPSU4
         fjjEmK7g7RLtzHvJTVlObaTokN1BY2e99dleSsCAc963L93ya0EUYqzNGXDtqHFqLM+d
         SFxUumIaB7YpCy7SmbjIHKHbk1Y7wt/dqBd6avlLFgkSmi/5+xrGsRjsiMHy2IQ99sbY
         7cg5/ufzSgPZGrM2GUP9TFZOEDCYb5ZHFkZoCUNaeT8c144g1uV82NxtlfPhXWzHAQ3s
         f43VpRJgooedFBINbKtQXPh3F5a4m4lpwE/AR2q65/0m0zZ7y8aBEEB9hUPQiWYVa1w9
         rqtA==
X-Gm-Message-State: APjAAAVhe1To72DF0rmKi6IoncSEUhiTIlF847KciiD4Mn7YyQMQ7F1A
        JmxkyD1v4huGDMGqDRxNLJtBVGhH
X-Google-Smtp-Source: APXvYqx1qzyXVWAAEZHKgqV1VFwVjitH2H20CIsD4QShxwhh8EztD3Xt5PhoiZUF3iPoMkwVbLW/qg==
X-Received: by 2002:a50:b803:: with SMTP id j3mr68363498ede.208.1560978369347;
        Wed, 19 Jun 2019 14:06:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u26sm5752059edf.91.2019.06.19.14.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:06:08 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:06:08 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 21:05:52 GMT
Message-Id: <c883f037e0c6fb408dbe0350f264c0b41e5623db.1560978354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v2.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
        <pull.149.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 18/20] msvc: do not pretend to support all signals
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This special-cases various signals that are not supported on Windows,
such as SIGPIPE. These cause the UCRT to throw asserts (at least in
debug mode).

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 667285887a..d01e88c2f8 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2119,8 +2119,33 @@ int mingw_raise(int sig)
 			sigint_fn(SIGINT);
 		return 0;
 
+#if defined(_MSC_VER)
+	case SIGILL:
+	case SIGFPE:
+	case SIGSEGV:
+	case SIGTERM:
+	case SIGBREAK:
+	case SIGABRT:
+	case SIGABRT_COMPAT:
+		/*
+		 * The <signal.h> header in the MS C Runtime defines 8 signals
+		 * as being supported on the platform. Anything else causes an
+		 * "Invalid signal or error" (which in DEBUG builds causes the
+		 * Abort/Retry/Ignore dialog). We by-pass the CRT for things we
+		 * already know will fail.
+		 */
+		return raise(sig);
+	default:
+		errno = EINVAL;
+		return -1;
+
+#else
+
 	default:
 		return raise(sig);
+
+#endif
+
 	}
 }
 
-- 
gitgitgadget

