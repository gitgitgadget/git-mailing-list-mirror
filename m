Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 522DC20986
	for <e@80x24.org>; Tue,  4 Oct 2016 16:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754092AbcJDQBv (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 12:01:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:51355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752672AbcJDQBu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 12:01:50 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LjIBr-1bKbZu0KgJ-00dYvC; Tue, 04 Oct 2016 18:01:29
 +0200
Date:   Tue, 4 Oct 2016 18:01:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Rich Felker <dalias@libc.org>, git@vger.kernel.org,
        musl@lists.openwall.com
Subject: Re: Regression: git no longer works with musl libc's regex impl
In-Reply-To: <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1610041801130.35196@virtualbox>
References: <20161004150848.GA7949@brightrain.aerifal.cx> <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VakdgbLkIQxk5U2kLtG8nCPZZs6y0QNFu9quruWOMV3DKgVTNOw
 Yide4djZSHnYNFhDd//cdxEoZr+5RNLFLyvH/ao03gyC5tRxHwkio7WEKgeG2Ir+kKFRnbm
 oAtVPnAezx/dX4TLCzteyoU//5VJGIJeASz7b1Hwa+LXEt2qjMSKFSRBBonnR7AMlF3d9Av
 2RRXRGnN9ZTQfhYIjZ/qw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YNO7rwasL8Y=:5UeyqLrpeB8xXZq3lE+mEq
 uJapNpbjh6A0RJIdrF3kmN22GxdKfPvwoN7MKcJsbcezD0DapGoA2i1t3bP75t+VycF/1Mdue
 21meuRcNW4sARqSamL9AREJh4E/JOOwXdSmfbwIICKz6U2LyskfTxpChdT+95VXX8UnBap9zD
 p9cGQa/s2sHAn1vfEoUIgXKqwlabBTLOnETZ/Axl3qnFezYMnmsCdjWvlor7vwckyXK92nAwX
 iZvI7MtxcWIBN9jj7kvHs2KMJn01bFcZ3AuD1fp/o99xcEIPlVbpS7DyzupJv7hyzeByywGDW
 L9Krtmvcm5hLEpfGxx7jb0ajHglev+rDpDNeAaoBQuoWz5KG65odzvdukoF7ZfO9DPzcK6PK+
 si/qMJzApaoNKhJ8lyEuz2gnq7VWqzKYCMvl2wAytBBx6P54MNMiH+kLYasLvDmugSDzwkIy3
 p+ReMPSIgMaTC6zmB2dfMpaxwsS6LmnPnWAXfMYf/lrivYtk+LxbS+zyC1e0IK+bQ1qrGBHTf
 qTFfiVzu/d1SvzFTvzeXzvnGC/Oc6ChaySZCw4mZLfYhJ+UfPOJwshKwIF1tOKOouJg6WR4jz
 WoNUu2f1PiBRdjLJQn2qobv7aMzQ6lnikVmaDoj7n8Zb1nxpOk2h8Xm7fhupWPIV9j5iQBEaZ
 i3c56PxOuSf68rnTSUJN8FFxzt5R81YeZkDgWiTof4whcIPJoXWijuPr+s/xH6OO0raNwD0sS
 bvkwvxf3HGIGXMjDKAo8hkqc3s7sG81c4Co+gnmBFkn2TYWv1vIv0Ti0oozNngSIp51RZZq9y
 wWDEmTp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 4 Oct 2016, Jeff King wrote:

> On Tue, Oct 04, 2016 at 11:08:48AM -0400, Rich Felker wrote:
> 
> > 1. is nonzero mod page size, it just works; the remainder of the last
> >    page reads as zero bytes when mmapped.
> 
> Is that a portable assumption?

No.

Ciao,
Dscho
