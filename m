Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA1BD20958
	for <e@80x24.org>; Mon, 20 Mar 2017 19:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755894AbdCTTgW (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 15:36:22 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34391 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755284AbdCTTgV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 15:36:21 -0400
Received: by mail-pf0-f193.google.com with SMTP id o126so18781469pfb.1
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sqpvIyXv5al4yPo9xr13UM11/YSyMcIv5LmmLgrv4R4=;
        b=KcFjC4MDOBBSMdctuJme3dMkkVtaJDaVfHVKJK7APgDOYe0sDVI8lWFMF3Nb+T4qUm
         oU/ktvuth4RM5oPEZTWbA50vxd4BzAOQpjh/GEIaSBxZL1UY98cjRCa5KXDWnYzipFF6
         MfNh5j+xPxKM4efiD74MaVoTiWdrQu5xlVuQLee5YxVsTJfNW+9B2A3epJLmbKxU91BB
         TLEZm00dzEs1qAH5Wk84ok7fozHJntaPq7vuG5pbzojO0kjtYSukWMAffi9ElAmEWEIz
         qsAYzia2XMGJgwotajdWJ3nTAvjoaY2vGQuQ+g98RU3FUI6zInCn9wJRPZRVc7z7WU4U
         iqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sqpvIyXv5al4yPo9xr13UM11/YSyMcIv5LmmLgrv4R4=;
        b=dGb8/z8/Bk4ETS0SOpYpO/w6X4Ytkh5EZnCB/D8ImhJmx57AXGw8wKejFiwhteR1B+
         vl2jTjtxdK8sN77MOawUn5ZQLTiTCNzTI4xf/GYYhqw8n2dJyAO/DZ6mGBUlLGCjMYUq
         aNa7UC03SVlgdnjH4sQFTmrS6J8fJMhqw+E+/nA7hMBBIeICVFfZC+L+mg002TXY3Jz0
         qIaUI2fw2d8Y2k9Sv3eCU7+4+Xey3yH5XOA3P8mwndsSVMcqiAaiKpm5oWVNKyBVxOgH
         bkiaNT9yxRL7K0+LYt0sk0sFGsRmSbA2UEQhgttLrVqqAsmpiAG9gN3hN7WVHOlvxWWz
         lRbQ==
X-Gm-Message-State: AFeK/H37LOOzA1GlyRKeqR8Ny3ECVpE7P4aRlX23MGj1ELDCkiTmfGXkAb6A2ZImO+lnzg==
X-Received: by 10.84.238.207 with SMTP id l15mr16297614pln.90.1490038580095;
        Mon, 20 Mar 2017 12:36:20 -0700 (PDT)
Received: from localhost.localdomain ([103.50.83.159])
        by smtp.gmail.com with ESMTPSA id e7sm35037842pgp.2.2017.03.20.12.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Mar 2017 12:36:19 -0700 (PDT)
From:   sourav mondal <souravcristiano502@gmail.com>
To:     git@vger.kernel.org
Cc:     sourav mondal <souravcristiano502@gmail.com>
Subject: [PATCH v1] adding word_regex for go language
Date:   Tue, 21 Mar 2017 01:05:55 +0530
Message-Id: <20170320193555.6656-1-souravcristiano502@gmail.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Go programming language is one of the promissing language now. Adding built-in driver for the same. This patch contains word_regex for go. As the language specification this has alpha-numeric and under-score for identifiers. It covers all types of number system decimal, octal, hexadecimal. Also can specify signed or usigned number by using "u or U", long number by using "l or L" and exponent term by using "e or E". The following lines cover all types of operator ex. arithmatic, logical, bitwise, assignment etc.. 

Signed-off-by: sourav mondal <souravcristiano502@gmail.com>
---

I'm working on go language patterns and will send it soon.
thanks & regards 
sourav

 userdiff.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/userdiff.c b/userdiff.c
index 2f8e078..99f5539 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -148,6 +148,13 @@ PATTERNS("csharp",
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
+PATTERNS("go",
+	  /* word_regex */
+	 "[a-zA-Z_][a-zA-Z0-9]*"/* identifiers */
+	 "|[0-9eE]+[lL]?[uU]?|0[xX]?[0-9a-fA-F]+[uU]?[lL]?" /* numbers */
+	 "|[-+*/%<>&|!^=]="/* operators */
+	 "|--|\\+\\+|&&|<<=|>>=|\\|\\|"
+),
 IPATTERN("css",
 	 "![:;][[:space:]]*$\n"
 	 "^[_a-z0-9].*$",
-- 
2.9.3

