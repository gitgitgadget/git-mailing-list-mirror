Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F33741F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 15:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbeKNBIM (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 20:08:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32835 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731208AbeKNBIM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 20:08:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id v68-v6so6208216pfk.0
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 07:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=rthGrkGz8nNG75/xBjpGzOvz+mwzwq6sulUzx2a6pQk=;
        b=jvPX8iiFpDXw2lRFig0STLpPbqHZigAU0abzYpUN/2a2TLBoAD9XD6qXfyPsziKHW1
         Rk6YorzE9/Hq80rZYC0HIkFEpA9Y6mcje32WjY+1hPr6tjesHW9nz9Ip8dfAqROBqfLW
         rlVbL4rMg56S4KuyJGbwhnHK+mbL62lkItxBJXNUzwkGpt4d0HfOXjwjXOtLuFUnLtUl
         7IlLW4e5qAJhSxXkB3BhXElAf+Jhg+JnZGrFHcP1aQ1UpfVjpRHWSQQtoOpruphNgKhr
         xSgc5ogv/zT6bNxIf4qWvpsYMbisegUyGEErzGvB58b7JMn6VrQlikstXqHt+5o7lDmP
         X0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rthGrkGz8nNG75/xBjpGzOvz+mwzwq6sulUzx2a6pQk=;
        b=rFCfgTZgL47xWNNL5jqp2DAHARfxeaH8+PIzASQYr6BggKehF0J5RBKvnuVYS6VdAJ
         7h2MXx7kJijOxTjmUYZYj2f6fOKEBp6JnmRUNwqKPP8AMoC4+qstXnHpT6s0R7MiJJ3Y
         DJM8s10jbR91fsWfof2tWTnos3YMkPEMW6E/s9XAbCrYI3lJLJw9jY+Dqiv5n0xognBk
         XOzpXL8o9DdDCDNJpsZqIPWGN/dnbxHEOXADmb3OMCWTGGaVthiVm00wihdRdjcFUMdK
         nucmqlfMZGMS7MY3W7bY7LOQsSBTua5G8duZBj7hyzHtjnCEpK9K47N+uPNyuPaIG52A
         em2w==
X-Gm-Message-State: AGRZ1gKS8fEntc4akOxweDXTUbVqNIGDBO3mY04FU8z2FHqxHQhEwO2L
        6o2ZnTjLgY3eFF+ML5aSec+WJ7/D
X-Google-Smtp-Source: AJdET5c/8wKxRnpH3WfWAle8mE8f9Nc97TlbaqVS2JjZWyRLCaqaFoDXX0NBgK4+a5mtHtI8rg+UHg==
X-Received: by 2002:a63:3703:: with SMTP id e3mr5004913pga.348.1542121778631;
        Tue, 13 Nov 2018 07:09:38 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id v4-v6sm22655156pff.9.2018.11.13.07.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:09:38 -0800 (PST)
Date:   Tue, 13 Nov 2018 07:09:38 -0800 (PST)
X-Google-Original-Date: Tue, 13 Nov 2018 15:09:34 GMT
Message-Id: <6276372ad3dc6fa4b9b352abb2b0192a6d010528.1542121775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.79.git.gitgitgadget@gmail.com>
References: <pull.79.git.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Ga=C3=ABl=20Lhez?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] bundle: refuse to create empty bundle
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ga=C3=ABl=20Lhez?= <gael.lhez@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Ga=C3=ABl=20Lhez?= <gael.lhez@gmail.com>

When an user tries to create an empty bundle via `git bundle create
<bundle> <revlist>` where `<revlist>` resolves to an empty list (for
example, like `master..master`), the command fails and warns the user
about how it does not want to create empty bundle.

However, the `.lock` file was still open and on Windows that means
that it could not be deleted properly. This patch fixes that issue.

This closes https://github.com/git-for-windows/git/issues/790

Signed-off-by: Gaël Lhez <gael.lhez@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 bundle.c                | 7 ++++---
 t/t5607-clone-bundle.sh | 4 ++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/bundle.c b/bundle.c
index 1ef584b93b..4e349feff9 100644
--- a/bundle.c
+++ b/bundle.c
@@ -457,10 +457,11 @@ int create_bundle(struct bundle_header *header, const char *path,
 	object_array_remove_duplicates(&revs.pending);
 
 	ref_count = write_bundle_refs(bundle_fd, &revs);
-	if (!ref_count)
-		die(_("Refusing to create empty bundle."));
-	else if (ref_count < 0)
+	if (ref_count <= 0)  {
+		if (!ref_count)
+			error(_("Refusing to create empty bundle."));
 		goto err;
+	}
 
 	/* write pack */
 	if (write_pack_data(bundle_fd, &revs)) {
diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 348d9b3bc7..f84b875950 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -71,4 +71,8 @@ test_expect_success 'prerequisites with an empty commit message' '
 	git bundle verify bundle
 '
 
+test_expect_success 'try to create a bundle with empty ref count' '
+	test_expect_code 1 git bundle create foobar.bundle master..master
+'
+
 test_done
-- 
gitgitgadget
