Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97024207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 16:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbdFZQzn (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 12:55:43 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33308 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752461AbdFZQzi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 12:55:38 -0400
Received: by mail-pf0-f174.google.com with SMTP id e7so3077873pfk.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 09:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3lGuSdsOjgokAxcXory5T34RO+DvR/yVqh2vUqVt204=;
        b=SYsNnysSr3dzrsSNYiTWdchUm7xvvPke9iy4hOXyUsaklL3VR8ki6Tim/IeoYYMI4X
         kjO1wFbD8OMdwa7BXIJd7x3uYEFULsxpxSlfdZqy+EeAfXlPra6p4OT1eyWA5yeFLeXI
         u1lZfnVE4QjAXi9SKTNf6BBv7X7oLGcbVyEZUIDG2CJR7Vf2CBPJp5bQSIgmq40sapnt
         UZJhfj2UmDR5shHTvVAJavVa2ndaTlm7mQzUgq5Z8zDCFOZYw6KMWZphHZbnDclHnZhB
         9yDxDqYEJU+orQH/HAkU2FriSDMe33o9oGGQ2aM4ihG4WZBCYwrwMP1KgP0aPfCxv2Dg
         JEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3lGuSdsOjgokAxcXory5T34RO+DvR/yVqh2vUqVt204=;
        b=K+lH3L95tkKhOv3PCqB8e2oy99RFGrvvn2F707NFOWT3BkBgNy6bzKthVH0n+kxraj
         bdRBIpALlRfY8k9cMnb9u2ZHwZ7PoSpNNR4dw1fiVMY7MeLccNhyY32LP1e7JJoyE6CI
         ln6CCtc0YdSU0sgGoCxYbcZSFp40NK15l14lkZANNgUWtkvZ3lfPOOM0PZAf//zjywMo
         vpCnvQb+ktuVogEhariTJZepkq9GQtcVnXwPLAALVkEl6Yl1NWM8D8uarTv3a7JeWyuY
         7NQizBxyMogkABdHQRZAKiOIFZh7leciixIJ2c2l5LV1VRzxy306PHJdwd+c4TCiT7sB
         y6Iw==
X-Gm-Message-State: AKS2vOzTlFz+bhbz0AmzjEGHr1jpkYM5UyIictyUSVyD6eM+oRRBr8yb
        E+ceHne+rvGzsmaN
X-Received: by 10.84.217.217 with SMTP id d25mr1124279plj.145.1498496137235;
        Mon, 26 Jun 2017 09:55:37 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:1d31:6f32:75e6:3b92])
        by smtp.gmail.com with ESMTPSA id b7sm1069947pgr.11.2017.06.26.09.55.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 09:55:36 -0700 (PDT)
Date:   Mon, 26 Jun 2017 09:55:30 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2017, #07; Sat, 24)
Message-ID: <20170626095530.49c82646@twelve2.svl.corp.google.com>
In-Reply-To: <xmqq4lv57ypx.fsf@gitster.mtv.corp.google.com>
References: <xmqq4lv57ypx.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 24 Jun 2017 16:25:13 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> * jt/unify-object-info (2017-06-21) 8 commits
>  - sha1_file: refactor has_sha1_file_with_flags
>  - sha1_file: do not access pack if unneeded
>  - sha1_file: improve sha1_object_info_extended
>  - sha1_file: refactor read_object
>  - sha1_file: move delta base cache code up
>  - sha1_file: rename LOOKUP_REPLACE_OBJECT
>  - sha1_file: rename LOOKUP_UNKNOWN_OBJECT
>  - sha1_file: teach packed_object_info about typename
> 
>  Code clean-ups.
> 
>  Looked sensible to me.  Any further comments?
>  cf. <20170624124522.p2dnwdah75e4ngya@sigill.intra.peff.net>

In a reply that I just sent out [1], I suggested "sha1_file: support
more flags in object info query" to replace "sha1_file: improve
sha1_object_info_extended" (the 6th patch from the bottom). If you are
OK with that commit message title, and if you prefer not to make the
change locally yourself, I can send out a reroll with the updated commit
message title.

[1] https://public-inbox.org/git/CAGf8dgJ8C0chOxZo5CPt56225XGBgrjaGy8HDAST+0-USfW6mA@mail.gmail.com/
