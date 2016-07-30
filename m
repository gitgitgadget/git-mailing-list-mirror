Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BF771F858
	for <e@80x24.org>; Sat, 30 Jul 2016 08:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbcG3ILs (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 04:11:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:57416 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831AbcG3ILo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 04:11:44 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MFR2O-1bWh940C4C-00ELUs; Sat, 30 Jul 2016 10:11:38
 +0200
Date:	Sat, 30 Jul 2016 10:11:36 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t4130: work around Windows limitation
In-Reply-To: <CAPc5daW10y_5rat0Au-1NWXUf2QYFrDfQeprqq9NsYPBjdqOTw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607301011140.11824@virtualbox>
References: <5bd59ca2f87e388350f3c8fb17c9a287661cd055.1469623136.git.johannes.schindelin@gmx.de> <9d167448-84ce-e368-0bb4-41aa4452268d@kdbg.org> <CAPc5daW10y_5rat0Au-1NWXUf2QYFrDfQeprqq9NsYPBjdqOTw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jFTKdo0vTwMo/Xi0gcdl4iWala1dtoETBbnMoaAeBaSHN4hqnZG
 VVmhVM22fTLnhlChbp1RwbrJVzumvef0K+Ha1C/Wa63hFoo1o08ibPJyWeWMMaJFijqb2hs
 7F+NcXLiF+2ttiR2FxB3ytMxBVFyBe2hRSz80oH/U4Xd1GB4FilLj/tm5JLiEYfxX7bWZPR
 M0sxvtUW+XzFb5mW9mFIA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:T1Zqg1yz750=:xbLzjpdAsFVgr/Z6/wd7S9
 oIK93Xajhyv/6BiKvc9XHSkuZrtyjNz32o4iRaK0NJeZamNskUfsggINe1Al5U1poJq0eWBuk
 xppZ+aywF+hgzqFwG429uKcGmUBRxRy39OsRfWLIFVdfsix64UQH2dFIwCJoA7fUNOxM3JDKb
 dVQ5DO4cXf7dBKgUDmECC36xydevSWgzAfBhjXZTWX0qhgdiQ5NAkfd4Zmbn+mk/W/UGX9ZyV
 5VKvKQ6V0Kz5GtimBC6Lz3WHYmhuL2uuGHk/Vfz46ixubxfhecxCrAEJ/E6DwCyKxYuLCty1w
 9YeL38nfTv2NsnGtdQto1gM6AMAOM/etzRCifuWKlgCekBMJHq/1tlua00qGXyPXe1PtduQtr
 4NnZEsZ9yPC6uzR+7nRq9cDgiL/Kp8pDTGc6Lh8WX+k9XBLBiG0QCD6Cs23H4ddWCOF94S9zC
 ZB+0s6olv8lscj8dRmWRTDcCCckz2qvbh1tt4IqhOBmaD/w+ezsRkiwYdcH4f+coDp3X7FEZv
 hpruzXc96VCF9MAx7bVfM8l9hSMMI4gI3RDda+zYsdbW1WplhKsCiHSM/FVrfh/07Pb8euXzb
 ulogixPAA1t17CKrO+/UxJhVx8RqxIuJz7l/uvNhrOd3d7NK2B32Nq6NozKKDgsCAyPTwvJH2
 vXlLYTT7NjCtxqiGbA9VJsUxdeUrSQhl+m7O1swomRLYMI3sWktDDcArahkEB2xiS8bEChhsE
 f+IXz1/Si9jBoATUEqcdZ60yFW/LEsB6OThIDRmP5XRwMHZYD6a0jsDn85gAphX+hXJMtrpV1
 T6aEOeQ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Wed, 27 Jul 2016, Junio C Hamano wrote:

> On Wed, Jul 27, 2016 at 9:37 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> >
> > How about this instead? It makes the sizes of the files different,
> > which is a bit less obscure, IMHO.
> > ...
> > Equal file sizes are not crucial for the test cases, however.
> 
> That does sounds like a better solution.

Fine by me.

Thanks,
Dscho
