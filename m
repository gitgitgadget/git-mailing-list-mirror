Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0F8320248
	for <e@80x24.org>; Sun, 14 Apr 2019 21:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfDNVTc (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 17:19:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36261 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfDNVTb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 17:19:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id u57so12290909edm.3
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 14:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q4W6RUTbEpyt8sOoPj2gEL1SKt0Obj6uSXUTnkdR+Go=;
        b=bjrdXTMTaas9ihHwrHtX4LVTR3cgsrJJAxqJmOs572elr7QUViJk88tG+Bpq7+8DJW
         6BOF7BBxDUQ+YT5atCdks+MspD5eNooOvh8XjpostLKT/sSWgG8POvkHBo0Xx9q8FjOk
         +CVkYaEoxT3YTbus2+X3ZFJkpyg6oE8GJHb6oZMrC0VA56KjBSdSWwZx/1uYvim+zRQL
         aSnImdO7F5Yy2KB80RYKLsM/uq5n+Tnd3o7gyVtjW64NbMWnJVgpV0P5MX+D8ODMGGzC
         7ZFjEHgYnvQBVyqlYkZ5NoTgy5iE/44HlETLnAfDlTzD6eNHLabHfiaVM8oZUH67ASVn
         ah+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q4W6RUTbEpyt8sOoPj2gEL1SKt0Obj6uSXUTnkdR+Go=;
        b=Ln8UVwg/ovBv6CtddutPaskv5urhizrIWFOGmzxuFzqox2QLyQW2Ltu9Bok9q9CIw/
         A6swpDydKii1qqgBsgWX3UupsB220rwILI8zpKkL4t1wsrLOH4NW+T7LjGUvLxME+Hjo
         /PIbyJNXGnqNwWcmHQGAJJChPGXGl24YwYdGR6p6jq7tjRxbBdlrXmD7lBHvmK+ioEDj
         YC5xU33/wZY3/8rfeVVh+NhBO9XLosl90tpjycEoxBzBfQf8iHRD9MdB5mVFcsE898XO
         ngXrhdnBkIriHTf5A6CzrWHAqet/YX/J/5BiU1ZCG1laAo0PxnzV7Yvevul5Rp2Ogoa+
         yO+Q==
X-Gm-Message-State: APjAAAX3rw3YSwGSOwE2NPQXFgCY8Azhq4MC6eSfD0bbpWAfYOuy2p2H
        o/4D+Iponq6V3n/7r0o6I/CjfCZR
X-Google-Smtp-Source: APXvYqxE0sG+7c0uKO4A4P7xUC8m0Qg4ILR4Qsk0NVa72//UgyhCNYVkPrsXeUSmSJZ28+koFr1qqA==
X-Received: by 2002:a50:ec85:: with SMTP id e5mr3494038edr.232.1555276769658;
        Sun, 14 Apr 2019 14:19:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h11sm8071040eds.44.2019.04.14.14.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 14:19:29 -0700 (PDT)
Date:   Sun, 14 Apr 2019 14:19:29 -0700 (PDT)
X-Google-Original-Date: Sun, 14 Apr 2019 21:19:26 GMT
Message-Id: <6161c76702246ab34a520dae8104ad489b89b6a1.1555276767.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.179.v2.git.gitgitgadget@gmail.com>
References: <pull.179.git.gitgitgadget@gmail.com>
        <pull.179.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/2] t9822: skip tests if file names cannot be ISO-8859-1
 encoded
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Most notably, it seems that macOS' APFS does not allow that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9822-git-p4-path-encoding.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-encoding.sh
index c78477c19b..de0b46581d 100755
--- a/t/t9822-git-p4-path-encoding.sh
+++ b/t/t9822-git-p4-path-encoding.sh
@@ -7,6 +7,13 @@ test_description='Clone repositories with non ASCII paths'
 UTF8_ESCAPED="a-\303\244_o-\303\266_u-\303\274.txt"
 ISO8859_ESCAPED="a-\344_o-\366_u-\374.txt"
 
+ISO8859="$(printf "$ISO8859_ESCAPED")" &&
+echo content123 >"$ISO8859" &&
+rm "$ISO8859" || {
+	skip_all="fs does not accept ISO-8859-1 filenames"
+	test_done
+}
+
 test_expect_success 'start p4d' '
 	start_p4d
 '
-- 
gitgitgadget

