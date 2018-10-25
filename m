Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E81181F453
	for <e@80x24.org>; Thu, 25 Oct 2018 08:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeJYRJg (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 13:09:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:53954 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726637AbeJYRJg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 13:09:36 -0400
Received: (qmail 986 invoked by uid 109); 25 Oct 2018 08:37:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Oct 2018 08:37:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14658 invoked by uid 111); 25 Oct 2018 08:37:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 25 Oct 2018 04:37:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2018 04:37:50 -0400
Date:   Thu, 25 Oct 2018 04:37:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Mirror of git.git on gitlab.com
Message-ID: <20181025083750.GA16581@sigill.intra.peff.net>
References: <pull.31.git.gitgitgadget@gmail.com>
 <8736t7dzan.fsf@evledraar.gmail.com>
 <CACsJy8DeA0Zko4+ZM5F2L6YO5rpvL9LX3H9NB_bVCyO2mJFUzg@mail.gmail.com>
 <CAP8UFD3cpXpyx-AtTybPirzduFR7TfhFf2woa-_CU46DN3RaXw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1810152032140.4546@tvgsbejvaqbjf.bet>
 <xmqqd0sa1omm.fsf@gitster-ct.c.googlers.com>
 <CACBZZX59vT1CTiUPfPZDJUSRH=NSzmWiabux=KRdTUFa1R=5bw@mail.gmail.com>
 <xmqqo9bsvwn9.fsf@gitster-ct.c.googlers.com>
 <87k1mecj96.fsf@evledraar.gmail.com>
 <xmqq1s8iwnb4.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1s8iwnb4.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 02:41:19PM +0900, Junio C Hamano wrote:

> > As an aside, I noticed that
> > https://github.com/git/sha1collisiondetection/ has never worked in
> > combination with git.git, i.e. it's cloned at a version that pre-dates
> > the initial introduction of the sha1collisiondetection submodule. Our
> > other mirrors don't seem to have it at all relative to
> > ../sha1collisiondetection.git from their git.git.
> 
> I do not recall who cloned it or forked it there or what our longer
> term plans for that repository would be.  I think we are using this
> thing: https://github.com/cr-marcstevens/sha1collisiondetection.git
> and there is probably no reason to have our own copy.  Perhaps we
> should just get rid of it.

I poked around. It was done by you on May 23, 2017 and then never
touched after that. I couldn't find any discussion on the list. So yeah,
I think it makes sense to just delete it.

-Peff
