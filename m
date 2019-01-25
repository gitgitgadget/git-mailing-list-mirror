Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0630C1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 12:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfAYMXk (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 07:23:40 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32927 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfAYMXj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 07:23:39 -0500
Received: by mail-ed1-f68.google.com with SMTP id p6so7272233eds.0
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 04:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=ZppBTFw+mmj9iXVZxdsCBJKcu+bh6iaS0vjNjpRf9Io=;
        b=jeg8Yo2GcNyNO8k7kDdpN5nN0J+/6jOJLuFGreOfbCKnX419Cn/Ez/CRJQPMSGkp1z
         I1JUg+xJ/CqaTbGuMXwWOQw6DUp4ociVX56ip+A+YMn3qjBSZBYvgCIyKroLVGa3udMp
         JKBe4erh192oLJn0MvQ0q6l5bEuNQptO1omNYKL6kRKoSxVbrlURRhr+tRnrfzEAXM3y
         E7SG0wdslAup23nFlf3wei1a3B1nwpGsuRTu4pCdNnzS1m6MpsS3qJ+UqXPgeQ3xqBac
         E95Jz+Hxe1mpRIzp11w6wN1V77cRdwPXQAnNSQ1rEXpUcj7S/nmRdh3EXfuL/2jquQFt
         M5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=ZppBTFw+mmj9iXVZxdsCBJKcu+bh6iaS0vjNjpRf9Io=;
        b=ZiLUcOAHDWTyIF0t0tZ7Him8XkPzMqbF9K3T7dv7g8TdyNeWrkcSDJQPqAvUEOYzCl
         +fQP8UDumAZW2KqSMXXBhp+45wp9OsAhSG35i+HNIkrC8+eLnr9Tq7F+a5qMaY5uFTR8
         M2hrRoJabItSt5+jBQRsYilUi47OQUd40wiDEDokdtVti5PULyfJ2b5npPNmLIqfuWpj
         O3gEOG9Uil8ruBqiJ62JLuX+q/M0akyjPshxHr4035RTfPFIoq67egdojN/PRcobFVto
         eBpicF+IueFSKLW2qQY7+Ya1uP9/Ra3wnrTGC3X5V583ch+8IyZw8wc/Ibe00T+QXBJ7
         q7Bg==
X-Gm-Message-State: AJcUukf4GLqJnTR+yl4xwsPgJhciNqE00hz1n5QPxzORNuqgx+3f4Vly
        pIZWWk/gQ6qQYpwnLnOtkOHx+Xnr
X-Google-Smtp-Source: ALg8bN4NNxIsIwboQjiLLkJvgixNdkYfH88PNczWO7hwDUeReGBEWLFBaEWkOIEZsaPuh2sIlllacQ==
X-Received: by 2002:a50:b559:: with SMTP id z25mr10458188edd.239.1548419017292;
        Fri, 25 Jan 2019 04:23:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16sm11710001edb.41.2019.01.25.04.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 04:23:36 -0800 (PST)
Date:   Fri, 25 Jan 2019 04:23:36 -0800 (PST)
X-Google-Original-Date: Fri, 25 Jan 2019 12:23:29 GMT
Message-Id: <ca2a7c43750c66b75681e76321fef816464b8764.1548419009.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v4.git.gitgitgadget@gmail.com>
References: <pull.103.v3.git.gitgitgadget@gmail.com>
        <pull.103.v4.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 7/7] add--interactive.perl: use add--helper --show-help for
 help_cmd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Slavica Djukic <slawica92@hotmail.com>

Change help_cmd sub in git-add--interactive.perl to use
show-help command from builtin add--helper.

If an error occurs, it will be reported, but the Perl script will
not exit, since the add--helper is called within an eval block.

Just like the change where the Perl script calls the add--helper
to print the numstat, also here we forgo adding a regression test:
the Perl script is on its way out (and this patch is part of that journey).

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-add--interactive.perl | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index c2c6b4d5e3..88b7be6602 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1718,16 +1718,8 @@ sub quit_cmd {
 }
 
 sub help_cmd {
-# TRANSLATORS: please do not translate the command names
-# 'status', 'update', 'revert', etc.
-	print colored $help_color, __ <<'EOF' ;
-status        - show paths with changes
-update        - add working tree state to the staged set of changes
-revert        - revert staged set of changes back to the HEAD version
-patch         - pick hunks and update selectively
-diff          - view diff between HEAD and index
-add untracked - add contents of untracked files to the staged set of changes
-EOF
+	my @help_cmd = ("git", "add--helper", "--show-help");
+	!system(@help_cmd) or die "@help_cmd exited with code $?";
 }
 
 sub process_args {
-- 
gitgitgadget
