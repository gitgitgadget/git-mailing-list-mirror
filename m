Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 003CC1F732
	for <e@80x24.org>; Sat,  3 Aug 2019 22:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbfHCWF0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 18:05:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33924 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbfHCWF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 18:05:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so37739521pfo.1
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 15:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ze0Rjc3kdRVnyrPffSZVa7MQxNeznk7KLZuPTyp+z8=;
        b=jFqWfVKxaVnNr5aVwMYY6rkMzI9w9RCnP72KltpnriV19BF+O7Qf7x8l8C8DBzAG54
         mvFgvqaBNNf10ByOiSuFg/mxoJpvYoCFEwrn0Izjz96xF9iLHEHA0dddlBSI2ciEYVIv
         ZAwDRMtM/PsaIqQjFY7rUzPR8cWy5fpHFbeuhK953H+bJh44p9rGEeetmRVJsNkQWX4p
         8b7nvLpMtZA/H16yhL+UzAqc2kh89BaLRIk5pwvuDvJZnHC7PNEejP24Xb5HU5iRXDgE
         KZK6w5CSgs24ym/qrQ/srwfl+N1FlgsnTFqWwl4EW4ZxatYBF4SOtO3f8XqR9F/v038V
         KslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ze0Rjc3kdRVnyrPffSZVa7MQxNeznk7KLZuPTyp+z8=;
        b=nliDBu8QpD1KQVMZ9+nsIcOvoSW8vHcdQ7RW/paht9W3Xv2HooqhT0cIYNIiRbTF83
         VV9wniiRWYmpzxhHzOVrj70TxMkSfwDIyAh1/wA+vES7Wij8hwRT5dac4fJ5ZWJahcgI
         hwZRTHpybrlMYgE6M74vlOepLciefkkV5UcYGO7RwS9CneRfN4flKMjn1f3ZWdaN4tH+
         a78RdEO5W+6lWMrNXVClYWelqenEZ+eQfgT7rFLL3YlziR86Be26oZIC5oqMV11JG+O8
         BxLq1/VYrcARSiMZ8pvtsYzQcvgbdR+CMdY4D9I5LaG9kjFkclDDOXNVdDWsSXKOUOhU
         AI8Q==
X-Gm-Message-State: APjAAAUb8PMW2afskMO6sNqD+fzqlhw79QcVkcM7FokyiQvGX7kZTPmc
        cZNk/cM67ksXN7+EK/5lYRk7qaY1
X-Google-Smtp-Source: APXvYqxheauKJOSi1Bx9yAMfEiqPJaxEj/pVvHNuIqyxsRyAm0Imtr1JyGw/htxye2nZwTnXtj9bkA==
X-Received: by 2002:a17:90a:ca11:: with SMTP id x17mr11033351pjt.107.1564869924998;
        Sat, 03 Aug 2019 15:05:24 -0700 (PDT)
Received: from wchargin-t440s.google.com ([2620:0:1000:fd1f:4c9:ef90:fa96:6081])
        by smtp.gmail.com with ESMTPSA id t9sm13482974pji.18.2019.08.03.15.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 Aug 2019 15:05:23 -0700 (PDT)
From:   William Chargin <wchargin@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, wchargin@gmail.com
Subject: [PATCH] restore: fix typo in docs
Date:   Sat,  3 Aug 2019 15:04:58 -0700
Message-Id: <20190803220457.9338-1-wchargin@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.1.g9eb78f1760
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: William Chargin <wchargin@gmail.com>
---
Assuming this is a typo, because I can't parse the sentence; if not,
perhaps it can be reworded for clarity?

 Documentation/git-restore.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index d90093f195..1ab2e40ea9 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -39,7 +39,7 @@ OPTIONS
 	commit, branch or tag associated with it.
 +
 If not specified, the default restore source for the working tree is
-the index, and the default restore source for the index index is
+the index, and the default restore source for the index is
 `HEAD`. When both `--staged` and `--worktree` are specified,
 `--source` must also be specified.
 
-- 
2.23.0.rc1.1.g9eb78f1760

