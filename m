Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCF4A203E1
	for <e@80x24.org>; Sat, 23 Jul 2016 08:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbcGWIDM (ORCPT <rfc822;e@80x24.org>);
	Sat, 23 Jul 2016 04:03:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:51048 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbcGWIDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2016 04:03:09 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MA9FV-1bbZGe1aAr-00BIhs; Sat, 23 Jul 2016 10:03:01
 +0200
Date:	Sat, 23 Jul 2016 10:02:22 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	git-for-windows <git-for-windows@googlegroups.com>
Subject: Re: [PATCH ew/daemon-socket-keepalive] Windows: add missing definition
 of ENOTSOCK
In-Reply-To: <xmqqmvl9a2wc.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607230957320.14111@virtualbox>
References: <28dbe3b0-7a16-1b87-3d59-b8c981fead7c@kdbg.org> <alpine.DEB.2.20.1607221020520.14111@virtualbox> <xmqqmvl9a2wc.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PtXLJe3xz5KxyPZ56W6WbKtevvajw1blEOIgJ/fdxIgay15lpDY
 MfL7F6vzRiXXN/HCZs9NLL/vSGwLwdnJfL+sOGsC3qdqOy+FxSkhdJk77IIolXe+TiCPr1k
 NHQwwSgynhUOxsXLXOVUDYC8qAp01LIgCYk6Ol+Ew3txZv/LqxJiwQkR8HfoVAFm2eC2LpQ
 WxMBZ2oy+MIzpEUp3o+Kg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:uglz4RjaACM=:gp5wMUtJxXVm9VJI/oSCj8
 59+Gcc0AnLZuq5msrqGhF4QeIaFA9At2FpxBTBnsY9acYfkHyovF/OUp2KrEvVH0vpNiv5hss
 0pAL968qXiSxI+yd/UJioeQauNZNrJtmvpQILPoc1EdsdPcrxnACHUOZQv+4fKqgFKCCuPgrV
 iYyjFaSvy67tHHLMGjv8p3O4OMMUgozEg9SFFlVmpDPc5FPEZgWYDW+IGXPyfcgF+is3+9D5K
 CaukpsnZgBPsyQHCq5knL73sQ1aDvJ8zun06VvE/6mnhjV8sZyV7X2XsBpByCcNWADfdoK8if
 2MdWbWCc5VF1IzzAkjePxn1H4GsG7LKrP7qzv4/XSaIN2uOM+90XQ2ELkjjxotFH4BP/4y47J
 SKmsMuXWIMD5uLYZkJYxbF1SBFJcq2fuUqHQ4wd+FSMNo6DdYvHxQvtMZdIMibPak3IFe9Tu4
 mPqG0sN5bhRqlaY0Winax1zI96dDivr6lPwqwlPzbDM0DwTAjxytTQ+SkAnZQvc9G51EQO7GM
 Bx/4Rx8EXNtVFPIkVdBFbh4yDpW1sayyPxIwqN5eCxOVBAPXyqPLH+Scy43RonKLlZ8X9+h2O
 nNdZzmZtvnVwM1TUp3r/jth695eLKVemW/CHER4mCl8I4erG3vaHB2/xhU8z1V7/D/ncAUVVN
 jDeefjZ8nuTiUycnK4ssd31tB3GVdAfKLTVIOLTGEDQG2UDA1Ucs2a9P9Y7O1M/4umW2GCQ8j
 0epPQNXKboEmD5i9YPlaNsI5aAi3EArpJhVYARHeJWkzWwvyh+D31KvexfANNSq3ctI+AXupz
 Vnl7jPj
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Fri, 22 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 21 Jul 2016, Johannes Sixt wrote:
> >
> >> The previous commit introduced the first use of ENOTSOCK. This macro is
> >> not available on Windows. Define it as WSAENOTSOCK because that is the
> >> corresponding error value reported by the Windows versions of socket
> >> functions.
> >
> > Thanks for catching this early.
> 
> (is that an acked/reviewed-by?  it is OK if it is not).

It had been neither, as I had only looked at the patch briefly (which I
deem not enough to account for a review).

However, I now reviewed it properly and offer my Acked-by:.

If it is not too much to ask, I would love to have the following added to
the commit message:

	For details, see
	https://msdn.microsoft.com/en-us/library/windows/desktop/ms740476.aspx

Thanks,
Dscho
