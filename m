Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 028501F597
	for <e@80x24.org>; Fri,  3 Aug 2018 22:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbeHDAkO (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 20:40:14 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36001 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731689AbeHDAkO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 20:40:14 -0400
Received: by mail-yb0-f194.google.com with SMTP id s1-v6so3245622ybk.3
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 15:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1I/A4VwBUqghfHPsjSzCi4KXLucTR4y22hSeTOUw1XE=;
        b=QPbNrtYRopGgUtyMhY7YjZfT+axshcywwILlWenmvLunUzt2GWDaQHezHASBQI5M+4
         XozlOVDh/+gBwlkffC11O3DIKkbSwZ3TdPABy3/OHjn4qaEU37TpGDjwViUpMKLnlHTa
         JXg/mwaZcZmwsXvqMMbH1tjTTVsHEsh10o++y1r++uLE3v74r+vIa0+yl35Pt+mesOn1
         lqVdSm4qmuVSP55srhCo6/CG2aLgNPBakAd0P16T+Bjr3iOmN2VMq/ZZl0YG6H6DU2bW
         TqhN7Npih/Xra+reXJtwc5U1SItCAoYpXlfmdsyYFYiZUkTtBgRQEf8dgYMAtn1KVRva
         nF7g==
X-Gm-Message-State: AOUpUlEJVFC+ITq6Ad4i8DODyvknve1txeg0jB5wqYUWT70hLAV/AUuA
        v3hvXopXXPUmNw8EBlkxG6qcvlBZAa3b5rzN8Es=
X-Google-Smtp-Source: AAOMgpdZ5LIFp8b2583QTKznIbCrsMEJYllmRi1MgRe/y68PSyzsaCNCu8x2eS4RQz8T3a8M8wnmV9b+GgRCVA+8CFQ=
X-Received: by 2002:a25:d349:: with SMTP id e70-v6mr221532ybf.287.1533336117934;
 Fri, 03 Aug 2018 15:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180803205204.GA3790@sigill.intra.peff.net> <CAPig+cSDM4vjuhwfuapuPpjjOmXbrhz-i0eVhtShp+nOYReLnA@mail.gmail.com>
 <xmqq1sbfw2ap.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1sbfw2ap.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 3 Aug 2018 18:41:45 -0400
Message-ID: <CAPig+cTrYvvTwExoXq9-p62gJEa8MbHnOGTgdDuPN_LVLDcyeg@mail.gmail.com>
Subject: Re: [PATCH] add a script to diff rendered documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 3, 2018 at 5:47 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > There doesn't seem to a usage() function defined anywhere (and
> > OPTIONS_SPEC doesn't seem to be used).
>
> Isn't this using the parse-options thing git-sh-setup gives us for
> free?

Yes. I saw that git-sh-setup was being dot-sourced and then promptly
forgot about it. Peff corrected me.
