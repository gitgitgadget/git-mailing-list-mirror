Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15FD61F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 06:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932584AbcIHG5b (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 02:57:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:59255 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932500AbcIHG5a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 02:57:30 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MBVwM-1bsNPB3Wys-00AXaN; Thu, 08 Sep 2016 08:57:24
 +0200
Date:   Thu, 8 Sep 2016 08:57:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ralf Thielow <ralf.thielow@gmail.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug? ran into a "fatal" using interactive rebase
In-Reply-To: <CAN0XMOL7LEcJAHhmSwq8QWH7mD7+jQXRkAdQA+3hZ2JQUJ99Gw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1609080856290.129229@virtualbox>
References: <CAN0XMO+ZOV3M02wJ_=oMPbN4ch-=7gA_pXEegfHApvSNeOu3KA@mail.gmail.com> <alpine.DEB.2.20.1609071714540.129229@virtualbox> <CAN0XMOL7LEcJAHhmSwq8QWH7mD7+jQXRkAdQA+3hZ2JQUJ99Gw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lVnsxsPhdRurTPmaY/xeFmDa+bB5hG8jWO5S4I+muHqwzKv5TEN
 zDadS0oMl2JGRUN9veBG9VmkUtRBwSZXVFbjd6d00ddLdD1F7INasSsvgKyH1Fn5IC4hk0o
 8VpcpHTLZkN4tyqIJOpCwVB8tWnuMoIaW1cng91LxnKqhYy7GD6p1BHrlQv3x7D2Nci5hBl
 ez6SZ46pHRsz9yZK76e+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kOdrUuCtBZw=:hYAAypMV8YIe9x+2xI9VqR
 cyxbI9huKQWXTtxFrZa3M6DKtmlU1LPC5p/CwDu35yux3hF/mdfd5V7+MtVKFzoFXqOG06xi1
 VbXdAMUFqkcs/PmIPL6obQFk/vDuMkccuQR4Dp1zoVYAAe27N3JiDyY0HratKBkly2+47TSUI
 n6ZsoClyE/fpFDp5H8r8Zxq3EayaXHVznA2GxcWH/B8NWcCy8pxiCiAFXtNnQZvBfhhQC6bDC
 l/cuBkpS/8ROJkHYQx8Pt3zKCeAbMXz3WDZhWA4Su2weUPbmsiFh3VAamKSx8Aj05cHvQ/zTc
 7EQAL2eqtLHvdvnBr+mr9bhlfKaa8b59tsQMMeskW8wRcwxgH4bOb4nDaVXirQxPZHyYqO/Cj
 PPf5KSIoCWQTNzW3yQ/aFWAb4ufNEWN15rEZqXNK0fLURaA9m7brqpCSfaX/kuiQgYRisjXD8
 +ydMUe+imcMFuM6aqVrcVkhv57TUJsH2bV7056AIv0aWTe+QpnGYCB0SjrVnsZaiN7/5RzXAV
 SIHjrZKjczkm3nsbXHA0LiAo9vQ876ALVSBBhl92qwpcgCG5xQI+9yXTI25tnbDLJsuIuCKVd
 sl/jb80489aB3xD6Q1zbSD7C61OM6Mxn/PMG/kNOuR+teAdbDqtWjGIRJExCbxjpg8REfsRji
 +ogKA+2mBZ7zmfUPKk0f7VTJGssU2Kop8HR9pmN3kvGimXqWah5JC4I5BWGv+PEXNcX65Pg1b
 TN5JdA6ujg9q+8qhXUrD8y/BhEfvksIr2EiP6qrhoGgemdWbDOARCLrZ4ZY0vY6OCLBHSJxZr
 JXGtp9d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ralf,

On Wed, 7 Sep 2016, Ralf Thielow wrote:

> 2016-09-07 17:19 GMT+02:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> >
> > So, something like this should help (if you are interested in seeing this
> > patch included, please run with it, as I am running short on time):

What I meant is: could you craft a test, a proper commit message, and
submit it? I will be mostly offline during the second half of September
and have many other things to take care of right now.

Thanks,
Dscho
