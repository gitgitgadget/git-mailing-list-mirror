Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7733F1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 19:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbeA2TY5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 14:24:57 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:43511 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbeA2TY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 14:24:56 -0500
Received: by mail-pg0-f50.google.com with SMTP id n17so5216066pgf.10
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 11:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HhbOlzRWVO9jrKkfXJhAnMxkIm1J7L4KD7B8VJLOxlI=;
        b=Nyao6Id5wmJHovNNHcTs93Ln85bHc6OAovzmflxtcdG7tO+7aSftBVyNr4QUHzKICb
         iinuOyPxO1h1B7nC3TJ+hwFyHIoMoBSigMMksC3ENbpbptZg8NC/hvIt3R0SnSBe7UiL
         ZMK2xBGN3DP/A7ZxEmg2adTALnv2+C3r7ebCoQm1surOHtM9VNmCH7VqzFSa2QwveLPG
         bwgKlBJ2tL9OHfMgjr8YvWNDNCV3XfHqch4tcY9tI4kT797mhP/lVz8oe5/z6HKzi3jF
         Qd/XOQmeXM0LhD2+5NfNqqJoHBMjTRsNMEIkRwsgwSa0sEuuso2Owvx2GpHxci6akdiX
         8hgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HhbOlzRWVO9jrKkfXJhAnMxkIm1J7L4KD7B8VJLOxlI=;
        b=CeG4aCX7tVo8aRYts73W69hXOQliMKshrIBrTe1HcJNbk11pSeCEljqPCSW5qz3lvY
         nUJFBOE543u/1gc+4CyjsChx+MhRXtbCTrlMtwL8W3TYsCPvdnwF6cxbO4uUz6qOZERo
         onqoV7xPJebodDr3adzekMhQ3wGsuk5sIjAXABnWQmMGjONUl0jO2SRFNdqydIMaDTmj
         FMniN2cGLKTulVTRh4FLb2LHwED+2zrDZOYugSOZY/kd6ZyYB3n2Ghldm/utRZtUtAe1
         uYOz/E04U2dtXXUUDf2zVOe+7S3Ya8kKr2oK4WVn1njl+43g54UEZXyqXqiNXZkp8McM
         F14A==
X-Gm-Message-State: AKwxytctZlrEPYNqb+tSfaXISyUMqDLUfmefPpHblHvfvtq2CKnJEURZ
        0Ft2m5nf913iDbN0kGTumAE/jefQrFQ=
X-Google-Smtp-Source: AH8x2271Z3vJscOephgoNNMZ8fZyldnNTMKQPmUf2FZF9BYRwTpRfFE+0PjyyH8k1TwXYDXmvcz+Sg==
X-Received: by 10.98.85.195 with SMTP id j186mr23332741pfb.77.1517253895566;
        Mon, 29 Jan 2018 11:24:55 -0800 (PST)
Received: from google.com ([2620:0:100e:3010:b055:17d5:ab40:870d])
        by smtp.gmail.com with ESMTPSA id q65sm34768563pfj.137.2018.01.29.11.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jan 2018 11:24:54 -0800 (PST)
Date:   Mon, 29 Jan 2018 11:24:53 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Shawn Pearce has died
Message-ID: <20180129192453.GA53791@google.com>
References: <nycvar.QRO.7.76.6.1801291031040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180129172107.GA4185@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129172107.GA4185@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/29, Jeff King wrote:
> On Mon, Jan 29, 2018 at 10:33:08AM +0100, Johannes Schindelin wrote:
> 
> > I found these sad news in my timeline today:
> > 
> > https://twitter.com/cdibona/status/957822400518696960
> 
> Thanks for posting this.
> 
> I know Shawn has not been all that active on this list in the past few
> years, so many may not know how active he has been behind the scenes:
> 
>  - serving on the Git project leadership committee
> 
>  - managing many of the contributors whose names you see here daily

I'm one of those contributors.  I'm very proud to have had Shawn's
leadership and guidance while working on this project.  I would not be
the engineer I am today without his guidance.  He was always quick to
drop what he was doing to help and despite not having worked on the
project himself in a while, he was able to answer, in detail, any
technical questions I had.

He's left a rather large void on our team, and he will be sorely missed.

> 
>  - working on other Git ecosystem projects that aren't on this list
>    (like JGit!)
> 
> Over the many years, I've found him consistently smart, hard-working,
> funny, and just overall pleasant to work with. I'll miss him.
> 
> -Peff

-- 
Brandon Williams
