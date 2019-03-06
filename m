Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23F7C202BB
	for <e@80x24.org>; Wed,  6 Mar 2019 20:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfCFUUB (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 15:20:01 -0500
Received: from smtp-31.italiaonline.it ([213.209.10.31]:35180 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbfCFUUB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 15:20:01 -0500
Received: from DESKTOP-E4U7JCE ([158.148.73.124])
        by smtp-31.iol.local with ESMTPA
        id 1d1ChvnnsCH4t1d1Chodov; Wed, 06 Mar 2019 21:19:58 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1551903598; bh=ldcIV2Bzq8U4Y7Cq+d6EmguMkng0DaYyTAmJT4bICk4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=cG9H+7kpUnzU/86eN1JozKsMs/ksv9X9qydsQtxU/mOnNlIJnxvN3VSl2XpIUysJV
         NS0ePGMB9cGjxCU0zCi9a5NJDs5NM8wbvAhFqRsCl3otpeL8kcSqLYtu1yEeqOY/+f
         WTrlke0UXWPy/ilO0bYRSg9s6IzAz+buUUpWBsZ0Sek8dqLFM2IfwlbwqUdhrbhvmx
         Fq0vB7ZbM1kTDCuMCy51SwsnMc81yG/tfOy6n6WS8f9q0n67n77Oq6iVtsuXUCngCN
         P+DL/N/uKuQ2/Ibz1IkX8AHtLKrURbtXx/eF7ZKGtkmIBnZSElhBeyzAQeVt5yAcml
         wGNW3Ku6jk1eQ==
X-CNFS-Analysis: v=2.3 cv=R4HS5uZX c=1 sm=1 tr=0
 a=lD+Fqu6e8C6S12qGMBovIw==:117 a=lD+Fqu6e8C6S12qGMBovIw==:17
 a=IkcTkHD0fZMA:10 a=m9K-5bKlhflEYPrcX6EA:9 a=QEXdDO2ut3YA:10
Message-ID: <1551903598.1727.3.camel@libero.it>
Subject: Re: Can't build first git commit
From:   Fabio Aiuto <polinice83@libero.it>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Wed, 06 Mar 2019 21:19:58 +0100
In-Reply-To: <20190306200356.GB23315@sigill.intra.peff.net>
References: <1551729517.4092.1.camel@libero.it>
         <20190304204007.GA32691@sigill.intra.peff.net>
         <20190305191519.GA12791@sigill.intra.peff.net>
         <1551902320.1727.1.camel@libero.it>
         <20190306200356.GB23315@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOX5ln1aFrq2YOMY7O9HZ6C184XWKRhbMxR9Iwm+Jfz9P7WwU/qUiqGcztqsIVDEkMMnAKPbUtN5SkG4Mlu6ae8vkKTggZNGLIw+/+LjQMWQvSIr4McU
 GbRjhq8FXNrkJwvb2hhpZW8Up9WfH1YRb29HprfQ9I+FGA8unEMr5FjeNLHlt9esdqPuZljyccrG1XF7VNFPjdl7dK2j86tCFJ8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes that's great.
Why somebody told me about a outdate toolchain when I started this
little thread about first git compiling? Sorry for my stupid question
but the you just resolved with that make override...
Maybe there's something I have to know?

Il giorno mer, 06/03/2019 alle 15.03 -0500, Jeff King ha scritto:
> On Wed, Mar 06, 2019 at 08:58:40PM +0100, Fabio Aiuto wrote:
> 
> > Yes the fetch command wasn't written at that time, right? I didn't
> > understand why should be better to work with the git code from
> > github.
> > There's something I misunderstood?
> 
> I just mean that it is an interesting fact that modern Git and Git
> v1.0
> can still interact seamlessly over the network. I.e., you could still
> collaborate with somebody using an ancient version of Git (hopefully
> nobody is using v1.0, but logically it extends to all of the
> intermediate versions).
> 
> -Peff
