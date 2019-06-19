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
	by dcvr.yhbt.net (Postfix) with ESMTP id D7BB61F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbfFSVGG (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:06:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37360 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfFSVGE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:06:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id w13so1296287eds.4
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 14:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dqJHfuKTPsOY8evakM7j8XeIh7DKWK6mb9bcnQXq+SE=;
        b=ekWR9I4h35ycHS0a3ktjPauwcfhihJztP+Cens6oY787M30FveCkkKGmLbG0cSta4l
         FixCTdj1FGIk67jNOh9Z8781PTidnHd5GVtQZ0lFGcCI8TTV8XqzlQYObPbG/EdAwL/2
         7O+EXKmHyRPUevdnvY8Qy4WhOWk07i9L8chzgIAIL2phKjFuGQf36lcGMFeotlmHtzEy
         ZbAj1MZmTzdJK6cwu0y3qfK162RuNQjovJmKsJ/1hnzfPeGEWEl+dbiHoAkFZuoi/p00
         sVeuUVnrluXcGY1Nj5gE8EammfyMQG8qMOEfUkOdPzDgBjYnxFmoSeDZ/alE1rBbBdMX
         pn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dqJHfuKTPsOY8evakM7j8XeIh7DKWK6mb9bcnQXq+SE=;
        b=Mwpf2UBRf/w7gPUuHnA658nE69lUc/csL0cbWxbAu9PtsjD8TPcTqlnoIokinn0f6f
         WE17OJg9GpSFZMeHE2Imb4VsrgShPa6NT/QL6h3+WxJQqbngde7zq3HxbHhFmSFDvM+D
         4A8VaBvL3EBKiLWvAe87HpfkMQrDQZhz0ZhiioXZ3xsLLvxlyML1Tpw4H2ik/eZ3CyoU
         +0qYTZfaeAP8apYyWAJY+qvwqqXtfaQgoUCou/UPMEvW/tnOBXShN1/Ehz88RawsTDpJ
         xvqk54CLQ8caghAhBulqrTPcoTvfl30tvfXMYPpwq8kSHrnpECj0t58Lwe8qJb/oevyI
         w0lg==
X-Gm-Message-State: APjAAAUPp229GQEm7AVeLiljXPVwLLN0Ym3VH/n+rgqI+OMCgb7vUPqR
        2/WGshcftIzTaIXn60wIMKadEnfj
X-Google-Smtp-Source: APXvYqz1EA+kvpVkA/QWGha/+4t8jNy/Bnfy82btR0RB2JC+04Rf7C3n0Fgn6jhbKd1mGq6Xbc1jTg==
X-Received: by 2002:a50:eac6:: with SMTP id u6mr27657873edp.83.1560978362547;
        Wed, 19 Jun 2019 14:06:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8sm2393756edt.56.2019.06.19.14.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:06:02 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:06:02 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 21:05:43 GMT
Message-Id: <99a2939cc2d4501d37e806de9273c8f9832b7849.1560978354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v2.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
        <pull.149.v2.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 09/20] msvc: define O_ACCMODE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.org>

This constant is not defined in MSVC's headers.

In UCRT's fcntl.h, _O_RDONLY, _O_WRONLY and _O_RDWR are defined as 0, 1
and 2, respectively. Yes, that means that UCRT breaks with the tradition
that O_RDWR == O_RDONLY | O_WRONLY.

It is a perfectly legal way to define those constants, though, therefore
we need to take care of defining O_ACCMODE accordingly.

This is particularly important in order to keep our "open() can set
errno to EISDIR" emulation working: it tests that (flags & O_ACCMODE) is
not identical to O_RDONLY before going on to test specifically whether
the file for which open() reported EACCES is, in fact, a directory.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/msvc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/msvc.h b/compat/msvc.h
index 04b4750b87..d336d80670 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -19,6 +19,8 @@
 #undef ERROR
 
 typedef int sigset_t;
+/* open for reading, writing, or both (not in fcntl.h) */
+#define O_ACCMODE     (_O_RDONLY | _O_WRONLY | _O_RDWR)
 
 #include "compat/mingw.h"
 
-- 
gitgitgadget

