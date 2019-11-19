Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF8581F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 01:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKSBG7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 20:06:59 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44253 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfKSBG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 20:06:58 -0500
Received: by mail-pf1-f193.google.com with SMTP id q26so11225721pfn.11
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 17:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hnwixFKlmn33rNHPEiOhaTj3B6JRS6BfgSY11clVH8c=;
        b=WIZ6gFjTdvWFydcX6Vt0KVD3GpfzMUevsXrh1sT/fLiSRytcS4Tv7pouR1d9HjmgIc
         /++wNVMNkGIEI76Gv/ZBS7vJ10sra68mvz2hTZfxiArr0WjthSyhOxD63AdH3UzCCMCs
         5assrj2NHWya8CdyK5DPe3mJZBm2VhD1XMOI9++WRiMS2djE11/jVWz23AnmTwU6QJb/
         /9uX5HKER4dmGxITFmvbFIX7Hjm3y1G8MgCbGFrcAaXoVEOj/71Rr6qx+oiUokoOOH42
         Q9/ZGpvGkEGPsl5jYVzQ0PlJtgVczJs1VXpgBzHdYqTPxWpDJRPZ+BBjvAkTUuj0kiod
         c7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hnwixFKlmn33rNHPEiOhaTj3B6JRS6BfgSY11clVH8c=;
        b=FXcz1Gd1CWw66FbMPM9Kn3+GYGfErKUVQ9kf1qHxAQ3QiaNykcZZodkUHakeTnu0T9
         8ih8iZtvbUEDIrQosCkExe/8Dk++CEy1ys56C3l4goqwhnGx8wph0hWB1liDa7fOyQ0C
         1yoCD/dkZcY/Hvm5vAz9nX3DDpTodB5pFZeDC864Ffn4o0PoQbrMQGzU6AhNpk2WBDfK
         9Dj2ZqqHYPzbHzN0sfv5OfHdIoRpZI+KdsU3wOJAphslfE/Pu7vBnaaFi3bQEG8G+30I
         4X++IojmkNbz+6ACq0Mzm6uA8fuilMMhuy+Bi73Exi2K7PdSgpwtSZnPaZ519pZd2eOC
         bF8w==
X-Gm-Message-State: APjAAAXbDHXkMBPANF/3joC7xJqC3eC+bRw8tm+bL8O2LrGgXP1cXxRj
        X5hOjTG6Sc1gj5LksLUVPMveNhb1
X-Google-Smtp-Source: APXvYqy9DTdxfpoLUUqEEbQon89JDgahlm9QFC1gEeMRma1cuy68jqCuIw9RRVflqQRkVyfIsZMqbw==
X-Received: by 2002:a62:7dd2:: with SMTP id y201mr2610312pfc.90.1574125617265;
        Mon, 18 Nov 2019 17:06:57 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id k84sm25262502pfd.157.2019.11.18.17.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 17:06:56 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:06:55 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 1/3] t3206: remove spaces after redirect operators
Message-ID: <6966a30a5a510263f11758eaab53f2d58b68efe5.1574125554.git.liu.denton@gmail.com>
References: <cover.1574125554.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574125554.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For shell scripts, the usual convention is for there to be no space
after redirection operators, (e.g. `>file`, not `> file`). Remove the
one instance of this.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3206-range-diff.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 0579cd9969..87c6c029db 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -8,7 +8,7 @@ test_description='range-diff tests'
 # harm than good.  We need some real history.
 
 test_expect_success 'setup' '
-	git fast-import < "$TEST_DIRECTORY"/t3206/history.export &&
+	git fast-import <"$TEST_DIRECTORY"/t3206/history.export &&
 	test_oid_cache <<-EOF
 	# topic
 	t1 sha1:4de457d
-- 
2.24.0.420.g9ac4901264

