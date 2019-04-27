Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 476F61F453
	for <e@80x24.org>; Sat, 27 Apr 2019 05:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfD0FHK convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 27 Apr 2019 01:07:10 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:35385 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfD0FHK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Apr 2019 01:07:10 -0400
Received: by mail-lf1-f54.google.com with SMTP id j20so4022811lfh.2
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 22:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VH+2kSxxgrpM3YucYrDerk0efFoAsFW+6nxK+7CbKw4=;
        b=fD2UxdXrwpCe2FpnXMZJKSN10YAHSJTPL7q8hva77yLF3Ae/qN+Nr40QMS/mgfifR1
         ajuw+t6ZopK0A5A64V6uVHAX3x3zgHgu5coJL6EOCgvO1k+jiawjqpYJpTaPOgWS2vOd
         DZD1OTO6XgraDUyNdPNG4L5ANr529/SHhmNqs4hWhqAdlI0QtDDzHEmItQ4M4Hc7GGWu
         HzlsPNcwRSOolOd1ahFL0YfCGfLzfe3k8ug6mJ6CnNkMvrRA0Z6za4m1kc0O/2OHmYCD
         2E30CtkVnTfUqgzkt0QnT5gx/4kEaXY/GZLZqLng9d1pHtKJ5cOsxGAwGnkBaL/WeuvO
         jVvg==
X-Gm-Message-State: APjAAAUjjcpnbGBCjG6OXBjDdcJIDNLrUUO6zkvNs7fx9vYDI4FuPvEp
        BpwR6eu0itWi6wZqsKn8yTbndlqA6t3t8Y7zyP4/E//IVbA=
X-Google-Smtp-Source: APXvYqwA0Fe1oFltplvZdBivVAle8scD9KRWukMNFY/YRc4iyEf4cD9jyyOuOA5vRvffILS2PdCih2cnfRMrByI2oDY=
X-Received: by 2002:ac2:53b2:: with SMTP id j18mr14461915lfh.78.1556341628088;
 Fri, 26 Apr 2019 22:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com> <20190426050531.GA7854@Taylors-MBP.hsd1.wa.comcast.net>
 <xmqqd0l9uxv1.fsf@gitster-ct.c.googlers.com> <E6B28E44-5859-436B-A620-2FB484EEB657@gmail.com>
In-Reply-To: <E6B28E44-5859-436B-A620-2FB484EEB657@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Sat, 27 Apr 2019 14:06:55 +0900
Message-ID: <CAPc5daVL5Jn2M-pban1wPPNOnkjyvUAKynJQBtVBeSzGQoxZ+w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2019, #05; Thu, 25)
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2019年4月27日(土) 2:58 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>:
>
> May be you are searching for the following view which lists (similar to git log --one-line) the commits starting from  97dd512 which is the last in the tb/unexpected series?
>
> https://github.com/git/git/commits/97dd512af7ce4afb4f638ef73b4770921c8ca3aa

Yes, exactly. The problem I have is it is not obvious how to get there
starting from
https://github.com/git/git/

From that starting point, I can get to
https://github.com/git/git/commits/next with
two clicks, and get a "git log --oneline next" equivalent). In there,
I can eyeball
to find "Merge branch 'tb/unexpected' into next".

I can click it and reach https://github.com/git/git/commit/c49927fca0d but then
that is more like "git show c49927fca". I can even go to its second parent with
one click, but that is equivalent to "git show 97dd512".  The page you showed,
which is a rough equivalent to "git log --oneline 97dd512", is what I
want to get
to from there, but I am not sure how to get there X-<.
