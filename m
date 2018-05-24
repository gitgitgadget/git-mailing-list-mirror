Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9DCB1F42D
	for <e@80x24.org>; Thu, 24 May 2018 19:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034484AbeEXTJX (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 15:09:23 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:36789 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033109AbeEXTJW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 15:09:22 -0400
Received: by mail-yw0-f169.google.com with SMTP id v68-v6so926709ywd.3
        for <git@vger.kernel.org>; Thu, 24 May 2018 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FpDgcvS2fnU8ZEbZakMRNE9JzYSPlzCwDwAMU9YM+KM=;
        b=Wrsnlc/ki4+6R2z/H326uiPOt8XMz4W3GcJVQ2no2zoyM5lSlRWJHHmAHzze3w8cW5
         YcaEHHyMtOz1eHgvggqli7knqEZH9S242MD3XJc+Yh81v+5Qve5c+MzQBXu69oCF74Ck
         qpr5RE5ADE/xfulWU4kAvbyZiUQJJjwwLxtDQAgeJ+ATR+MIizcrTFrQ00V6Up0WO2ji
         +6tak7FKVtHLplhBCycyZ9lZQdeFPJ5CmA5uU/CJQQBP3fh0veMnPksHsrsELM8SJ2nI
         pj0SwpzZIoeiY3bc+MFIp7CuWIOTi/ilBLbUkcUpvHxnIPP3L/5L82rT4IAOo6qzL74Y
         ko3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FpDgcvS2fnU8ZEbZakMRNE9JzYSPlzCwDwAMU9YM+KM=;
        b=VL/FtLZvkFT1nwDePwLXdsykhHDUid0phhRjoGS2RDof9J8Xwqjm5pgAcrw1ppCELM
         2POeY/pWvBzl3rHPv/pxwzxKfWDkdbpODIJk2Hmr+IUU6JLBMpohv0GD05juHwElnHDE
         PY9VQSyvmMN38BPFF4AlB4NfznHvlm4L+zel6E1qigxjLSdorCQpkEvHxn2TeUmCSF/B
         NbXr6FqqHK+xXycMJdWMcHZovOQG22RG76oAMl20/1WyBFet5AcTt2ifcuZ5jZEtBPy8
         VZaA6YDMavo3qMYGpH3zH5s53CDBmbOfkI/05lcEJEU8zghoMWIf6pReUKT3ZiOXd7gX
         Kqmw==
X-Gm-Message-State: ALKqPwdFUDAvSRduh9ZTWzvpf44TDsmfEFb51EBZ8eHg57o9LPva3t6V
        +h1EJxrWJDK8vRzHBZF1rxkjBOrH4xznyBIHEX/wYA==
X-Google-Smtp-Source: AB8JxZqvHq7uaJbrIG72y1sR0HvzkNfZNnmzUqxRqOxg3W7m3zsqn8cPJsnIK3kCyehLy9+s1n38hXmtzm09r0DCfaM=
X-Received: by 2002:a81:374e:: with SMTP id e75-v6mr2586139ywa.340.1527188961648;
 Thu, 24 May 2018 12:09:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Thu, 24 May 2018 12:09:21 -0700 (PDT)
In-Reply-To: <xmqqwovtudia.fsf@gitster-ct.c.googlers.com>
References: <xmqqwovtudia.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 24 May 2018 12:09:21 -0700
Message-ID: <CAGZ79kag9m02xtJKg05aPE4Grq2wBWSmUr3JdwfyHsMawR7m5Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2018, #03; Wed, 23)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * sb/diff-color-move-more (2018-05-21) 8 commits
>  - diff: color-moved white space handling options imply color-moved
>  - diff.c: add --color-moved-ignore-space-delta option
>  - diff.c: decouple white space treatment from move detection algorithm
>  - diff.c: add a blocks mode for moved code detection
>  - diff.c: adjust hash function signature to match hashmap expectation
>  - diff.c: do not pass diff options as keydata to hashmap
>  - xdiff/xdiffi.c: remove unneeded function declarations
>  - xdiff/xdiff.h: remove unused flags
>
>  "git diff --color-moved" feature has further been tweaked.
>
>  Will merge to 'next'.

This is nowhere near done after reading the feedback from
Jonathan Tan; I am considering redoing it completely differently.

Please eject from next. (at least the last 3 patches, the patches
up to "add blocks mode" are reasonable.)
