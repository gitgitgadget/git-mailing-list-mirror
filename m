Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0449220248
	for <e@80x24.org>; Fri, 22 Feb 2019 22:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfBVWZP (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 17:25:15 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33439 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfBVWZN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 17:25:13 -0500
Received: by mail-ed1-f65.google.com with SMTP id c55so3129345edb.0
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 14:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+HNHRZvwJJmm0VWKLgMxINFpvo+ixKycoqwfuPzDbZo=;
        b=dNxXK9KW27Mxhp+iaHchEo8pTABT5hWnmmrEFWN3cMG60kTvBI8zdGosg6Jd09RfBH
         nKIjkxsKyfXNctxoOyVNHJ/PmnHYz083oFJOpwb0qpnp0tpNazj/egYchuNSEOxhFR6b
         llyis3ZkC/N9fvX3bcoS/A3FVtBLQvZPr0JE8tAqTNBMi0xUqYUJwueWB6rZWvmfqgCN
         9iLliLbTuGvwPt1mo2L0YiMNg3VJ6/Xs8FZvRaoeDLVldi1EGT8TBrcUxTyE/QISQKr7
         muRiOigsTlsv/Xeyph01zM0pH9MQ0om1nXGygn7Ta7QWrxao+jbXz7Cew9wLCWJ6uKG0
         PhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+HNHRZvwJJmm0VWKLgMxINFpvo+ixKycoqwfuPzDbZo=;
        b=nwLOOijRCms6wWjM6+VyLkFl94MXolvUmRP8XVVehf9LF7EnPucqO1VI7/PTN71lKG
         5t1qsINSxZ6YlOJQ0cCpR3YtxoAXNBkeLAJa+Wo3CdjXnB6aOMLNYJuyEqPeSMvhcWoC
         6qqXU+L1Of5Vt2G7p9cmPo8tjap3tDi6Ww/vVU+HsZD+J1+wOeBtvzrlsyE/pFreXUS4
         7d6K6LlfS89bEpNKY/qp/QwwS/RHQfkWoIwhIHOUQSk3OwS6s4M08pxPASEGOfijg0oz
         WvlwqrCy04Z5iFuCZWlptLBolDgM3DWCZNwcbf8uSVo/ksyyIZJWNMB/Cx39rAQblpUU
         1GXw==
X-Gm-Message-State: AHQUAuaIxuR7MdrvjK0/Opn0GOHqpYlaAy8JPItfv0amY3lZa2+WzWSF
        b9LhESzTjFrbfhSJTQ+iHwyzXjQE
X-Google-Smtp-Source: AHgI3IZyTYAtQ4vAWdqUsm2RWPZJ/OkP4xuSF3Fs+XKtmy/cKBy4IxhlscHkH3MKNLOMZiX1Ftbi/w==
X-Received: by 2002:a50:92cb:: with SMTP id l11mr4859493eda.25.1550874312001;
        Fri, 22 Feb 2019 14:25:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g24sm702088edc.67.2019.02.22.14.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:25:11 -0800 (PST)
Date:   Fri, 22 Feb 2019 14:25:11 -0800 (PST)
X-Google-Original-Date: Fri, 22 Feb 2019 22:24:58 GMT
Message-Id: <662201f49e2da012422b8a70d39b24e387c8fc7d.1550874298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v7.git.gitgitgadget@gmail.com>
References: <pull.108.v6.git.gitgitgadget@gmail.com>
        <pull.108.v7.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v7 15/15] trace2: add for_each macros to clang-format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 .clang-format | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index de1c8b5c77..41d4cd23fd 100644
--- a/.clang-format
+++ b/.clang-format
@@ -149,7 +149,7 @@ Cpp11BracedListStyle: false
 
 # A list of macros that should be interpreted as foreach loops instead of as
 # function calls.
-ForEachMacros: ['for_each_string_list_item']
+ForEachMacros: ['for_each_string_list_item', 'for_each_wanted_builtin', 'for_each_builtin', 'for_each_ut']
 
 # The maximum number of consecutive empty lines to keep.
 MaxEmptyLinesToKeep: 1
-- 
gitgitgadget
