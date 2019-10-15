Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC61B1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 13:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbfJON43 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 09:56:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36036 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732294AbfJON4V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 09:56:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so24019040wrd.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 06:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xCZIUJKlOnbwNhuxRGiI7T/gfJU3N5zEWpmYYb9368g=;
        b=QR7dHeOsoKUFa6b62/I5ldLTWAICZv8CDk5Kj3fXZVx+E0/JijP3KveZeaLcAXrcym
         iMJ/VEMIpQh/puk9V9ZmNzB54Wz0VfqBXA+RMzvCM8xYqtgtpUYfF5+HHltT2Z8GzZNd
         dTMceyk1M2iC+YczHt7Q2XbUVWbtjvLlBJeccEBUH+cfOn5yemYWj5ijfuCWqub48yrt
         PULdGwKku/Sueuq5jP6FeZrP7lKuLCoPKCtnzb05chftODqKdzy59g6pSEKgOzSSKOWC
         yIOcJmUZ42lZLOKHsnklQRnRoKnzqngU3kFSQ8X0EMRDLC5MSg6OfvLwQHGmu9c0Ff4N
         61Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xCZIUJKlOnbwNhuxRGiI7T/gfJU3N5zEWpmYYb9368g=;
        b=GZSK1BGiJ544VWnAilqpgbwyCNW0zTdQr2di5emtSN/eT6Dim1IQv32OO+VleKjR3b
         5Kwru9ZY2OkfeWC34aQ+5zXpWQaQTodikdMOVy8bdUuTm32O6QHMtWT4vEUPzgRhKmhc
         c2Jw9OfvvNNkeUDiH0BGUhbwE2YUTErt87F1kM8K0FAG2kP+xW++on7g0Im+sS+RZURb
         IhfRhnr6vunUfyHG7JpfsYlGK7HjZ2iECWvtycyws7DS5AYAG0cMysuuyuBHaaHWzKVj
         2/qaBZav4ne8ch68+hUUQuk4xN7kVwHxP+4bbQ5Q29ZlZ4RCQGrO84jjP/yvqkQQRZc6
         7kIw==
X-Gm-Message-State: APjAAAUhFJTFJKqcp+zkMW7vMVFectYvGiBepAUO1djc9pCv6XO26jkR
        HjuQECoXTwaXQR1b8dBxmx3uemd1
X-Google-Smtp-Source: APXvYqw1coRb+rBlbC8eOF0qti3szsm1JF2VI3N0KWUy3S9OHKcHchzYHBY7sb7SKh6m/O0xXYnkrw==
X-Received: by 2002:a5d:4dd2:: with SMTP id f18mr11879475wru.4.1571147778544;
        Tue, 15 Oct 2019 06:56:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y19sm19719262wmi.13.2019.10.15.06.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 06:56:17 -0700 (PDT)
Message-Id: <27aa9d22f0bc2a6d02dac5d35d19904845762c27.1571147765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
        <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 13:56:00 +0000
Subject: [PATCH v4 13/17] read-tree: show progress by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The read-tree builtin has a --verbose option that signals to show
progress and other data while updating the index. Update this to
be on by default when stderr is a terminal window.

This will help tools like 'git sparse-checkout' to automatically
benefit from progress indicators when a user runs these commands.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/read-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index ca5e655d2f..69963d83dc 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -162,6 +162,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	opts.head_idx = -1;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
+	opts.verbose_update = isatty(2);
 
 	git_config(git_read_tree_config, NULL);
 
-- 
gitgitgadget

