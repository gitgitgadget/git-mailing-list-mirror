Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 441E720387
	for <e@80x24.org>; Thu, 20 Jul 2017 08:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935000AbdGTIsf (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 04:48:35 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33746 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934845AbdGTIrx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 04:47:53 -0400
Received: by mail-pf0-f174.google.com with SMTP id s70so9951253pfs.0
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 01:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WQHb173qinuKjMBvoFDo8n+vKis+ypDV99yGlYiJ+jE=;
        b=se2pQDE9x3pnrQRKOZOPBgaW0zDTqDKRTPeu+QOgrZFZL0ukcTdJWnogNjKVprxgjx
         aPJnasVRwA/v19et0Mo17TZjrehHe7eNfre2HmnfqfbHyZ1IBU7hiN+mkPsDj4818IAQ
         5wMSC6Ujc9NQOZBxL6MxB4g0QP0a8utRawd+h87/1nZCENNRl4c0FpmtXoBQhQsYjSNU
         03w183sWJHRnNZkrIeRUPTklq63EwOJjhx6vL5JRssZfSRel5e5366tC1JN2GmV12lFn
         6q0kHt/aQ4wqEB8oAzsbTnYAJQTwuzRGpJwux6Qf+qbYrekX03Z4Fbte/kxZyTzjtx0E
         4D2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WQHb173qinuKjMBvoFDo8n+vKis+ypDV99yGlYiJ+jE=;
        b=Wv1lHLhvTGKGtj7R2ZJhjoGbDKRjVLRoGXpr0LUM/DXu++eF+4R3e841KV4RYt+lqY
         y+zn3VDFCAeRqC/rjz37zm+1qW8HTYx0QG6xC35sC7/nkzfXUYaj63qf6Qoo0xjM2lq2
         kMH5hzxIE3QtkA1M6PhRIm5UcLddmAhbX8VsZJyP9EXjN3qbm2RP7B9ZbZmet/jCHCUC
         QBQbjHAONlyX0UDFhxHUzC//xj6uXeZMaFeJbBkf3z6OxBqeE9jZzh2eyMLkIexe0RbR
         iKMs0heKJy7zq/RGGJ+2dG+1LJgNkVjPXvzSjj4BCTVH7AohUrVLwEwyKpc4gCXOE6f7
         3fpg==
X-Gm-Message-State: AIVw110wIcGToaKXKNP2NmNfmayrte6kiChBhFV8qZKGE8XaC3MR4qj6
        maCE4Cn9zotQz3AWg/R/MseL0O7qJWc3
X-Received: by 10.84.224.141 with SMTP id s13mr3369417plj.212.1500540473172;
 Thu, 20 Jul 2017 01:47:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.102 with HTTP; Thu, 20 Jul 2017 01:47:52 -0700 (PDT)
In-Reply-To: <55629eef-537e-e5b6-c0dc-6e3372d00b33@gmx.net>
References: <55629eef-537e-e5b6-c0dc-6e3372d00b33@gmx.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 20 Jul 2017 10:47:52 +0200
Message-ID: <CAN0heSoJVf4A=92GPwFGUL0uoqWK3eY89+uCTirVzSYHHhfwwg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IC0taW50ZXJhY3RpdmUgbW9kZTogcmVhZGxpbmUgc3VwcG9ydCDijKjirIY=?=
To:     Marcel Partap <mpartap@gmx.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 July 2017 at 10:21, Marcel Partap <mpartap@gmx.net> wrote:
> wouldn't it be great to have the power of readline added to the power of git interactive commands? Yes, rlwrap will do the job, but still.
> Or am I missing something obvious?

Well maybe *I* am missing something obvious. :) Could you be a bit
more specific? What is the use-case? Once this feature were in place,
what would it look like? Could you give an example of what you as a
user would do to solve some particular problem -- and how that differs
from how you would solve it today?

Martin
