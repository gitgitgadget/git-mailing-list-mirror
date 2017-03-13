Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DFFF20373
	for <e@80x24.org>; Mon, 13 Mar 2017 19:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754470AbdCMTsy (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 15:48:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:43439 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753980AbdCMTsx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 15:48:53 -0400
Received: (qmail 32456 invoked by uid 109); 13 Mar 2017 19:48:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Mar 2017 19:48:52 +0000
Received: (qmail 21692 invoked by uid 111); 13 Mar 2017 19:49:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Mar 2017 15:49:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Mar 2017 15:48:49 -0400
Date:   Mon, 13 Mar 2017 15:48:49 -0400
From:   Jeff King <peff@peff.net>
To:     Dan Shumow <danshu@microsoft.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Marc Stevens <marc.stevens@cwi.nl>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Put sha1dc on a diet
Message-ID: <20170313194848.2z2dlgpomu6e3dkh@sigill.intra.peff.net>
References: <20170301195302.3pybakmjqztosohj@sigill.intra.peff.net>
 <CA+55aFwf3sxKW+dGTMjNAeHMOf=rvctEQohm+rbhEb=e3KLpHw@mail.gmail.com>
 <20170301203427.e5xa5ej3czli7c3o@sigill.intra.peff.net>
 <CA+55aFz4ixVKVURki8FeXjL5H51A_cQXsZpzKJ-N9n574Yy1rg@mail.gmail.com>
 <CY1PR0301MB21073D82F4A6AB0DAD8BF1FCC4280@CY1PR0301MB2107.namprd03.prod.outlook.com>
 <xmqq1suge1jn.fsf@gitster.mtv.corp.google.com>
 <CY1PR0301MB2107112BCC2DECD215E70549C42A0@CY1PR0301MB2107.namprd03.prod.outlook.com>
 <20170313151322.ouryghyb5orkpk5g@sigill.intra.peff.net>
 <CY1PR0301MB2107B3C5131D5DC7F91A0147C4250@CY1PR0301MB2107.namprd03.prod.outlook.com>
 <CY1PR0301MB2107876B6E47FBCF03AB1EA1C4250@CY1PR0301MB2107.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY1PR0301MB2107876B6E47FBCF03AB1EA1C4250@CY1PR0301MB2107.namprd03.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2017 at 07:42:17PM +0000, Dan Shumow wrote:

> Marc just made a commit this morning fixing problems with the merge.
> Please give the latest in feature/performance a try, as that seems to
> eliminate the problem.

Yeah, b17728507 makes the problem go away for me. Thanks.

FWIW, I have all sha1s on github.com running through this right now
(actually, the ad744c8b7 version), and logging any false-positives on
the collision detection. Nothing so far, after a few hours.

-Peff
