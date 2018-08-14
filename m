Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 062A41F404
	for <e@80x24.org>; Tue, 14 Aug 2018 06:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbeHNJi6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 05:38:58 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:36317 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbeHNJi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 05:38:58 -0400
Received: by mail-ua1-f50.google.com with SMTP id c12-v6so11989377uan.3
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 23:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CxHT5UhvMs5a/csn1SZulkDO+FAfcUpKY7m9lqv8PT4=;
        b=AByc0WoobCFJS1t4hm+u/tKgQgFJNYJODr2pQchCDjV3q5uQl6SIx0KhLbF7Fc0gzS
         JlyAdIZdVkAogo4IyfQ0KPQyCBn/ljTHV4zLm0tc5gwvQfe9f5xpSoAFCfYfu/r7BYCJ
         JNSG0ixQXF9FKYXdxIDRvsHzZHYa4AVbS+QwCFolQQoNUHET720IfFlVDE/6fWaUhBH0
         wb/Wy8lF6fPuvr79Kyu+GJ5oC4+GPFYJF4MNz2loF7oXFphe0WYgQTl7F6ReEHMtgmWb
         3MH3G+Eb5zx3kcwUBt3TRkyjAqehq2h7lSvIFPthK6MGlBVtqxmzVZ+0fdjI7pisIBqp
         OUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CxHT5UhvMs5a/csn1SZulkDO+FAfcUpKY7m9lqv8PT4=;
        b=fW2W7xBR80W2kwUugPlTgrqoRB0ma06BGxSXlvsoEKPNlMMqNBzQ8RTf5d8WqP443V
         8j/Es1koqLytUTaxcyMRboyx1/PIIjXEbF8V6LLhh7GWAihq8+KguWTBIq1+R7gbivte
         56BlceeNKHadv3W6cxclozoBsCMrd5b5QQ+oNS8vw+4OWAtjohI73xqVvcfAkkX1X7z/
         TUxmgB5gQdrpbqt04kHUTKx4eNxZA6jfEBSDNihtUv0LMTsj7fk8TLQ7LTZEEltmL5SW
         t7c19SVsa6+iqKmeYbskKy/9eIqp8O7z0hJr1wpvm54/aZKtH7KFnjvEduX+VVjyj+UD
         1+xQ==
X-Gm-Message-State: AOUpUlFhXHxHRlA59lVtoFjFi2sjUD6ywWhPCHEMNtvyJKzi/fDysB/Y
        WztY7s5L4p0fcTkJkNuyot7AYGYbOkgm/wyb+ck=
X-Google-Smtp-Source: AA+uWPzt3Y/gZqMfqRu8ayGleP3gupKuUgFRKaZ3x3WNCEgb9m8L0ptybSbyJWIsfQ0He1Ox3wBBTe6N6uULVBvmjaY=
X-Received: by 2002:ab0:12e2:: with SMTP id o34-v6mr13571397uac.154.1534229589262;
 Mon, 13 Aug 2018 23:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180813163108.GA6731@sigill.intra.peff.net>
In-Reply-To: <20180813163108.GA6731@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Aug 2018 23:52:58 -0700
Message-ID: <CABPp-BHdoRobhF=avL+12rAJF=Qmp2vNHgwdqJxBPFs=EBm+Tw@mail.gmail.com>
Subject: Re: Contributor Summit planning
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 10:27 AM Jeff King <peff@peff.net> wrote:
>
> For the past several years, we've held a Git Contributor Summit as part
> of the Git Merge conference. I'd like to get opinions from the community
> to help plan future installments. Any feedback or opinion is welcome,
> but some obvious things to think about:
>
>   - where, when, and how often?
>
>     Plans are shaping up to have Git Merge 2019 in Brussels right after
>     FOSDEM in February (like it was two years ago), with a contributor
>     summit attached.
>
>     Are there people who would be more likely to attend a contributor
>     summit if it were held elsewhere (e.g., in North America, probably
>     in the Bay Area)? Are people interested in attending a separate
>     contributor summit not attached to the larger Git Merge (and if so,
>     is there any other event it might be worth connecting it with,
>     time-wise)?  Are people interested in going to two summits in a year
>     (e.g., Brussels in February, and then maybe some in North America
>     later in the year), or is that diminishing returns?

Convincing my employer to send me to an event in North America is a
lot easier than one in Europe; they mostly allow me to work on git
stuff as a side project just to make me happy rather than as a
business priority, so competing business interests, shifting managers,
etc. make things hard for me to predict (so you may want to weight my
preferences less than normal).

My last manger did say they'd send me to the next contributor summit
(I think even if it ended up being in Europe rather than North
America), but of course, he was pulled to a different team a few
months ago, so I'm not sure if that still stands.


On a personal note, I'm also somewhat travel averse.  It'd be nice to
go to a Git conference again (last and only I went to was I think Git
Together 2011), but I know when it comes close to time to actually
travel, I'll start questioning my sanity when I said that --
particularly if it's far away or at all complicated.  (So maybe you
really ought to discount my preferences...)
