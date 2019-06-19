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
	by dcvr.yhbt.net (Postfix) with ESMTP id 839771F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfFSVGV (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:06:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39142 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfFSVGF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:06:05 -0400
Received: by mail-ed1-f67.google.com with SMTP id m10so1281786edv.6
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 14:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OQcXUHxBS6yq224kqYH1CH+e5fbZrkv0VTnNS0DDVFk=;
        b=dZsxrqP5KJ+FjfQ0YHQlTGCgFh9RyhJjfwlbCS4sBQ14utoDlfBuzc8lDag6pzoAyr
         9AvAaWIedf8qZMoURhemyfGMK/giFVDknmTB9lckQrw+YByP0vIe4w/7zmpz5jzWo9cC
         QZ6PEJR/b3BMhESrUotp9xUPfXGqz0cY4hkW2CA36v5ltON6DW7zwZ8KoqxCAbmaN0Ep
         T6SsQVV3dIEt/e35++xGIAmlIibuk+ozm3RmWifammziUNruVLwLMCc25/NeYN6tbzlG
         R5pUli/98yFHmn7LCFx7upFqGeZr/oV8VcjmEmW4MFgxUkwJgW2ZDGgU5803uvh7g0cK
         8/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OQcXUHxBS6yq224kqYH1CH+e5fbZrkv0VTnNS0DDVFk=;
        b=A/lD0SqW7pF+eJnGHK0R/SQ0EMagHWHa3pO79Sjsh1PWp/5Ajxaql7WLl96Hz8UJkL
         HoKvUVyb9kYK+mhDqn1S5fDIitfI6D3HENEvtJaXly5GYEo7TImFNnZynQOmv90V/MBi
         syAaQi+bKdhCrN3j94eiaVDlAtkeE1edo+W+dbqwruSyLwvnozSomz8+LBRguON36DO2
         46u3ekeo9CWmL4MtH2gKxvhOcQq0ebCwoS4Np0dGQKp4pjsHf407+IWcQ+kFcIF5hqtK
         UrUwXpjHV8fF7eqqU5SHKkou3nCAVUlVAM1r71rJaufzbygtUHbsoLMGuO1nNrOfpiNb
         x34A==
X-Gm-Message-State: APjAAAVHPbAIbduZZjSjrSCKw0IfVonLyZXdfrn45i6uUvm5n8Fl+Fmm
        Xh/t87Bss6iTb9tOAfCQZqaaLx3q
X-Google-Smtp-Source: APXvYqx/q4IRr7UZX8O9TrORVofBv3D7ic9o6B49Ih+VlFFa9WRDGkKTpIxXI0sd2wlGgC/y7bOsHQ==
X-Received: by 2002:a50:95ae:: with SMTP id w43mr106486281eda.115.1560978364001;
        Wed, 19 Jun 2019 14:06:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z22sm6059086edz.6.2019.06.19.14.06.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:06:03 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:06:03 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 21:05:45 GMT
Message-Id: <51d73c61d3fea7c02cf2c9622f6c492adf56502b.1560978354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v2.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
        <pull.149.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 11/20] msvc: do not re-declare the timespec struct
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

