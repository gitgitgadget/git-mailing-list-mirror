Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87D4F1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 15:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfGaPSn (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 11:18:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45126 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfGaPSm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 11:18:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so70102739wre.12
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PAHj2jCpaWY4GP26A7Q7PvWbBcJDmQ49HkP+gIyxPYs=;
        b=mqP+Ous/1ghERpr3H4ZHbiot4gtrMyJ+Q9mUhl+92K589OtKpwYxWWbmVbTF66uMoK
         NoCAMIj5DlxCb7clZ0M9k/e5JAf/ewWSurKBS0FJI87+r23yQfT/5m+pwSTfYL8LWDNO
         0gjtTIE4s26jRQ3dNpdg5bWkiL22hgjqLm2JNRmZVbezhc8XDWImKSfUmBYcfNE+/L1K
         aetCYGH0BE8d5zx4iqNAb3kPTdnerNNCuct/GW6ez5/ssxXKI6kaD9EmLP0X5I8KTb8n
         K6hYfDDdi1LMeR7/oAcQjJMHoPsBf2d9XZuvgKlc+Wy2KRwd/Nz357y7uSnb+HpknkfN
         bkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PAHj2jCpaWY4GP26A7Q7PvWbBcJDmQ49HkP+gIyxPYs=;
        b=Q8L34ntzNXoF5uSv18gcFPR+jcige1Uq6GiUPvJpBj98DyvQRskdm5Voq4Rr6UsueB
         TFCR7Fe1Bi9FZHMTxcGjkLpPwAvkFvvcsg/WUTqwvQit47rYt3elAfnIyyx4bpzmH72G
         /j8gsNxohjYYgoYPQGSEpDK1NPIP5S9sWTzzOTyQvBAaFvx9b8uxo+LWSWJQLh+fQyoN
         Gc+tFg4uF+Rk0ALmzqyKmTkD7JbrD6bXbLw91RSJkFjPdxNyswC3HlrRwJBlLG0uyJ6/
         w6xNPatXrebOYOPIXWOa+z7ND6VZgbgxvCzX1DqOwLqWoRBZ5sND3Tmcvy6HpVhALCjQ
         NkzQ==
X-Gm-Message-State: APjAAAV2p3A150Yx6ULYL2rI2R0b3v+Efg/Bm5vu7QvFNfY5E2XUq/Q3
        0kdKsH++qm6BJ+5nQJ997QVSP5/N
X-Google-Smtp-Source: APXvYqz+sfBHyin3QmwcZSlmcLaIPRILjJ+6NAbsnHpRaoiInPtbo5W/qc46g7kbm3uwUxi1ywzHsA==
X-Received: by 2002:a5d:540e:: with SMTP id g14mr27149820wrv.346.1564586320468;
        Wed, 31 Jul 2019 08:18:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f10sm56913065wrs.22.2019.07.31.08.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:18:40 -0700 (PDT)
Date:   Wed, 31 Jul 2019 08:18:40 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 15:18:23 GMT
Message-Id: <9e00e66dc70cf6600180a63e44737456d335f7b9.1564586316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.v2.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
        <pull.294.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 03/16] .gitignore: there is no longer a built-in
 `git-rebase--interactive`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This went away in 0609b741a4 (rebase -i: combine rebase--interactive.c
with rebase.c, 2019-04-17).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitignore | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 875f3fc6e8..bcee4fda81 100644
--- a/.gitignore
+++ b/.gitignore
@@ -123,7 +123,6 @@
 /git-read-tree
 /git-rebase
 /git-rebase--common
-/git-rebase--interactive
 /git-rebase--preserve-merges
 /git-receive-pack
 /git-reflog
-- 
gitgitgadget

