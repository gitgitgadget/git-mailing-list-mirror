Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFD822018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbcHHVRg (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:17:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33559 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbcHHVRf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:17:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so17929067wme.0
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:17:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=24HDNj3wBD9jA/hX/lXqqauGOUPzNWTnGxb8PYn5gYo=;
        b=LVnot3dvDykIF8fvGMMpePogKTXo/0/E0Q+9cCYC83XNnum0neexnFv8iSgiuy1Wqz
         1BDepvO3YZC+UUzWEroKhzmE+C1P7RieWLyc1xYmVTEswyz1QVIsbJk5bIS36k023NfD
         T+g+cSLxsvA4l3W3C+vb1CY35DITMY/g2rc69F9XjNE+8qF0PpaPIne+fWcXya3QeW8Y
         cLXhN80RhTOyqXsJ+TefFaBAwaF95fKLLUy3RZr8hL+VsTwknzBuk0DpaLkDZUkxhySp
         7ZESVwz7JA17UoPTHCHT+sJkh1aw3Y38zMl223H6hExQq5w4xARQMt6WM9VJOAYzRQQY
         KgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=24HDNj3wBD9jA/hX/lXqqauGOUPzNWTnGxb8PYn5gYo=;
        b=mB6U3NpSETUfaLq5EW7/RGTUDod+2r4XFfcfplbMJHGzSS8Scjm+zrESOpeTGkRJKq
         j/g6B541QVYvNbDt2XQjoSUg7MOtUJ8inW1bm/tW4PsgT8RzBrm/lxqJl8uSxO+SjqZn
         tTpRWUoKKJKD8RNKF2qbgg5R9NZvmPkPrO1gnCr/fe4Kck5VdS4it94ng5ZLwiiQpXdF
         fP8LRgo+8+HmwD/H0tHkvQqleMj2O2x+ExL8o155R1bvmwAu25hYva7CLIAv+vJcjYVt
         kLHRj9PzLRAmRtonmI7REuk8CAHf30/p238nQx8qolQkBjcGlo9HPQBN9twp9Fzv3ga8
         bb+Q==
X-Gm-Message-State: AEkoous+ezHj2Yd0Fc5WAbir/hdn5YGlyzTxGI2cJzMYwwdad7KtOEuMIdcvACtRWB1Afg==
X-Received: by 10.194.173.4 with SMTP id bg4mr86409985wjc.28.1470691053713;
        Mon, 08 Aug 2016 14:17:33 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id jc4sm34757518wjb.6.2016.08.08.14.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:17:32 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] .mailmap: use Christian Couder's Tuxfamily address
Date:	Mon,  8 Aug 2016 23:17:22 +0200
Message-Id: <20160808211722.32588-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index a714e69..9441a54 100644
--- a/.mailmap
+++ b/.mailmap
@@ -33,6 +33,7 @@ Cheng Renquan <crquan@gmail.com>
 Chris Shoemaker <c.shoemaker@cox.net>
 Chris Wright <chrisw@sous-sol.org> <chrisw@osdl.org>
 Cord Seele <cowose@gmail.com> <cowose@googlemail.com>
+Christian Couder <chriscool@tuxfamily.org> <christian.couder@gmail.com>
 Christian Stimming <stimming@tuhh.de> <chs@ckiste.goetheallee>
 Csaba Henk <csaba@gluster.com> <csaba@lowlife.hu>
 Dan Johnson <computerdruid@gmail.com>
-- 
2.9.2.614.g5428e0c

