Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7E471F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 12:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752473AbdAZMVu (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 07:21:50 -0500
Received: from mout.gmx.net ([212.227.17.21]:49187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751829AbdAZMVt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 07:21:49 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSHax-1cv5XV3WKh-00TSgb; Thu, 26
 Jan 2017 13:21:22 +0100
Date:   Thu, 26 Jan 2017 13:21:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mingw: allow hooks to be .exe files
In-Reply-To: <20170125211529.jq4halip4ndbff5k@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1701261321010.3469@virtualbox>
References: <dc388b2df3baee83972f007cd77a57410553a411.1485362812.git.johannes.schindelin@gmx.de> <20170125211529.jq4halip4ndbff5k@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zg11fX27OG4rUdpghszfixBqZFSn3NoyN1Y0cQhyfZnDpqG0C9Y
 +sEt6kPwXeAM0cpc7OM62QdaGzJBwiukRLX4uaEP83Bt/wpSpf8LPGt6PiVScNEohWEEBhB
 vGPEbC5bBtl0RvZbS1wVsnbNI1kGm7lJRR3Zb8Css1bI1f8BOWOZ0kpByLSH2A6h5IIvGs0
 nxMyEhWIu9ijPk8H92e8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QMCQ+TkkZiY=:nE2a63USmrogxVwgPpVLXK
 aYnRmUgb0nNJ5U9zJbuGDjqPinRDKhy1aQfxK7BpWiibZKleTXairT3NYD1cNx6L5I7stgNbV
 VGd84EOUkVZiN/kW6Ghw5w/lXm//GGHxKq2sZhoI9rmVQtkIIEqgT4UThm0gmzhUcduaTAnYj
 Uj27ObPIj9iKPpuRSSdoOItyRXqUpy8T+u4EJETe6N5LnDJrV7PnWrJ7D2l1mPPnJukv1ruy6
 i1kYLyNlXMXAeXQIiDueI2djMJnyNS+lPiAmX74HtZKE7y+s1xzqWr2mEbdY6knaqYpQrYR5O
 3qggjP6vjuneXlKTWZ676HKjP07o+uOPinfd7YkPr7meeifc+Ql6y2vJwZjqOzRIZhP58NlNw
 vOs4L1MzdLRfPMYGx8fwl3JRGQae5qk5tr5tx6Fg5d9aJ9Zojdq4h+SaMMpWEUfgxSl2c/Rvl
 24AOiBLwQpdqlh9cBVwnNI3rawb78h4q1qo2ZwweRPTFX27dOxdPTDONn+3GER7wufYdqWTRd
 up2eOiW9uULd4vdHKuJP7i18AaFFqpaXY3g0yeehL09uk7q0Z8Yl0DFGsqa5HXHhvPCDRWHMz
 oQz1u7w8iopM8yC+UtNQKgw16gKT5ewPMjq51J9mI+MwMcI75W97vSfzTqhIah5VVCJ3LGum3
 7Zte0jZVs6Pey8zybfVZpVjEVxS8RtS8VG9vlIXAMFyxcjrjqve62N5g++KiwIHBT0hkMEo3h
 JDGNFaRbnnUU8kyjXRqL3Ae4k/eSPyIg9geIfi6DPgYHbEiw4hZu+KUaKtGledMS476E806Il
 ssLdpM5+67gcDzEgPdjJ2I4XMSQ4hOBAQpiksASYdcygIBvZGdlVri15mXWbSHcLNfCK1z1zj
 R7vYLoUC6t14LdyJ51GyxDJLG//5U5Ez3/7janELbCy7azH0O2T1nzIfsGTN7CLBweLoDm3Zm
 Dg35gqHi/5yZZUPKbBw/IygJKnTieo9gQ3RFV+xDfsEgjsboPibIXjafRz/Upyqup97HzN2aw
 Bg+xSTn/MN/dndzdDHiQIjk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 25 Jan 2017, Jeff King wrote:

> On Wed, Jan 25, 2017 at 05:58:42PM +0100, Johannes Schindelin wrote:
> 
> > -	if (access(path.buf, X_OK) < 0)
> > +	if (access(path.buf, X_OK) < 0) {
> > +#ifdef STRIP_EXTENSION
> > +		strbuf_addstr(&path, ".exe");
> 
> I think STRIP_EXTENSION is a string.  Should this line be:
> 
>   strbuf_addstr(&path, STRIP_EXTENSION);

Yep.

v2 coming,
Johannes
