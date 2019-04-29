Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBAFE1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 21:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfD2V6v (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 17:58:51 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46960 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbfD2V6t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 17:58:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id d1so10479075edd.13
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 14:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ls0/ZmAT3ESFZW2feYeDQBxXsm/Q812q5LHyqz9eatk=;
        b=GR/ly4O8tQImbXeaHiCWRdtphl9A/0xM97i2wS21tZmE6NjO5EkP6rRBz7qexg6hq+
         AJF7E2ajwgoGMpkPEjGzmE0laxi+5pq8nldBLl7/1znEOJJnUHi5gwvqYXQY2UBhWLX4
         M7tfmrov0NPHT8BdWlF5n8WyQ5bAlkVcSSKbPGt3BhFqBEtWVlTKRHOFgVSj7xYYN2LD
         2ZZ3nCPnyPb6BvjKd470Tryn6LfXxMQdfSv5svPwXPbcMtDmK8seJsP+jbl7NMhAGuFF
         d0b0TtDqlphmIqimFLgQIHEXWNXWKUcblS24Oz9LU5Ust7QsGh5iWuQPPCPqZwf1nFTW
         4DfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ls0/ZmAT3ESFZW2feYeDQBxXsm/Q812q5LHyqz9eatk=;
        b=szmnmlVdZAAHviUKQYlXgF3IDpK/2bholg6dcK1uywfD8rS/AGbf/1J9JNokQOqbVU
         GXxQJeRqrgqqEhNHfQnEaQk3LYi+KdmKPmHqJdFX72uReRmmVyw2ymf6kjIwoPuS78pq
         vUwEne2+76lTU+HN8wKyYB1tfu3y6841ujZft4HRdtsnLVf6HCLXPdxwf8vhRwWdA6ZP
         Au3gWh/PdR5LDmDaVmLNXZucsy2YUelkn7iWl2jS9SVFXNPSMoyP8aKqBn3w3wX83c6e
         /ctmki8EoetF+x79WQhojWLEZbJjVBNYK7erVudiNGP0IG1HD3o+C7zkEftOst2CapmB
         Lg1A==
X-Gm-Message-State: APjAAAXSft8xb+yoDUEGyIhKJdj/d5Dv+VvbaqF/IDFgm1+5+QVtFgJD
        xE/JpBFGtZYVKAEbgLLw/cr/rxob
X-Google-Smtp-Source: APXvYqyR/bi11Fi07tsUsIKH8e/ihfKWSawos5KkxzqzbS1JXkMqmmFCIoz10+14mI5XDdIQUShKUg==
X-Received: by 2002:a17:906:4911:: with SMTP id b17mr16123513ejq.144.1556575128016;
        Mon, 29 Apr 2019 14:58:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm6064165ejb.19.2019.04.29.14.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 14:58:47 -0700 (PDT)
Date:   Mon, 29 Apr 2019 14:58:47 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 21:58:46 GMT
Message-Id: <9b508af11be125ce5fd80c40c732dbcaf45067fb.1556575126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.132.git.gitgitgadget@gmail.com>
References: <pull.132.git.gitgitgadget@gmail.com>
From:   "Dustin Spicuzza via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] cvsexportcommit: force crlf translation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dustin Spicuzza <dustin@virtualroadside.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Dustin Spicuzza <dustin@virtualroadside.com>

When using cvsnt + msys + git, it seems like the output of cvs status
had \r\n in it, and caused the command to fail.

This fixes that.

Signed-off-by: Dustin Spicuzza <dustin@virtualroadside.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-cvsexportcommit.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index d13f02da95..fc00d5946a 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -431,6 +431,7 @@ END
 sub safe_pipe_capture {
     my @output;
     if (my $pid = open my $child, '-|') {
+	binmode($child, ":crlf");
 	@output = (<$child>);
 	close $child or die join(' ',@_).": $! $?";
     } else {
-- 
gitgitgadget
