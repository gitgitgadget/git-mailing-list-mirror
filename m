Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 865EF209AB
	for <e@80x24.org>; Wed,  6 Sep 2017 15:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932662AbdIFPJU (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 11:09:20 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44985 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932263AbdIFPJT (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 Sep 2017 11:09:19 -0400
X-AuditID: 12074414-0d3ff70000006ddf-3d-59b00f9e53af
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 3B.7B.28127.E9F00B95; Wed,  6 Sep 2017 11:09:18 -0400 (EDT)
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com [209.85.223.174])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v86F9Hdq024679
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Wed, 6 Sep 2017 11:09:18 -0400
Received: by mail-io0-f174.google.com with SMTP id i14so5394242ioe.2
        for <git@vger.kernel.org>; Wed, 06 Sep 2017 08:09:17 -0700 (PDT)
X-Gm-Message-State: AHPjjUhXlDCfjxkm22/45RMkT2dBJFfqC17tcTjfkFc8q3yb9K01r9Sj
        Mm+470GzdnHI7BHuHnZ7I0WldH+NQw==
X-Google-Smtp-Source: AOwi7QARY1ec3J6CWYuL9VjBqx4w0FVVktPFJ/nCLMxFLL6Zo3zktX1AEVFk5RkNRKCkqCiL5f2BtiYoM70rcjyC1Cw=
X-Received: by 10.107.69.21 with SMTP id s21mr2839610ioa.143.1504710557398;
 Wed, 06 Sep 2017 08:09:17 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.79.13.17 with HTTP; Wed, 6 Sep 2017 08:09:16 -0700 (PDT)
In-Reply-To: <20170906115310.kxgjrnmrehm5m32q@sigill.intra.peff.net>
References: <CA+55aFxW3qcETiMrNk5SqZU+_jtM2Rxeb3mhF=J=c0ChdGm1tg@mail.gmail.com>
 <20170905215056.4wihyd6hrtvk52yd@sigill.intra.peff.net> <CA+55aFywhyELmbhAorgTjJZeuNxE-+j2qSP=3d3vqQXNM6p54A@mail.gmail.com>
 <20170905220300.isxbt5y5fd2scd6b@sigill.intra.peff.net> <CA+55aFw==7bqv0dH=cQruXbGjMw-WNrRMreMsYy_4NcrbiWSEA@mail.gmail.com>
 <20170906115310.kxgjrnmrehm5m32q@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Wed, 6 Sep 2017 17:09:16 +0200
X-Gmail-Original-Message-ID: <CAMy9T_FQHei2XgidRqcBPabKCGq2g282KgYDhe-e9XqSjJE1gw@mail.gmail.com>
Message-ID: <CAMy9T_FQHei2XgidRqcBPabKCGq2g282KgYDhe-e9XqSjJE1gw@mail.gmail.com>
Subject: Re: [PATCH] rev-parse: don't trim bisect refnames
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqDuPf0OkwdGfEhZdV7qZHBg9Pm+S
        C2CM4rJJSc3JLEst0rdL4Mro2LyJsWASa8WsnRwNjFNZuhg5OSQETCROfV/O2sXIxSEksINJ
        4s/hc2wQzhMmiZkzTjNCOH2MEi1ntjBBtORL9G9/yQhhF0kcajkDFS+WuDR7NTuIzSsgKHFy
        5hOwFUICchKvNtxghLA9JKa+fMncxcjBwSngIvFwqyTE/A5miRtdP9hAatgEdCUW9TQzgdSw
        CKhIrOjShhifKHHqSRMjxPgAib93P4GtFRawkuiaOo8ZxBYRkJX4fngj2M3MAhMYJc59ugiW
        YBbQlGjd/pt9AqPILCTnzUKSWsDItIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10IvN7NELzWl
        dBMjJLhFdjAeOSl3iFGAg1GJhzfh//pIIdbEsuLK3EOMkhxMSqK8l9WAQnxJ+SmVGYnFGfFF
        pTmpxYcYJTiYlUR41Xg2RArxpiRWVqUW5cOkpDlYlMR5vy1W9xMSSE8sSc1OTS1ILYLJynBw
        KEnwlvIBNQoWpaanVqRl5pQgpJk4OEGG8wANb+YFGV5ckJhbnJkOkT/FaMlx5cq6L0wcTR+2
        AMkpB7Z/YRJiycvPS5US5/0BMlQApCGjNA9uJixZvWIUB3pRmNcKpIoHmOjgpr4CWsgEtLDq
        5RqQhSWJCCmpBsZ5EjKVcy7fv53wJ/furS+BSeKNCUYJ++aITMv0lWn/M2EJr5j9c9sbaa7Z
        3wWWnQ4WLj9jeyOpiKd/h96u6QHC53bJZ/RWt6nbiZ9M1p8fkTHHerl4vbBIaYvto+jOSJYT
        r5dozep6tFbvU9KdtBjXA2Vhmdtuu+eLNDgHXWZYcSjSROjiPyWW4oxEQy3mouJEADEwLWYx
        AwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 6, 2017 at 1:53 PM, Jeff King <peff@peff.net> wrote:
> [...]
> Subject: [PATCH] rev-parse: don't trim bisect refnames
>
> Using for_each_ref_in() with a full refname has always been
> a questionable practice, but it became an error with
> b9c8e7f2fb (prefix_ref_iterator: don't trim too much,
> 2017-05-22), making "git rev-parse --bisect" pretty reliably
> show a BUG.
>
> Commit 03df567fbf (for_each_bisect_ref(): don't trim
> refnames, 2017-06-18) fixed this case for revision.c, but
> rev-parse handles this option on its own. We can use the
> same solution here (and piggy-back on its test).

It looks good to me.

Michael
