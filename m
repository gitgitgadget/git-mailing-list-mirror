Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D2C220988
	for <e@80x24.org>; Tue, 18 Oct 2016 12:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755108AbcJRMjZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 08:39:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:49736 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754966AbcJRMjY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 08:39:24 -0400
Received: from virtualbox ([95.208.59.171]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0McEDD-1cClKv2mEp-00JXT6; Tue, 18 Oct 2016 14:39:06
 +0200
Date:   Tue, 18 Oct 2016 14:39:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        me@ttaylorr.com
Subject: Re: Merge conflicts in .gitattributes can cause trouble
In-Reply-To: <xmqqvawqvp6y.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610181437180.197091@virtualbox>
References: <248A6E81-8D5C-4183-9756-51A0D5193E3E@gmail.com>        <alpine.DEB.2.20.1610171803400.197091@virtualbox> <xmqqvawqvp6y.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:z3LDIEyBXn21geVHAmA8j/lLPcJp2cmLODvRk/8cq3oqjC7i8A/
 khmh7NwupSwj6lAUtkDNZVNYyftFO53hNt1ueD2o8eSkvH8x2sM00XiEcIPQ+tq0xElcg2f
 65epJQK+9b+VwVpB2nEDFtQpzfLniLupEy+cXK8jSLHdczj0Q0IG1SObRcQVWGExsrJ5AF3
 GGPbuide8uQp20ls0a1lQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zzAw+ENWfHY=:t2RQxdaLA+h9y8vTmaJJjU
 tyUQ6bU1Hg7Gd48vJY9ryd+kHo64QFkgvqAjOYDu2lBi7depA9BA5fdUNwkDDarvqXEfjrA/T
 b99MKLbx+fowKPu3hSnSvMaeIWz+jCwq+mCIbUt0Rx99KNVfXEAoOVSL291M6VfUre8LINzXl
 EUFClBX5dxk6M9ICCb8dxxMTa15RJENi1XMKjFs9YD95N7L461a4aGNmPKyL3f+9Nt0VP6AxV
 uY8EqJybuYSmx1GU/ocSqg0pt6uyZDpx3ZLAePb4eO7Pk4Q/JmwnedmM5zFnSYcZ6JRet4u6K
 1kfoZ8Urqj2uzQamJil35Qpn2f6v5XTjUHJJ8dUunUiZyXUDlxZTMwnPpXB5rb4aRBKcsI1IA
 pE39T2zUuTkRS55PlNMdOx5rq+MBW5FpxyQekFWHIHQ0++5Rk+gqgvm230B3/3BLRl4cPB89+
 +3kfr6yBB5+l5CGkoftDhC8mrpEzwK+0Y3fohJPhB1+fN8kkXjHJkKGlKLPmnZyY/xtLlQ13B
 U/3Tlaz92ZZ7rHNLHi+bMKKe7y+k7fcUsSguU7x7+N+wuGkr91HKbPh2TQcE3lmznFXmBGw5s
 p/Z/zAYxjsj8c2bOvwyMGU+jgg723pTcDcOSAh2CksGyTdMC6F/fPkVCkmIaVFspKags7ZCaK
 XgFU4SmDD66l0Rc0zpk1r3yULdBkFW53By8ESL9SRah8ECtPjfHrsvtJ2jCt2GHNAp4BW7K4S
 JR69sRP3XXDKKEeWPCVqZNHeBNklWYjSDX8Sl2qHSCVCGyPDKHW9E53f0HoWwt4t0UgLZIsG7
 LcSxjqJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 17 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I would vote for:
> >
> > 4. We keep letting Git read in the *current* version of .gitattributes
> >    *before* the merge, and apply those attributes while performing the
> >    merge.
> 
> Even though this needs a major surgery to the way the attr subsystem
> reads from these files, I think it is conceptually the cleanest.

To the contrary. As far as I can see, when calling `git merge`, Git
currently *does* read .gitattributes from the file, and if that fails,
falls back to reading that file from the index.

In other words, option 4. is the current behavior no change required.

Ciao,
Dscho
