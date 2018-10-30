Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D963F1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 18:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeJaDVM (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 23:21:12 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:43374 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbeJaDVM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 23:21:12 -0400
Received: by mail-pf1-f182.google.com with SMTP id h4-v6so6258645pfi.10
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 11:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0rBYpuEpEubdxkHb7vk+lnmBMML/WcWuyoR/LGNYfME=;
        b=m9M3BRcwOvrhV581sHymPBOi5+fOw8wgvCUYlkK5kuaMDJyAH/8sfo0kK+FbC43Qtq
         qM+3iWpmEfnspJgfYVach7GAB0xfuljbnC3IdkqojGe9HfUvUaOqjSe8xbEz2D6z6QhI
         4W58jBJgDpn3N00XOoGqV8Cw+ZAsNCNe4LFONB4YngDrj9TkVCaaYSvQZwZWPdL+yuby
         fmHi8Gk5UxfNU8iOxVobjW+jh3BQplzNidLrDdrJBD7w+YMBk3Iz1wK26i4r8AA4Pupm
         q7CzH7YXJuBvl3ugeKGMo5D1A8nB9gJDfE+L9QJYiemLINHN85Zy+dHiC3cyomkydQDm
         mtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0rBYpuEpEubdxkHb7vk+lnmBMML/WcWuyoR/LGNYfME=;
        b=fEz0gejE9wYnKEuPHf3Z0pA1Lf9m8h9FiZjRfQv2OLinf/KWklzefsuX23ckPwnh1a
         rqRpsTL6c1K5BsUQJxTc93orxyHmsaEKTbrAvOQpzXMhteAw4qLDfkppt5g5DQynglwQ
         WwK6XajLAiJMP5sn1N4FEloS+GJqdZMHPdHR6YTgBHKMA8WNxhHEplVJahOdQuF3iMLk
         JoEJ7R+Jc+C4zh/eX48XdjtZl8GQ1u51vqdZaaXtNQ3iVejM8Dwfy/Jd9ETph33PJtM5
         7kIemMcMNxH48mlx/fE8KCVvd17KYIoHL4aADlu/oMjeZTcGv8JusxVHgcPW3qZtOiDP
         80ug==
X-Gm-Message-State: AGRZ1gLXkjigVn/b370NhLtCJk0EnO0x0u2jgQYpP+Dh5EMLjn8AGed1
        mEEl+n46nAVfTLyVcQqL3zrnlNvq
X-Google-Smtp-Source: AJdET5dths7BHYMbp8Ye3RwbrrYeG4fgFa+8p7BwP7+bNrISD8aGVcDZr34vI3q3Sa3d4n59jR1kSw==
X-Received: by 2002:a63:1765:: with SMTP id 37-v6mr19387527pgx.131.1540923997260;
        Tue, 30 Oct 2018 11:26:37 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id e8-v6sm1112537pgh.67.2018.10.30.11.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:26:36 -0700 (PDT)
Date:   Tue, 30 Oct 2018 11:26:36 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Oct 2018 18:26:33 GMT
Message-Id: <8159cbd1b8025f33fb9d0e254db1a3c2a066f853.1540923993.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.59.git.gitgitgadget@gmail.com>
References: <pull.59.git.gitgitgadget@gmail.com>
From:   "chris via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] Use correct /dev/null for UNIX and Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, chris <chris@webstech.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: chris <chris@webstech.net>

Use File::Spec->devnull() for output redirection to avoid messages
when Windows version of Perl is first in path.  The message 'The
system cannot find the path specified.' is displayed each time git is
run to get colors.

Signed-off-by: Chris. Webster <chris@webstech.net>
---
 contrib/diff-highlight/DiffHighlight.pm | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
index 536754583..7440aa1c4 100644
--- a/contrib/diff-highlight/DiffHighlight.pm
+++ b/contrib/diff-highlight/DiffHighlight.pm
@@ -4,6 +4,11 @@ use 5.008;
 use warnings FATAL => 'all';
 use strict;
 
+# Use the correct value for both UNIX and Windows (/dev/null vs nul)
+use File::Spec;
+
+my $NULL = File::Spec->devnull();
+
 # Highlight by reversing foreground and background. You could do
 # other things like bold or underline if you prefer.
 my @OLD_HIGHLIGHT = (
@@ -134,7 +139,7 @@ sub highlight_stdin {
 # fallback, which means we will work even if git can't be run.
 sub color_config {
 	my ($key, $default) = @_;
-	my $s = `git config --get-color $key 2>/dev/null`;
+	my $s = `git config --get-color $key 2>$NULL`;
 	return length($s) ? $s : $default;
 }
 
-- 
gitgitgadget
