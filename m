Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4AB61F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeEQWxQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:53:16 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40723 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbeEQWxP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:53:15 -0400
Received: by mail-pl0-f68.google.com with SMTP id t12-v6so3397482plo.7
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=brYUAW4ecTTXlBLqPo5Mk/lTr8hbF20zAsAms62RufE=;
        b=gBAxFDy//CQ+e6YgPIL6DumtuaiSpau4gH5ejzOMz/K7xJTNs5+agay9EeOC+NZEXk
         YMem9Eedx/b9Rnci8ZUyeurgSrs/CkVUzEI7KPQbYyv/3hzf9YDOJAXj9Xgh+YoWnFN3
         05i7zxEEK25xKKyqzYf6nd5oAafqj6y0K+QPwFJTh5HvawhrbKTMr1OoIqgH034LkyDI
         r52TGOwXHsY7Ro5aajxtNkYACuPNfZpArIsH9a+ZDxV5j0JwCoIqDeaWOZKgDCYsYE7G
         QBrhD1CILPUay2AKsVQoJO7DWF2ii8LILLuI9U4VgkVHZElt0y3azZkACYRAy37tnjJN
         sqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=brYUAW4ecTTXlBLqPo5Mk/lTr8hbF20zAsAms62RufE=;
        b=WgERdt0uFjMEOgtGgQ/uihxC1Dx47Gv1rgPjqmUUwvC0iFKppZpvQpcElE3l3jLuM7
         XW5Qng7+1MmVblsmHRdHPf97Zp6OxSRINKoGrbrdT6uVRtXLjkK765MgjH4H4PSSbvKU
         qiny1GFjitiX/UEgtKNERu1/HPzYh249NZYjFhofBA/YVo0kgD0oZmW6jkCxz2izpkTM
         3tlVCy4UlmAK2/j+U6FKIIjkCuSfrbB7b27rEip9pzvZp7QM9GzyD9Ce6VePtXPNZCJV
         3FyD7+SJdZwKH45GDJKmFwU3qr3tScZF1gno4mKJwUc+KGYhVrryjTJmzecE9r7Fjqb2
         yz5w==
X-Gm-Message-State: ALKqPwdll36patzVunWBIWZ1AMmtLt3z2bGG2CRghsd4pwkj+qKkmBxB
        yyo6K1hHO3JCRK/m9OQBk/jB7I3s0ho=
X-Google-Smtp-Source: AB8JxZrX7R9OSOsF8+DyR13dL6HS+MexjczMjM8V0jYDm4ianpAXU49f/DMp45O4hPJcTDUtUOBmgg==
X-Received: by 2002:a17:902:7d8a:: with SMTP id a10-v6mr7064938plm.317.1526597595311;
        Thu, 17 May 2018 15:53:15 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id v16-v6sm21144222pfj.123.2018.05.17.15.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:53:14 -0700 (PDT)
Date:   Thu, 17 May 2018 15:53:13 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 0/8] Reroll of sb/diff-color-move-more
Message-Id: <20180517155313.6a529d76ab1f6e8f2a05e1a8@google.com>
In-Reply-To: <20180517194653.48928-1-sbeller@google.com>
References: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
        <20180517194653.48928-1-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 17 May 2018 12:46:45 -0700
Stefan Beller <sbeller@google.com> wrote:

> Stefan Beller (8):
>   xdiff/xdiff.h: remove unused flags
>   xdiff/xdiffi.c: remove unneeded function declarations
>   diff.c: do not pass diff options as keydata to hashmap
>   diff.c: adjust hash function signature to match hashmap expectation
>   diff.c: add a blocks mode for moved code detection
>   diff.c: decouple white space treatment from move detection algorithm
>   diff.c: add --color-moved-ignore-space-delta option
>   diff: color-moved white space handling options imply color-moved

The test in patch 7 is indeed fixed, and patch 8 looks good to me.

There are still some review comments of mine outstanding [1] [2] but if
we decide that this series is good enough for now, that's OK.

[1] https://public-inbox.org/git/20180424153513.dc2404cd111c44ac78bd8ed8@google.com/
[2] https://public-inbox.org/git/20180424171123.7092788b94498908c25eccf0@google.com/
