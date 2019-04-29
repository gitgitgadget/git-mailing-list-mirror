Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A452A1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 20:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbfD2UOR (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 16:14:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43617 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfD2UOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 16:14:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id j20so10288158edq.10
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 13:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NfHH3UDNYOYd6q8G9jtn9kGVoshe/kczU9BC8hWQY7E=;
        b=NpL4m5otLa3ryWY+3Bh+gDHjT+SLlsfndQHp6J1HsuHpyB5dMvF3dkT/wqGehfG5fX
         wSFTgPdzzVzU7jdQsbUw7DReXUjdRkxbK5Fyd7cRLpK1N+rE06ioxSxmc3HhlzxAKVny
         RFmp6NYcQNKnhjilCzwt0cW7kdOlz7/C0zu8oB7NnGTtwo0RAHj7i0g4jGZRH4XkHEiU
         fTDnbN/Grs1h8pSgvmEooU2NbP+pBWoJ6IhJ5Tv2jSmEE5IgFuSp8Y7zC+47ftk6CDz9
         4D8WPVJ5k2MKwzKgujFulNNaDtjXcKbVjgxtaNs3g4s38DoSlqSVG2Z1p55pYSkV3gm1
         e6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NfHH3UDNYOYd6q8G9jtn9kGVoshe/kczU9BC8hWQY7E=;
        b=YDPfNMLJXdFE2mgHYRSxulPpoO7P0U62FmpVTyzlrhEkvjgDrOh8mvBHXNAkNFd5Sa
         qo/HelAce8B8JtFPkrEsSoAOmDAKH5gQ9CKlJhJaTQBCETBitsqVOwolq0gnIdlilpw3
         srqqDQTBVr+qvJCacDPGH/D5XJdp9742nCh+gFQYFffn1kKngSJ31UqAGIMo8lBRW3Of
         VbHP64dzmsuy6PFVtC1UPFKp2u9ZFYfv510VEtu6CoI9xZqYFcIncZ/IlY5kK731e66a
         oosf+R7v/v9R+PCGhtdb1sPNQFjsDSsM1VI6+DLc4VEVeZxxarNO+NhN079w2OybvLAW
         +VZg==
X-Gm-Message-State: APjAAAWnQ5FnrKONIQ4VLYHWYL3xEUY1PmAVZKK4n7SPJkee5cO+KAAZ
        4y9veGvXPPb8p8sWZ9FmS0qynrij
X-Google-Smtp-Source: APXvYqwQAIsZlxCFh+d0HrfoBIqnXbWyUxm42SBeOzyec0uk2ZmBY6RWDJXdWTLcaR7Lxc7OkxYqWg==
X-Received: by 2002:aa7:c2cb:: with SMTP id m11mr17168952edp.284.1556568854659;
        Mon, 29 Apr 2019 13:14:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b32sm9636443edb.67.2019.04.29.13.14.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 13:14:14 -0700 (PDT)
Date:   Mon, 29 Apr 2019 13:14:14 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 20:14:01 GMT
Message-Id: <f6653f1c5914d4ed0edee87a56277a35625135ca.1556568852.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v5.git.gitgitgadget@gmail.com>
References: <pull.169.v4.git.gitgitgadget@gmail.com>
        <pull.169.v5.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 01/11] config: initialize opts structure in
 repo_read_config()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Initialize opts structure in repo_read_config().

This change fixes a crash in later commit after a new field is added
to the structure.

In commit 3b256228a66f8587661481ef3e08259864f3ba2a, repo_read_config()
was added.  It only initializes 3 fields in the opts structure.  It is
passed to config_with_options() and then to do_git_config_sequence().
However, do_git_config_sequence() drops the opts on the floor and calls
git_config_from_file() rather than git_config_from_file_with_options(),
so that may be why this hasn't been a problem in the past.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 0f0cdd8c0f..c809f76219 100644
--- a/config.c
+++ b/config.c
@@ -2011,7 +2011,7 @@ int git_configset_get_pathname(struct config_set *cs, const char *key, const cha
 /* Functions use to read configuration from a repository */
 static void repo_read_config(struct repository *repo)
 {
-	struct config_options opts;
+	struct config_options opts = { 0 };
 
 	opts.respect_includes = 1;
 	opts.commondir = repo->commondir;
-- 
gitgitgadget

