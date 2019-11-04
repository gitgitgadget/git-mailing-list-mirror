Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BF7D1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 17:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfKDRe3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 12:34:29 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:45507 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbfKDRe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 12:34:29 -0500
Received: by mail-pl1-f178.google.com with SMTP id y24so7878171plr.12
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 09:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yc/OGlkAUDLg8LnKLmn/o7fCb0WP/GfMunpHh0FqQQI=;
        b=BU/Bgwrxeu44FqXA1+0RRjz8eEwTZjdngXyUkpgstCqxMAFrDBifC32u5QZLTsrJ2C
         3qs18krAbPcu7OxLUKwfUa8BMBrGwNxiOZEg7WMrkfWBIw1brkbIuyw4iMRhxPPAXlqM
         gAR0ZPu2KIwT77Ffm2egmeMoQ8Tn0Og6S6JYBQMtoWkWSS3m1GtJzI4zO5ggImU9B/Al
         MfORQ64oQnZHwmK5j0RHETHIBkgp0n/PFTSWIA8BNJ4dD5H/BFJhJITPPPJjUSZ/lhCt
         ntQQdnneKeagEOKwSkwpl/gCOkHF6eVnRzjFcki3nG6RlRTqSQe2PSq2IygD1G3UhOUv
         nVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yc/OGlkAUDLg8LnKLmn/o7fCb0WP/GfMunpHh0FqQQI=;
        b=TpkkwQhhQUjcaXWKmoMc4FvW1x61jX0pphUGjQcRO4/DdxDBLE03VI+YO718Stob1N
         u7DuIZB2UIB1YXlspy0YfdiUGBZbRs4EKQ/fqRBAEhFc5vNOuvg1ziqScw12aO22uFwt
         1olFIyxn3/q/rd/BBmVoRoq893dV53iQH30sg9PM8bptiTt/tw9ulxLVs1y0FBiu3tiY
         7DcqES2bx3RZdrBAqsI9KpQJQok40qM5v+31PaIWb1AmtiBQ8aegPWj59R5Vn9JpvmR8
         4L1o1nRqJnkayeG8dZ8weBg1UCmJM9IdE6xTG6kiV6Emd537A0r/Axad3IpEq8pz4pnh
         kLZA==
X-Gm-Message-State: APjAAAXICKE1Cm6hePz99vQ9S4X4IMAMbYUi4DN697MgjFDPSdfuPS0T
        4bltav+M4F5+zyZy12FZ+9TFd5G9USGvbupV
X-Google-Smtp-Source: APXvYqxSK5uI8v3JkIYfEczRhgR/HLGO4DneusWCaUaDrlD+6l6Fsnx78EtpkLvHH6WBboo69UQI+Q==
X-Received: by 2002:a17:902:a717:: with SMTP id w23mr28834663plq.27.1572888868458;
        Mon, 04 Nov 2019 09:34:28 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:5975:7f6f:59ab:7646])
        by smtp.gmail.com with ESMTPSA id j25sm15486718pfi.113.2019.11.04.09.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 09:34:27 -0800 (PST)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Mon, 4 Nov 2019 09:34:26 -0800
To:     Elijah Newren <newren@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.24.0
Message-ID: <20191104173426.GA68471@syl.local>
References: <xmqq7e4gyzgt.fsf@gitster-ct.c.googlers.com>
 <20191104054924.GA47418@syl.local>
 <xmqqo8xsxiyv.fsf@gitster-ct.c.googlers.com>
 <20191104062334.GA49488@syl.local>
 <a0c175e3-1743-c5a1-8327-5736b7af71f5@iee.email>
 <CABPp-BHJ3eAARDAdbKZcGwMPSL7f7XD=7as0igvoPM8f8ODhUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHJ3eAARDAdbKZcGwMPSL7f7XD=7as0igvoPM8f8ODhUA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 04, 2019 at 06:46:12AM -0800, Elijah Newren wrote:
> On Mon, Nov 4, 2019 at 4:18 AM Philip Oakley <philipoakley@iee.email> wrote:
> > On 04/11/2019 06:23, Taylor Blau wrote:
> > > On Mon, Nov 04, 2019 at 03:18:32PM +0900, Junio C Hamano wrote:
> > >> Taylor Blau <me@ttaylorr.com> writes:
> > >>
> > >>> Thanks for a great release. As always, your release notes were
> > >>> very helpful in putting together GitHub's release highlights [1].
> > > Ah, thanks. It must have been dropped in one of the rounds of review. I
> > > added it back.
> > >
> > > Please do let me know if you find any other such typos :-).
> >
> > in the tidbits section there are two places where a double-dash 'option'
> > is shown with only a single dash:
> >
> > -super-dangerous-option
> > -end-of-options

Fixed!

> There's a similar issue earlier in the notes where --analyze has had
> one of it's dashes dropped so it appears as only -analyze.

...and fixed! Sorry both.

Thanks,
Taylor
