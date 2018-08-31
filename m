Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DDDF1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 21:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeIABXz (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 21:23:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:43139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbeIABXz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 21:23:55 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLunc-1fz9bH1id2-007jEO; Fri, 31
 Aug 2018 23:14:23 +0200
Date:   Fri, 31 Aug 2018 23:14:20 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, Jann Horn <jannh@google.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/5] t5303: test some corrupt deltas
In-Reply-To: <xmqqh8ja360p.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808312313210.71@tvgsbejvaqbjf.bet>
References: <20180830070548.GA15081@sigill.intra.peff.net> <20180830070932.GB15420@sigill.intra.peff.net> <xmqq8t4n69gy.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1808311155410.71@tvgsbejvaqbjf.bet> <xmqqh8ja360p.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7d+1nKZgSf49qbBIekebikORx3dwwO7iU0yMQMmSp9RYnDF8s/9
 KRwSRBA3+si0/2LvX2oLJHCl8Hg/TyIuuagmPPUeD5bEtJ9gq4hUC8TygfynmsNr1EqvQyO
 eypPnvlcpGaoeO/Rf+PwFan2gDbFiS+SbmKMbXcaAFkDyvTNXjnDHvrJI2+g6UhN5wCk8n3
 5+LQBHw4CzWGoKO/BzjNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rVrZgdsa/vI=:tz9+958FujHPBgo0ANkZ2F
 DIXCunJxi6didc5Ve1YDNeuD4XI/Y0c7+/TpXYzR+AQXxcHQxloLd0JB5BuF1C+zjQY5iWy8U
 5DbNDzIK+n2qiqQ25N7pbjhNjk8dNnlco4oG5U9VRo71PUv4dbst5NjhSOu9RJw223g3sM8+f
 nbP+u38zagrRZXNtwQIr7VrLNWScOoSEGL6VjCwU459WAz+vp0GVpbuN5wsZTsV9+pFWzCnpt
 p0sMsVUf7cuHG+ef0jxZwz9CD+90vXbmvU4USVxzIKgKzOGj+Ihy7YZ+eyfBp4eOdEbNZRDEy
 /w3VV8YHBjIDU45TwUHWlc9/SdOX2UY9ZflPbF0F0MOQRvXXMxOsEHbFcY9A0TT+kdJz6qyzg
 50HjtMhWZcUHusqQpkCjFQUp/AcLv3fQzGF1IvoP/Xml6GoqIRbfrqkTgJ0TCKtdl6JFilTVs
 PMTnwWsm+s5b6u6WvogNfhfxIR3MG5/sqWNPNb3meguZlHOKNpu8NTKgWlk9JceMuH4VxmT4t
 l0dnkAITr84X+XuclpFZB0C5P4Hh7dLouZMhL4TZwellNpQS3Q79+aug23/beNeiotEhUF2US
 Nb9eQ8tnhbOqhK4G6520MbZ7Yu4Jd+ugvpFwG7Dy3leTtBvftA0hVhiAnCpp6+sRxqgj5ZZcH
 fNkdKIYnOoHj1Ebkb6UjQyfLwWCl1tsLHqT/567AwXWw0IPDqapJQ7/MABWYotrB3JLmoEWMf
 BcWIn10Ekm15FT1s79DqlxLGDP9EZTAOL9uH7DZT2KaTAohVfyi2yu9kfM0NBDXEon6p4K5cp
 wM3pGTs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 31 Aug 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Would "echo base >base" give us 5-byte long base even on Windows?
> >
> > Please note that Unix shell scripting is a foreign thing on Windows. As
> > such, there is not really any "native" shell we can use [*1*], and
> 
> Yeah, I know that; otherwise I wouldn't have asked.  Because ...
> 
> > therefore we use MSYS2's Bash which outputs Unix line endings.
> 
> ... I didn't know what MSYS folks chose, and/or if you have chosen
> to tweak their choice, and/or if you switched to somebody else's shell
> (e.g. busybox) and/or you chose to tweak what they do out of the box,
> it was worth asking and getting yes/no question.  You do not have to
> tell me why I should be asking.
> 
> So instead of typing 3 lines, you can just say "yes we use echo that
> emulates Unix".
> 
> Thanks.

You could just express your gratitude that I do more than just answer a
question, and impart more knowledge that will help you be a better
maintainer.

Ciao,
Dscho
