Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F14921F732
	for <e@80x24.org>; Fri,  2 Aug 2019 12:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389220AbfHBMM5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 08:12:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:53761 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387770AbfHBMM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 08:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564747969;
        bh=8yGeFu18GtlMaqMBbJz/7Fjjr/LBoXjRQQJrGxIr+SE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DHqtcwZsUJA6z94VsVJPB8qRM/gu3fKIMwbcZSzttT8bM9Yj6rvSq0XGRQlAzQvxl
         y2rfP5NsQcSWOQ6AlrYWGDbnvLGWE1Df+1lsuvsNIiAg/dkXYNNDjtDc4K9x+mCrth
         OKjBfb/6Q1lpfyShp0OIjR+sSkn5GwaFhqoGtozQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOBOi-1hwqLl2XJ6-005clr; Fri, 02
 Aug 2019 14:12:49 +0200
Date:   Fri, 2 Aug 2019 14:12:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: js/early-config-with-onbranch, was Re: What's cooking in git.git
 (Aug 2019, #01; Thu, 1)
In-Reply-To: <20190801214247.GB30522@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1908021410540.46@tvgsbejvaqbjf.bet>
References: <xmqqv9vgmz2f.fsf@gitster-ct.c.googlers.com> <20190801214247.GB30522@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:StEEdCNRhi8HwLygxwKG5Bi7xBhM9Ryxtd/Lb+BEDzBvJH0Vyl5
 rE/1C2eBIfCJo/ACSqfAJFqL5v5r1xLEavAObTVSrV1rXl/KmzOHohpdpTmCPCqW9OWCgGT
 jXrz3jUxsziaxLuyrRIW/qwVOt32LwVopH2MCHMaFVfcZ0W3NWiEfg8DoJtnQhzOCROov7S
 MuK2OgFLZv9yvicfStiCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qLAuR39cymI=:EjfCMu1eARgVXQJUXlS71F
 h1VtoeNBI4k1reQM3/2xJ87sfnMvfdd7qbeykq8Yct8MnrhNqYWEuY5bIF3Iq+B5ItDaPUtLq
 DTL2qMpeCloxEskp5OsiIO+pWTbv47wVhRBDi3F+PGsZr4KatE7NWtkiuwsvd7UzEDdARU7YQ
 5Utk6e7t3b+emLMzr3aYSLPm7H5rQy1l4mpM3jSdQwbMXSJYQpjy/zv9CRjtrRStGYh49ilea
 u7v+XzEhGBlMEAm8ivCgQE/SuErV7jizw/2ivF+OG5n15E5QvWtQo9Mo9cK847TW3E0Jj7RkM
 U69OPmrEt+O3PRkQL7a1kt5jDXta/Z+gHFugVuTB82fpo8gylCrrsjSWrwx8RJDQ9VC6OI/zH
 xqO9JfjZg31CN+RZslQB2YZ1k2Bi8HdoNyNnDa9O88tySGdol/p8wE7ebT4Go9nPDx/lVoZK3
 vG4+2F9hx54+NpXnlZjWIiGs7CGb8kt8itnVD1RX89Xxh7g8uzyUWrvQfC+ySrvJM4nh45KhR
 8XBFxXPOA6+4MXN7qV3iimtX/nBnPhO3Jo4XLT2XhGHnZL5iJXFCxWBreQY5ykv14MLxYz0pZ
 mQGn5wYndG5wNgYN/F54gphnrKdQPp/unk//a6AvtrbUuxAi2Wzi85fCNPZPTgUpRAMyV7hlU
 q4cJS0R5SPQTvQohOaZ7RqidKQO4Bl/VLzgz49DmrXw68MShbtWFw/lhUs5JKKPvDd4Y171gs
 VTm95dHCBcbI+i7DUX2Qg/PWUrZF5DdDcCIwkmryde+sNrsJASa+/p5exHwjwdPWmasMTpnWC
 I+Oj14y2VNmyYtfYwxJCiix/RSwXodPZYGNTPUROPJotDfDqZh6ZCehB3IQad8zn5E6VtSwUJ
 wU4+AD9Xb6hMpUqz+YJi5M73B6ITLeVUd6gRJHkWFla2IxH25I1fFKIfwvaK7j6qsw3fc9WXy
 q4B2+A27rSE3OMu/J2e8HcT4PrKxpk/sxp5ypCMr0bKvSdxXF41sV7HlMAXKo0CCM2QC2MO9o
 fRvl8GiCa/PjxHFsoygldU/njGZlCVLoaNY2Idl7r/4eZD8qzz0Qdzzc8HrIouxe6Ca7EehvA
 qvWe75yCwL+M5FQIhgkUbCINsiyhJOtbAJ5tjrEu3YcoSssFDpdnyOM0lTYIoD9dbHaIKqION
 C+QSQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 1 Aug 2019, Jeff King wrote:

> On Thu, Aug 01, 2019 at 01:05:12PM -0700, Junio C Hamano wrote:
>
> > * js/early-config-with-onbranch (2019-07-31) 1 commit
> >   (merged to 'next' on 2019-08-01 at 26b713c824)
> >  + config: work around bug with includeif:onbranch and early config
> >
> >  The recently added [includeif "onbranch:branch"] feature does not
> >  work well with an early config mechanism, as it attempts to find
> >  out what branch we are on before we even haven't located the git
> >  repository.  The inclusion during early config scan is ignored to
> >  work around this issue.
> >
> >  Will merge to 'master'.
>
> I had some open comments here on how the "do we have a repo" check is
> done, but I think what is committed here is functionally equivalent. I
> can pursue the NULL the_repository cleanups separately.

Right, I read that as "maybe later" comments, as that project is so
different from trying to fix the `onbranch` feature with regards to the
early config machinery.

Or did I misread and you want me to do anything about it before v2.23.0?

Ciao,
Dscho
