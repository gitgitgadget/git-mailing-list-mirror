Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A1301FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 11:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbcHILdQ (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 07:33:16 -0400
Received: from mout.gmx.net ([212.227.15.18]:58027 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522AbcHILdP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 07:33:15 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MEFlg-1bQQMj3HbM-00FRbB; Tue, 09 Aug 2016 13:33:06
 +0200
Date:	Tue, 9 Aug 2016 13:33:04 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
Subject: Re: t0027 racy?
In-Reply-To: <20160808152926.mciovipy5qlnqegs@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1608091329480.5786@virtualbox>
References: <alpine.DEB.2.20.1608081556280.5786@virtualbox> <20160808152926.mciovipy5qlnqegs@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QuXSw5eGecMnYoejAeZiQGsNerw9bbQCpHtvPWY05bgtoRfZF3x
 zUs4hUil4UCjnaEhwx8ZfECF8EYVtsee8JDwq5bNWM4gBtvDOKplRJCKeqPcsdZivhR//S6
 ZDviwtycAoaFU4bKPbE6snwQrCCXx8iFkVvV4ZikMmZSTixfq/BW6k7GnSBkuRgGAeOrPsu
 qlJRECafd6LROQNYuavjg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:3Lfb9t5uuCc=:wJ6n63bho9cvNRShPwXiya
 X6TPyq7hMJBgB5OdErZc9mNjKaEYVGXHWR2a9bsI6s6fntVBXhEhns5AQXpoEGMxsPSoHqsjk
 mxddfF2F2BsYM8LzSgJI4B0VK7tPrNDA28igHPoCRAqzeI7rpECyrv+R147R0rkn/RXavOXik
 s2YigZYXY+2ZmOdAI4hThTYYfgZOTfJXD7/lY7ZKKYXtgX9ZoUQAmKQaVnw2D597UvfEAA3Kv
 HdnHwAJ5QPJ9niGewSS1rnCbMYtW6bYm40MJjp8bKqRda5w+w6bDFxnNu0xVyDmMXgi0vr5an
 dKr3hGzys4/uYzhUIc/MXh0ptsuVxZF5xhX+uVirLs60Td5rMVW0+Fo9vx5p7W8/+ZzC5eGsy
 QI/jHnE9S6kl6sQwdAnRqwBmDsBGBipnzP3Rmq253ybSuJ2AMXJ849b2kxD5TBUq5P8B7tIMO
 dYT9wzD22gaiJaeYyyTcXAZPNkFv8w4h/X5LjSwsxXbFmbRMrmTcgy4/HTf2KHznrWl7rSpZ2
 QXLzmJ9hCklydTx8XyrDJyUUSbmibaEbUgGWFvIHCNpWtcsGrjsbugWD2a+qGJik+nunMnkmm
 CjZSxYNO1w5cZ5w7CjRYRcO8mAO7pKyY2K8t38gbk0jRasM4fXuVPrCVGWqxSMs5lWoWlSxxI
 xvC1EjiCR4ojnidXBITg17DP3Y6Xc9NLRI01PAYIwAh4CKSKj5hG0I+8NiHsCpDIi+Q56AGh8
 SsheEOSDBbdnfiDm2vqNU1yuCRA9/g2F9ZtdDFYcHHEB49fqvPMcuG4aDK9XQEFLhZ2o2totn
 w/tXMAV
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Mon, 8 Aug 2016, Jeff King wrote:

> I got failure within about 30 seconds on t0027 (though 5 minutes? Yeesh.
> It runs in 9s on my laptop. I weep for you).

Yep. That is the price I (and all other Git for Windows developers) pay
for the decision to implement Git's entire test suite in Shell script,
including expensive tests with over a 1,000 test cases such as t0027.

Ciao,
Dscho
