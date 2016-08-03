Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC7121F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756950AbcHCQRn (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:17:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:51439 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753408AbcHCQRm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:17:42 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MXIGf-1bjdN50xdN-00WFGM; Wed, 03 Aug 2016 18:10:54
 +0200
Date:	Wed, 3 Aug 2016 18:10:52 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Jeff Hostetler <git@jeffhostetler.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 0/8] status: V2 porcelain status
In-Reply-To: <CAPc5daVuD7K7zKEG4yHTjBU77rUbdVcbSeBgX9eAJVMWMmxC2w@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608031808130.107993@virtualbox>
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com> <alpine.DEB.2.20.1608031708560.107993@virtualbox> <CAPc5daVuD7K7zKEG4yHTjBU77rUbdVcbSeBgX9eAJVMWMmxC2w@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dCTQiaJYdsD3BcWczcQEpCDSz0rUOZk6ga46+OCfYC9tWtBxTCl
 fgrr4OXGDpg1fz4KGnz3aGO7VVCoMHBkYvc2KTlJz4m0WwxSvTZAiRgl1tabCY9hvaXcDpB
 TRhyy5hJl1fSUFWT1RbTBpl6qJKUkrrgR+QZF29FqkzoYhD8xE49DscMRRYGFA9flbDDId2
 nLydQjuHLY6qNchhVb0XA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:wA9HpLi8gPg=:/5uTWXM8o5ml/fB6fd8BJY
 /w7QL09y92uf37/cKEnFyMJzYFyzm9APpyRvGXdFAAhOaTMtKpJxUXLRk/qRNk8x8Hvv0AMR+
 CaGADlHMLEMnAer/A0NVPiRYlaOI5oo5lO31JT/XnnYBBLsZyJt56vwYSgOcHHVnOTCSPb1jE
 1qPKFZFRSKx4Fq+8/0Y8Gwx8OAPa83TtvKdziIvFyNcEnMPQZFySLZq+Hgmyp+/TqMj5atCgv
 AcDoFMa4wtqscTHnjPRlVZF9tTPWatrBxhjHp/bMJsPJnDw3faLb31NsrinxscnJ92EApKl8i
 u9iQZVAqKwYRwKw2pgRha1S2Lf9PrLH1cpiR++4uCnCoSMuObW1st2lW6OJUX8MttL0iWctd0
 ekLatSqtiRwdxm2rW5R3e45WqLY2KFjTLIe8PZ8SD9jEVQBvyXYiLx59cFIh0s+0UXwAHIDF6
 HIEPJKjj7nUzKHZ42NJRy81OL1i3OvYFslInHxBreNA6+cLlrqxJrWkha6KASkvFEhyWwzMdP
 +X/25ZPPqns1WuTECi48r47BW4Ijr8U4FZC289a6AZMuuvLPkY16y+nEPOKED6L91nFsE5VZT
 fmtS9Bbc0Xh0P5I/4go0xntxymkGqW5LAPo8PzcgPFWZSYOIiMqirON/dF83PNfBUlP+DMXnj
 DUoD9vlOgkQriNkFYPCIrqEly2zAJpj5LKfUiKXScLkcJus5DS2ccrdpWTULgmnlkfUka6Ruj
 uK9W/MjhtIWcksrKXvM2sQsCeorJ5bR32TKIXR7sLoxSpzrUTXXqj+aWV5Fj7Y6BARCZKRNV2
 M1lJ566
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 3 Aug 2016, Junio C Hamano wrote:

> On Wed, Aug 3, 2016 at 8:09 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > Any word when it will be included in `pu`, at least?
> 
> I've been waiting to see that the amount and quality of
> comments from others indicate that the series passed
> the phase that goes through frequent rerolls. Having a
> serious review in the thread that demonstrates and
> concludes that it is well designed, well implemented,
> and ready to go would help, of course.

Oh, I thought I had stated clearly already that what with Jeff being my
colleague and working on a feature I have a lot of interest in, I had
reviewed this patch series even before it was submitted to the Git mailing
list.

I would have been fine with the first iteration. And I had nothing to add
to the subsequent iterations, they are just as fine for me. I think the
patch series is ready to go.

The prospect of accelerating the Git prompt is also enticing.

Ciao,
Dscho
