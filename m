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
	by dcvr.yhbt.net (Postfix) with ESMTP id 75F1F1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 14:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbfFYOtk (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 10:49:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43965 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731740AbfFYOti (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 10:49:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id e3so27492626edr.10
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OQcXUHxBS6yq224kqYH1CH+e5fbZrkv0VTnNS0DDVFk=;
        b=Zg7XiaJhMb/Iz0ic1RPf0RzIk0fnqsd/iUq13ah9lpwc9ud1ePfULrpQ60tDYjm58H
         991MwXH5qj281aEgZfj2T9zjhyHukye2feIPYGhiQGdtN6gbRFxKk41LgiHo6+S4+niP
         ANClIzMDBDd+LwJq0Am4SxthpxcepPY1zLSU442KV+7eEe2VWCxZVjwpGi73GSeNi6M4
         ZIZVvAJzH8gEXdUFMaAoDYlHO9jxTzUpqVybuewVhtigI0fw504xMjAPKUDnpYT188hc
         Pa4KZqPXTgEpq5oELbM4IB+8Ue72zK6THc4DoX4MPMs+YJ56qYARCtDLzSJFBW1Q6F+g
         GmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OQcXUHxBS6yq224kqYH1CH+e5fbZrkv0VTnNS0DDVFk=;
        b=mxsSQvV1a710x3eOkFRYN+/mqaOCElq1QhKEJE+2d+wX8kPH8355AWNLqq6DiIe3NB
         sjU3d7ZhXpls5BDPCCYVjIfqUKeL6LbwoV5xazabZn+U8hfJmC+hYH8HuaOeVgwFzGat
         xf/4I64cxnv1rfT/haNDKWHAEIT/bAwcXdyuw/sqe4JMURup6vmsj4U0Bw+fqyGlj61M
         LlKfeXMD7bnITQmiyBRGVHlMyvcJmg44hnx+ImJfBFHnN1MWmZOyn8dsGN5aVTZJoznm
         QD44BO2wXbSTxqmKjvX+mHxo3A2FhHsClyd6twGGkPHErkeT1kbKBtS2vnsccKJ8Xfeb
         G1vQ==
X-Gm-Message-State: APjAAAVWtSE2LxKgpNwT9PpYHQbdlNuwSQICk3P0qbkAsB7hDLGd1CVl
        xgzJQryUkgjx0qQaahAlgOT2WoYA
X-Google-Smtp-Source: APXvYqyM2fgbi6tjtg3zwWCj4HDVmfWaW3ekJn3KRi8amgNQDx3TbgO3hh4Z34vrCvJLORdxO288Wg==
X-Received: by 2002:a17:906:1304:: with SMTP id w4mr18323486ejb.159.1561474177053;
        Tue, 25 Jun 2019 07:49:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m32sm4918332edc.89.2019.06.25.07.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:49:36 -0700 (PDT)
Date:   Tue, 25 Jun 2019 07:49:36 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 14:49:17 GMT
Message-Id: <51d73c61d3fea7c02cf2c9622f6c492adf56502b.1561474167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v3.git.gitgitgadget@gmail.com>
References: <pull.149.v2.git.gitgitgadget@gmail.com>
        <pull.149.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 11/20] msvc: do not re-declare the timespec struct
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

VS2015's headers already declare that struct.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/mingw.h b/compat/mingw.h
index 210f1b01a8..a03e40e6e2 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -352,11 +352,13 @@ static inline int getrlimit(int resource, struct rlimit *rlp)
 #ifndef __MINGW64_VERSION_MAJOR
 #define off_t off64_t
 #define lseek _lseeki64
+#ifndef _MSC_VER
 struct timespec {
 	time_t tv_sec;
 	long tv_nsec;
 };
 #endif
+#endif
 
 struct mingw_stat {
     _dev_t st_dev;
-- 
gitgitgadget

