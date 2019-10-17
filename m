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
	by dcvr.yhbt.net (Postfix) with ESMTP id 078A01F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 17:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394690AbfJQRrw (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 13:47:52 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:46743 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440976AbfJQRqz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 13:46:55 -0400
Received: by mail-wr1-f45.google.com with SMTP id o18so3317883wrv.13
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 10:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DdreiLdKx5xmBu5nCZ0pndGDt8jnPN/+cgUdRiriApg=;
        b=C9HEjZ4tv0gTNsDfl+A6KFQeoRe2iLhQcieXjKlII3tmqdC+nZ7t0Vu05a7LOA0ew7
         I8N8uTTceXhkoGLXBC3MBSx3TnS44QdXfGKegc54cQGrlPvJQ6eLCymZAlIfrtL2j97e
         GfTRhBpHJxedZzlVW/Phrx0m7ZE3kNDVXXT1t/22xZNAiY9Z8e1UXIFjrQ56jjxysH57
         UcUnvdcZawOY6r0fBl2ow+jvlnob2MbZCEAS32+i61qCP8mjYw++/iRG6pplqXy9SBUW
         QIQrh0MotU3O6M51b9oJ/E+62IZiuuAiZ6G2ODnwWM8wpx7+BCCt6hKh9zAI++lBUPyV
         I+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DdreiLdKx5xmBu5nCZ0pndGDt8jnPN/+cgUdRiriApg=;
        b=Td54l+0IpfJHwzeToCQ5QyuL1rbuPvxoQ4SJvMr+fjALDVNt+R7RLs6dbMvAm65Sn9
         iejeJGb//JZUoXSMMPeZfh66Qn1Imzo/0ZGxdp6kO4S54cpm9UFqLDdchz76MwmCHvn3
         YP4OKgUNY6HqFdFwSjwqZJEiCgAmXnr3wWqFEf28l8RGREd9Nuxw6ndpVGhxTMM4sczV
         eTJgQh3GVPj/7LVhl9SJzb+YDW2LFNKPWiRZ0KNKFET2HIAlbP7C57NVzX/dQCeBKbkJ
         iWdV0q8j4yLLJfLLnyceVei9cBp3IpC/zdV0oOaXmswdv6lUvqco8YGKAMsaXZAuQe6w
         Wj5g==
X-Gm-Message-State: APjAAAWvm5ZZc3SpmXEDbJJWNrhLgrLVg4e/OhsIvinpQHZTga/EKGkV
        PFv9UMvgTeKjjkhSMMfmhuS/2AnQ
X-Google-Smtp-Source: APXvYqxkq8onPZd79vVw38HbfB2JqSr3HmNTlBV0gMiilegbGkcrIHhQm8fqJDaTbTsWHtvZC9VWIQ==
X-Received: by 2002:a5d:408f:: with SMTP id o15mr3722964wrp.139.1571334413096;
        Thu, 17 Oct 2019 10:46:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u1sm3306464wru.90.2019.10.17.10.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 10:46:52 -0700 (PDT)
Message-Id: <pull.382.v2.git.1571334411.gitgitgadget@gmail.com>
In-Reply-To: <pull.382.git.1571250635.gitgitgadget@gmail.com>
References: <pull.382.git.1571250635.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Oct 2019 17:46:50 +0000
Subject: [PATCH v2 0/1] builtin/blame.c: bit field constants into bit shift format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

we are looking at bitfield constants, and elsewhere in the Git source code,
such cases are handled via bit shift operators rather than octal numbers,
which also makes it easier to spot holes in the range (if, say, 1<<5 was
missing, it is easier to spot it between 1<<4 and 1<<6 than it is to spot a
missing 040 between a 020 and a 0100). Also, bit shifts lead to low-level
optimizations because they require fewer calculations for the CPU. 

Special Thanks to @dscho for helping me out throughout the process.

Hariom Verma (1):
  builtin/blame.c: constants into bit shift format

 builtin/blame.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)


base-commit: 08da6496b61341ec45eac36afcc8f94242763468
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-382%2Fharry-hov%2Fenum-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-382/harry-hov/enum-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/382

Range-diff vs v1:

 1:  3b4b8e0353 ! 1:  838478a185 builtin/blame.c: constants into bit shift format
     @@ -29,18 +29,18 @@
      -#define OUTPUT_LINE_PORCELAIN	01000
      -#define OUTPUT_COLOR_LINE	02000
      -#define OUTPUT_SHOW_AGE_WITH_COLOR	04000
     -+#define OUTPUT_ANNOTATE_COMPAT      (1<<0)
     -+#define OUTPUT_LONG_OBJECT_NAME     (1<<1)
     -+#define OUTPUT_RAW_TIMESTAMP        (1<<2)
     -+#define OUTPUT_PORCELAIN            (1<<3)
     -+#define OUTPUT_SHOW_NAME            (1<<4)
     -+#define OUTPUT_SHOW_NUMBER          (1<<5)
     -+#define OUTPUT_SHOW_SCORE           (1<<6)
     -+#define OUTPUT_NO_AUTHOR            (1<<7)
     -+#define OUTPUT_SHOW_EMAIL           (1<<8)
     -+#define OUTPUT_LINE_PORCELAIN       (1<<9)
     -+#define OUTPUT_COLOR_LINE           (1<<10)
     -+#define OUTPUT_SHOW_AGE_WITH_COLOR  (1<<11)
     ++#define OUTPUT_ANNOTATE_COMPAT      (1U<<0)
     ++#define OUTPUT_LONG_OBJECT_NAME     (1U<<1)
     ++#define OUTPUT_RAW_TIMESTAMP        (1U<<2)
     ++#define OUTPUT_PORCELAIN            (1U<<3)
     ++#define OUTPUT_SHOW_NAME            (1U<<4)
     ++#define OUTPUT_SHOW_NUMBER          (1U<<5)
     ++#define OUTPUT_SHOW_SCORE           (1U<<6)
     ++#define OUTPUT_NO_AUTHOR            (1U<<7)
     ++#define OUTPUT_SHOW_EMAIL           (1U<<8)
     ++#define OUTPUT_LINE_PORCELAIN       (1U<<9)
     ++#define OUTPUT_COLOR_LINE           (1U<<10)
     ++#define OUTPUT_SHOW_AGE_WITH_COLOR  (1U<<11)
       
       static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
       {

-- 
gitgitgadget
