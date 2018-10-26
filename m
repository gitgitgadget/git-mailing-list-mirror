Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBF9B1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 19:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbeJ0DnU (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 23:43:20 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:34075 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJ0DnU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 23:43:20 -0400
Received: by mail-ed1-f52.google.com with SMTP id w19-v6so2197780eds.1
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 12:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtJUYqnk6lhS0JZZ6erDFWkQO/84wOVlhHzrqpu3uM0=;
        b=qY5Lb4E+NclOb3HbqXupBqyIS/sx7KEW8Tv1JjQHnng+2cYCZJ04C3cfsipF/CPoj9
         VqmEFG36QyKfdgAeS9aRpk6oVcMxdlSHEF6ufRcHjbKjYkwxUGXCuEl0X6e3ApZa5yM6
         3yeHMugPTRLYjn9WM2s0QTP7HghTLOUdoarv5D+SrXHX4kmKQl4lC8we78ZyhSHshZAI
         9aakid1T5pfOtDvjapyfwidxyjJytx++lt4qcUyc5Yv7xBLIkvOA2iFuSkle7dT3PHtU
         UDNSxGAEk5Yrt/k6T5CuNzrMAW/5n7D3bKrkKz9a4+/308ZTri7rqpySGkqUuFyh9cNU
         3MhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtJUYqnk6lhS0JZZ6erDFWkQO/84wOVlhHzrqpu3uM0=;
        b=G4H9DgdxWnZngYkX/zG2WdaCRSvShH24PfazbJQPa14UmD6OKLZ75KntzW9lYtq7L7
         BfVe7OhrWDTW7A+2Q+gMjnjeeC4I7aeG/uW1dqg+aiOxDjCWhvdY/3sUHyNm31IfWVEl
         76AheWE2UkP4nR2yV9P1lRt66Joz+DV7F0JLok6ecaPxbHaI5GaBAxQuFGx2ffFO4x2E
         o+dKxHrFmiIettJlw3onY4LSiuklTYtKoDlFtQHW/M9rM0oep3MXOO58eVGUjRJwxIU3
         nL5eRDFs78fMngn5Y9y+OJIX44tPn9B6fzSJzEcv7gZm2UBg2oTvRs86+8o15u1eRqkY
         kQnw==
X-Gm-Message-State: AGRZ1gIempsAdsdsvg9hODu1jA6TKXrJuRKLWd9PzrD+j26DGEMEbRKW
        MnaLBY/czkNdsKjnYKaRA7fQcFOFc9Zd8MFQG//SupD5wWBpaQ==
X-Google-Smtp-Source: AJdET5f3NcF234fYxZEwrWgVtmtQskKC5GT1c5dwOWE6cK/w2tdnE3pUXTRRlQatdRA3cNzMCfskoq9PRDDslZrTlvY=
X-Received: by 2002:a17:906:e287:: with SMTP id gg7-v6mr3331032ejb.128.1540580706583;
 Fri, 26 Oct 2018 12:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqo9bhcf89.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo9bhcf89.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 Oct 2018 12:04:55 -0700
Message-ID: <CAGZ79kbjKZSHfHbDykkob1w21RTB9tgCCYVrOD=0C8aAFGncTQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2018, #05; Fri, 26)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> * sb/strbuf-h-update (2018-09-29) 1 commit
>   (merged to 'next' on 2018-10-26 at e4ad935cb0)
>  + strbuf.h: format according to coding guidelines
>
>  Code clean-up to serve as a BCP example.
>
>  Will merge to 'master'.
>  Further clean-up patches may need to follow soon before this
>  change escapes to 'master'.

We have a contradicting statement here, which can be either an
issue or an oversight.

In [1] I stated that I dislike the style that was proposed (which I
understood as these "further cleanup patches" you speak of above),
I do not recall other cleanups to be needed.

[1] https://public-inbox.org/git/CAGZ79kZGEMWpr7aqeqXbC4bkmsCCiW+1pxbEV4T0vfsYG+_3iA@mail.gmail.com/
