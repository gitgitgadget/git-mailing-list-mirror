Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F56C1F42D
	for <e@80x24.org>; Fri, 18 May 2018 10:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752342AbeERKlx (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 06:41:53 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41140 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbeERKlw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 06:41:52 -0400
Received: by mail-pf0-f196.google.com with SMTP id v63-v6so3569913pfk.8
        for <git@vger.kernel.org>; Fri, 18 May 2018 03:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+LW2lllLdpGA2aCI2KZxGBAPz40BnJ8ggFe6imW82bQ=;
        b=u5enc/cASesF3lv8wH/M2xhvmGEnO6rFH3MD3BrGje6M4WvXNdDrr3D9647UkOQXXg
         ySmnN7JKiY2WCanLmXKgWJNFZ+oJEwuGyI6tck7dV5SDZhzGFTDbXVcAlMn497GS4B+Q
         lEi4EtSPSjv7IjdkSFfWi842tsom6OuQ2uXljMjsUt0ZMU+HLQEr1e4F05Jfxt2c1YZY
         XuOq1oD+ytwgnGDUZ6FuizPjaYMhrhKVtDTc7+qUOFZl5QB06tUgn85ZLaPgQgBfvM7H
         qUpK3PyklNwfy5iAJEOUENDhd+m0Lba9qX0+OGTq/MywfM4/hb7UK30dy4F8wdP7V5qf
         ZKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+LW2lllLdpGA2aCI2KZxGBAPz40BnJ8ggFe6imW82bQ=;
        b=Nd0r99WDZ5LcnbRZG7YJTbPLZc9stBrjmPv8joGqLN4GlvbKCtLLbvVpkcKLAWDML0
         A0qQWEJGhpQ4qygbbVQhkHDp0WAFq5sA6Qi11kY8UMwE2iV7dO6IPuW5oT5rgj34bP7T
         DA0ESFyAslfv8El1H9jFQl3KnmkGxa88V2HJO4G+p3qzrXiFicSD9EVliGJ7vxVebIHT
         DYZW7878OYNhE/y+HbWYhQsjUbay0gxSTvkIN8275RKKwAG4xMUp1V5PbnXxfAFHvOB9
         HWtHdZsI/k/7BdMtmUDpEUABEneijIBkc1QS2gNtJ/GfWZ0EWH9lou36F7kmLDMAwAA1
         XyQA==
X-Gm-Message-State: ALKqPwe24SMKyFaQ4idxI/nbHLmcpPf0OoYnhYmom/eCDw8HbxdwmjbW
        2r3gn6mca0H1xPHY9pt4bxixpeMyn0JCs6mCdbOHUwOEKKI=
X-Google-Smtp-Source: AB8JxZoImnPF7GkhCm9ZmbSJO59ZAACg4FaMKsnCMmfTgGRNNmC0gieJMRUyuP/hFg2ORDd3J9a/BU/iUIwtpYYQ8oY=
X-Received: by 2002:a62:e903:: with SMTP id j3-v6mr8958698pfh.196.1526640111775;
 Fri, 18 May 2018 03:41:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Fri, 18 May 2018 03:41:51 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1805180534170.6786@localhost.localdomain>
References: <alpine.LFD.2.21.1805180534170.6786@localhost.localdomain>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 18 May 2018 12:41:51 +0200
Message-ID: <CAN0heSrJMFij9xt6RstLD16+2CxJ_HALer4iRL74AZQvH0VWRQ@mail.gmail.com>
Subject: Re: error(?) in "man git-stash" regarding "--keep-index"
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18 May 2018 at 11:37, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   toward the bottom of "man git-stash", one reads part of an example:
>
>   # ... hack hack hack ...
>   $ git add --patch foo            # add just first part to the index
>   $ git stash push --keep-index    # save all other changes to the stash
>                                               ^^^^^ ???
>
> i thought that, even if "--keep-index" left staged changes in the
> index, it still included those staged changes in the stash. that's not
> the impression one gets from the above.

So would the error be in the part of the man-page quoted below?

  If the --keep-index option is used, all changes already added to
  the index are left intact.

That is, this doesn't say *where* things are left intact (in the index?
in the working tree?). The man-page does start with

  git-stash - Stash the changes in a dirty working directory away

which to me suggests that "leaving something intact" refers to precisely
this -- the working directory.

Or is it the name of the option that trips you up? That is, you read the
name as `--keep-the-index-as-is-but-stash-as-usual`, as opposed to
`--keep-what-is-already-in-the-index-around`?

While I'm sure that some clarification could be provided, I'm tempted to
argue that is exactly what the example provides that you quoted from.

Martin
