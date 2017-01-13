Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E28FA20756
	for <e@80x24.org>; Fri, 13 Jan 2017 15:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbdAMP1y (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 10:27:54 -0500
Received: from mout.gmx.net ([212.227.15.18]:50769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751528AbdAMP1x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 10:27:53 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LtaDM-1cbip92XEC-010xdh; Fri, 13
 Jan 2017 16:27:11 +0100
Date:   Fri, 13 Jan 2017 16:27:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Wong <e@80x24.org>
cc:     Pat Pannuto <pat.pannuto@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] Use 'env' to find perl instead of fixed path
In-Reply-To: <20170113024842.GA20572@starla>
Message-ID: <alpine.DEB.2.20.1701131626160.3469@virtualbox>
References: <20170112055140.29877-1-pat.pannuto@gmail.com> <20170112055140.29877-3-pat.pannuto@gmail.com> <6fe462dd-929a-671b-a210-36ee38e99115@kdbg.org> <CAAnLKaGbf9-GAF19+61=7_RfCOBM0=Ounwf8KkL1jS6HX3pOag@mail.gmail.com> <alpine.DEB.2.20.1701121118170.3469@virtualbox>
 <xmqqbmvcj9le.fsf@gitster.mtv.corp.google.com> <CAAnLKaGvz4Wzs36gMSdoYCg+tzx6KFCe59FNnk5zNQ-L58ww1g@mail.gmail.com> <20170113024842.GA20572@starla>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nloSggi1iStgXS0xB4hqQm/Q9yMKSBnPolClkpZxWI67zwu8kJz
 i7SIFvjnwFbxhBBTFrnyVRz1le+0L616YNHxnPOb1Y4n5iObVvgaSU4jPmLW6us4d9hqqh8
 msrqdpy+rQul/6afRmNvxWC91mqU7RLE9HN0h3c4IpjHnAilDl3oKIB248fNJsSTOiQPqhR
 qoaNIoR8rHcMnrecR0qaw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PtR0zblywVk=:10OaB+CkVJqfJNe4hR9UMZ
 aOsTe5A+SA1ckfIgh/YVe9zcuCYwH3JGldyVvNbgb0pCO/YvnGORdvNPLKSpXVXDp4Fu1J3CM
 agm7E36RDJG+dssrAiRZ21SZUrzyP0zHGt42t3n6R7eMku3odKW1cWOBoYnvMYZss/aMIcq5G
 97XAH5fgnY+zjVaxlpERPdsc1g0SqV9Oe8PACeiyEwpizB55crSaX5bMAaQdxJk0HLSF0kI8G
 c5whdOiAQx3m5X2VAhMzcWq+Gz4AqemR0tIaOt7mztF16vPwJHeDkMQOPYMWQ0IJbAyALIreb
 dDgtFPLkv76QXnEOWKuhRDRPZVX1dnK+bqqOVat5jjIqgfcI+me2ix2YKjFB90N2UsRzeygxt
 pke2zZXMu83GxrKutndBq/YXiPX7tMbTy3KlB+v3q8ig2xRqv0jp6ikqig6Z5xVnnBe1keBd5
 ZUU8qZa6Vaey3uJOrMq7nBOozJosPckzrPqOdmCcgucNsanm+ZYulO/bpdIZ2ww4O9ylBYPrS
 lxAFpYdkyTQiCNoOz7GQ64eAZsfBw9Rd+u8uWMCLVbteGg4kFMzf87VTvJN2WMeP1MSDWDQeT
 yCkwGWiWNYm5gnceLii/Bet+pXnClpJArVcTFUjbpb9mVhl4FBsbwYYGQHSPhfYOlgtsSVclA
 eG7GhWcPSw8E5hsrDiCkOTm40LiggCd/FX+NYkGOibqtfapNj3hLc34CgQSgwY/T2/10A5jEW
 23hEUV413rVwfyPd5ZP0eZAVepzcf7MBLc/2pqnVsqvRNjdW1hlD9Jt1ae98rZO7JKKV/jW01
 bNnnrSl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, 13 Jan 2017, Eric Wong wrote:

> Pat Pannuto <pat.pannuto@gmail.com> wrote:
> > You may still want the 1/2 patch in this series, just to make things
> > internally consistent with "-w" vs "use warnings;" inside git's perl
> > scripts.
> 
> No, that is a step back.  "-w" affects the entire process, so it
> spots more potential problems.

I guess I do not understand, still, what the difference is between using
-w and adding `use warnings` *very early* in the script... Could you give
an example where it makes a difference?

Ciao,
Dscho
