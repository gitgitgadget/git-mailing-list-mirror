Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81CDA20984
	for <e@80x24.org>; Mon, 12 Sep 2016 08:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757255AbcILIXp (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 04:23:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:63170 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757237AbcILIXl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 04:23:41 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MHX0m-1bkSzN3HvI-003R3E; Mon, 12 Sep 2016 10:23:29
 +0200
Date:   Mon, 12 Sep 2016 10:23:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 20/25] sequencer: left-trim lines read from the
 script
In-Reply-To: <xmqqsht657ls.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609121019290.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de> <09e05e7ac23164625f2076ff06d2b034101878da.1473590966.git.johannes.schindelin@gmx.de> <xmqqsht657ls.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QJ7IkDvKJ3H3S//Ff/pmeZMIjOOW3weMyYM1Myghl0cXijDjOIl
 yfZWCGTcFMKwfpxCc8i65FDFsXoXPMecg0fjhm6GJB20qTfmQ9NeD+jOLo8ht/zJ2ODnyQk
 mewPcY9ARCqzyt89+7ubujdKtvy4FEuvg/D4BBwjBGxedY6pEYhag0t8hsO4Gm+c2vVaw3b
 zd95JsLig7miaVN4CtbXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CvDcJuCsArg=:K8Fw+N3lfgmAQIZ2Elsrtr
 BWFm7CdOnTo38fDFG1CoCQdvzcTcCEDnCYo1sy7wr0Ac21KGJDkWSBlmjX8XOCN3vHYUQuQ/f
 gpOYvReKXTvigKMMakgS/zhPy1ldnP8cymwa2GgKpgno0oZgHDOQtwNqzd8W3nLMgAKMbjWxk
 N26eIOP6U9UAG29Zs57M23kWKEv2eslmGKnf8zZ0bSm+krj3EhLO/TsodUpdxEO2TxLVch2m3
 KmY0Bn3PdZFufBBkIcQXMOQ5Ux3Fm6OCw2eyw/oyQvdbIbIUr5GXF9XEG9xMfhcN/mdUouxla
 vVjEtElCw+CRDqR8loMPZCmSrInACtNVR9zqW28J8BaPeQv+ZLnQ00rjBO5P0I0YpqTyDYtso
 fRk0+cDmBzQdWy0jc8etcKSnrVJAHPOnBcJqwbMefhD6EA2H+8J6F0XcsT+ihAkKLP19tCQF9
 vfrHIL+x25mViZBbAHVvM7gKZpXHtfLDrOWZDr5sxgxUSXVo9vY5n5C3yFkFkfqkrcju2wTxN
 6GqzfqQFdjv6h4aj6N4uaMl2d50l4suDf1M8QKwrYdxeFBDIQfPd/p/2DwqpPbq+8jDmQ90nL
 N82OGimjNxAoIEgZdb9qS5AG+OT0+TyNpswzP2n2Tk+zBzBA+Tbw9EteCQ4BknoljeiGPFzCf
 PbHUrumfnQuZqkh53QMW8vOJVZy1Quehks/qAuWNKP9kk97SekDCyzYgDULpbtoZrFD6g9mEF
 ywh/O4k7uCCS1dC8LfUKVBOISPrSFMFnF6V9QSnjzuWgnY1Gc+RbYn/FOywzuacwugsBiLPWJ
 O6HJALk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 11 Sep 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Interactive rebase's scripts may be indented; we need to handle this
> > case, too, now that we prepare the sequencer to process interactive
> > rebases.
> 
> Hmph, have we ever given the sequencer instructions indented to the
> user to edit?

No.

We also never provide the user with an indented todo script in the
sequencer. Yet we still parse it. Because Postel's Law.

> I do not offhand see why we want to be lenient here,
> especially only to the left.

Postel's Law.

We do not care about the right: that's only comments (onelines, for the
users' pleasure).

Ciao,
Dscho
