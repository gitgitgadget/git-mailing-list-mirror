Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29E492095B
	for <e@80x24.org>; Mon, 20 Mar 2017 13:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754836AbdCTNWf (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 09:22:35 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35324 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753378AbdCTNVl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 09:21:41 -0400
Received: by mail-wm0-f54.google.com with SMTP id u132so63313117wmg.0
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 06:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tMPuLLFh8OEQJg9wuZrLE7jkr+lsN5Swo5tpZxEoHSU=;
        b=QRA01EIqRguDhj+SgrwvNkLr2/5s0KDRXbdSwZCD0sNPbqNL3S06uQlKb5DJx9Jv3G
         m9z9j0CISN2VgoOfRHp7k4EgVPYKv0cKe3vuAyL1B7H8F3bqGKA21EtOBuY4nnp8zZzh
         rowDNydyWHmKAQlCf+53Xvl+6n7PEdlZVDvuBpH+JwnMclN7yid/fJLYa9LMkSlqP0C9
         Fu4q3hKMCxGSiS67p/bRSBBeLYSXJnTuTZedyNeHvg0j0ZUabYHvKbB+KVMkb9JOB4ng
         A6UXPg8S3Y4NAH2OAjiFDWocUSCjAQfKRmaEFI9mEeYaCMJTxheqb3tEtNmsYwtvzL6l
         91yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tMPuLLFh8OEQJg9wuZrLE7jkr+lsN5Swo5tpZxEoHSU=;
        b=L2ij/6uRPO9uf6r6cn9n0OEzCTY2fTQUsvZ0SXEl2MCrhl2XHdAe0ysrDzQhDEW/Rp
         vBEXMHaXqrdSr6kzzjlt7ZlY4iR0LSREMzThvMwf5npKixPz7pnOasSXEYT3tnoCBej3
         f1ARxbPJaehB9SOq2sre0MutqoBpPtfI6mu/pouPHG68yccL++RCjondA5XNn5vvA9gy
         054FeWxlxdBL4mr0L7w/MfaSqJvCORQxHAg+HchXcXLwjaPZFW8t9jQRkWSUXseBBcPQ
         EPhdskTCAGMvomvlVLK4Avg5rWeGYTgg/lJ4Mc+3x9hr0mBPcQfmteSuEuHRumQFr8nZ
         1Xjg==
X-Gm-Message-State: AFeK/H1uHpLxf6OaJVhfDkWgsnDDjXbecYxrRuzrlKm/3NCnkdpi2rJKWpdoPedsP0zpVw==
X-Received: by 10.28.130.139 with SMTP id e133mr10778254wmd.133.1490016041601;
        Mon, 20 Mar 2017 06:20:41 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id r124sm948230wmf.11.2017.03.20.06.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 Mar 2017 06:20:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] doc: change erroneous --[no]-whatever into --[no-]whatever
Date:   Mon, 20 Mar 2017 13:20:29 +0000
Message-Id: <20170320132029.24604-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change these two obvious typos to be in line with the rest of the
documentation, which uses the correct --[no-]whatever form.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-format-patch.txt | 2 +-
 Documentation/git-send-email.txt   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 9b200b379b..f7a069bb92 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -239,7 +239,7 @@ keeping them as Git notes allows them to be maintained between versions
 of the patch series (but see the discussion of the `notes.rewrite`
 configuration options in linkgit:git-notes[1] to use this workflow).
 
---[no]-signature=<signature>::
+--[no-]signature=<signature>::
 	Add a signature to each message produced. Per RFC 3676 the signature
 	is separated from the body by a line with '-- ' on it. If the
 	signature option is omitted the signature defaults to the Git version
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 642d0ef199..9d66166f69 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -89,7 +89,7 @@ See the CONFIGURATION section for `sendemail.multiEdit`.
 	reply to the given Message-Id, which avoids breaking threads to
 	provide a new patch series.
 	The second and subsequent emails will be sent as replies according to
-	the `--[no]-chain-reply-to` setting.
+	the `--[no-]chain-reply-to` setting.
 +
 So for example when `--thread` and `--no-chain-reply-to` are specified, the
 second and subsequent patches will be replies to the first one like in the
-- 
2.11.0

