Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B85431F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932127AbeGCL0j (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:26:39 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34992 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeGCL0g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:26:36 -0400
Received: by mail-pf0-f172.google.com with SMTP id z9-v6so882118pfh.2
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 04:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=uJIurSAHY1BIS+el7GgXVqJTYRKqwsWqS5SRgPAad5o=;
        b=K+ZJa1bYZla9sW5R9Mm4hWKjirrGBdotNJdcwQ8rhvdCRoYFp7WdKhwrlNjgyJrLze
         ByyEdP5RXixpIcgddUHPhaIHw3nWKjQMMfSo0sYDMEkR6HhmCisgUb/C+pyoGvVnmpIK
         TFZrBemzgCGB8M+Ke415Zi8EundJzQ9bqSom71x7kK1ounrBpYpQCuQRK5awXJ89Bs41
         SbHQdOmI4T22wD/eXB2Za0PWXLvXooZ419NhG8KpK+DlmdBp3NfERI4/wkDsJsI+9ih4
         UnLxrqCvZD0SuqdrNy1gSwhI+P43CWcaBctW684EQNokxjv7svt67CzgI0x8bZTq7BNp
         BB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=uJIurSAHY1BIS+el7GgXVqJTYRKqwsWqS5SRgPAad5o=;
        b=cebsKpgrCWlv7cVME/6kPQIydeaK3OJeHv/H6s2kP9kQGQc8UmhEIMw4SQtgyL5tL8
         yz3EVIuIOVsMJsjW/eArLog+2u1YbmquoQOKxTztCCR+yBX+bfipx6emVlC1p/DFxrtv
         sgt2wtqbSQXCV0ikc7tNCTy1HhlnA32LwKbFAllL8RbmSYGMXMFj1gl3WkKiOcZ7WdHc
         gsUlgCQuvPxLAd1A7OdDRv1EQ1qHo3Rax4cHIFsPkLI8DQSCbgu5TmgJKBHuLFXB9uRF
         5n4RnmHy9yBTlSElp82x45bOCIThrHHzCAxpTruDmxF/sPDdaSSf3Xjmx56TbM5n08b9
         bjCA==
X-Gm-Message-State: APt69E0quQ8O6bTmazvyfPBjsUZPn1b8kYOoLSp7P9diYkoy3dK7O7Wo
        YvK6JMZLj2ch92FPYQ3RVsLaFA==
X-Google-Smtp-Source: AAOMgpfxR+FB0ob7AFZ5/5KOJf2DZ7EGL3iEo9ABkAyUaKUvlyfV9RCmvltFhCKKOWzYkO1XLm9hUA==
X-Received: by 2002:a62:d94a:: with SMTP id s71-v6mr17479899pfg.164.1530617195276;
        Tue, 03 Jul 2018 04:26:35 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id g11-v6sm1218991pfh.63.2018.07.03.04.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 04:26:34 -0700 (PDT)
Message-Id: <d05b54c603dc68acf198bb8826e3af4f2f11021f.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v3.git.gitgitgadget@gmail.com>
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 3 May 2018 16:44:25 +0200
Subject: [PATCH v3 18/20] completion: support `git range-diff`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Tab completion of `git range-diff` is very convenient, especially
given that the revision arguments to specify the commit ranges to
compare are typically more complex than, say, your grandfather's `git
log` arguments.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

squash! WIP completion: support `git range-diff`

Revert "WIP completion: support `git range-diff`"

This reverts commit 2e7af652af9e53a19fd947f8ebe37a78043afa49.
---
 contrib/completion/git-completion.bash | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 94c95516e..402490673 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1976,6 +1976,20 @@ _git_push ()
 	__git_complete_remote_or_refspec
 }
 
+_git_range_diff ()
+{
+  case "$cur" in
+  --*)
+          __gitcomp "
+	  	--creation-factor= --dual-color
+                  $__git_diff_common_options
+                  "
+          return
+          ;;
+  esac
+  __git_complete_revlist
+}
+
 _git_rebase ()
 {
 	__git_find_repo_path
-- 
gitgitgadget

