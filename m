Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7EC61F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeHKAqi (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:46:38 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:33725 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeHKAqi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:46:38 -0400
Received: by mail-pl0-f44.google.com with SMTP id b90-v6so4584251plb.0
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=13JgL+1xNJBnl/+1o0JsJAz5AVIePBak9PgoCrL4S90=;
        b=FKW0ltrYZg4Rgb7lxespK5+ya3qZUgnjEmVf1ws6+6t/MgtLup3QeDEHHFj05NUAgk
         Fc27vsyVnu8VjxHzWABJo+FmzJVSeJtbI8yvWEEP7M9m81+CJ5Pg0eoVAHdKISrh42CV
         wjIOg/j8M71T71ZRO04m9drgHBJQfrjsIJQXIDnhJ1I2ojmPMticGkD2P6f6b+IHVnSU
         cjUM7JGoxDjae0iZd7iHcQXds/DQ1TNZ2fXD1z7SlOKQkg5HqECaZUpCn6fTjAauUKJ6
         A6oX6TzQurlLcqQvrdWMpU6OoBk+SEvKxFUcHBdbn9jIgGnBQWGsAWSC8QMBdoIwcioJ
         9R2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=13JgL+1xNJBnl/+1o0JsJAz5AVIePBak9PgoCrL4S90=;
        b=GQOYpPKHeP9q92s3iAKu0+tx9kDlVnUNVDbR/Gh1cZnHfROFPG0Vrmw9qj/TSXogsF
         X0H4wN/48ZdiNHtvxRyi04KkjrzRzoGjngrrjS2yAzIeOHG7QEoUQA+9svpQq7nn2BdU
         Nh80ZbGuK+eNBlcKn7dk/2GVwkCW+QwieeUXCPMpyEbsHkN7MzwMKSo3+mL8WU/WWKqn
         T6HwOrLOX3VJAdHF4flngKCQDZ4xl9RioHGWxO1VPs9JJoctGDN2iIBuIMJ+32S7w3ME
         DJzdFBd81MTfTqT3F/lsrvP0q8IEJke+1opIVI7bx6UotPprZlGQhvOF1eiYtTI5D4DV
         tAmg==
X-Gm-Message-State: AOUpUlH5tjOKhAmHPRQKneN8J4xYi7vWJM/yt3XrNuXkYFOwBcI3/Zi/
        lz7YHHWt1nrjQrDB9UWM6O3L+Q3a
X-Google-Smtp-Source: AA+uWPyLZ+DJyzprbiAEY6Eaq0CGzrTlaagODkY3PiE+hL+KnNlmCMeMs7GLs86fCQ3+z+QknnWIKA==
X-Received: by 2002:a17:902:e3:: with SMTP id a90-v6mr7836239pla.227.1533939293022;
        Fri, 10 Aug 2018 15:14:53 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id i192-v6sm13850600pfe.188.2018.08.10.15.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:14:52 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:14:52 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 22:14:20 GMT
Message-Id: <b08e6d937d9516a6ad8f6325d9e28aa2d2a42eb0.1533939264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v5.git.gitgitgadget@gmail.com>
References: <pull.1.v4.git.gitgitgadget@gmail.com>
        <pull.1.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 18/21] completion: support `git range-diff`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Tab completion of `git range-diff` is very convenient, especially
given that the revision arguments to specify the commit ranges to
compare are typically more complex than, say, what is normally passed
to `git log`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/completion/git-completion.bash | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 94c95516e..3d4ec3432 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1976,6 +1976,20 @@ _git_push ()
 	__git_complete_remote_or_refspec
 }
 
+_git_range_diff ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp "
+			--creation-factor= --dual-color
+			$__git_diff_common_options
+		"
+		return
+		;;
+	esac
+	__git_complete_revlist
+}
+
 _git_rebase ()
 {
 	__git_find_repo_path
-- 
gitgitgadget

