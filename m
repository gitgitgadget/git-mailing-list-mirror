Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 006B21F461
	for <e@80x24.org>; Fri, 28 Jun 2019 12:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfF1MxI (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 08:53:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:49385 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfF1MxH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 08:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561726383;
        bh=bqv2qFkPSya1MncmNFRtT2wfQ7pLs6ILVSzZqAV/flQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OoIfT+R6rPol5FPa1aHMOq0XWm/U7nNYF5YRWu94Et2ajvQpKdXk6VRKYjSzALMY7
         pXfQkMSrRwnF/ljnNjq60H1CyjKn1x8SBckm8z6FMnia3xaHHI3fuADkMPLljKkk+G
         Gl/6ytgA3Vs5ZxCYFm6WjkzdgC884tP5MlkiLgyA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEFvj-1hoqa20HOH-00ACDp; Fri, 28
 Jun 2019 14:53:03 +0200
Date:   Fri, 28 Jun 2019 14:53:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/6] easy bulk commit creation in tests
In-Reply-To: <20190628093751.GA3569@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1906281452251.44@tvgsbejvaqbjf.bet>
References: <49d98293-9f0b-44e9-cb07-d6b7ac791eb6@gmail.com> <14689d27-eecd-2e0a-715d-796b20d573e5@gmail.com> <20190628064103.GA19777@sigill.intra.peff.net> <20190628093751.GA3569@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JRg/vhxA13uA1MrgrkQxHbslBM39lcF5Js1BXyVbVSysE3Yqku3
 G1ti8WTfFSbE/cxV6p2gTbwroh0utygSGKMq1cFg3F2/si/gqW63HLvK68C6dI78Z5L5KGW
 789RQsZsBU2Puead9/mrvVqgAZuNnrM3bMfp/Orw6Jf158c+XL8UDnbC3R4vsTu6B/4OTbE
 UOmFVHsd0bDRcUHLC9tmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L3GoZnVBs5U=:DR4d4dkTq/62w+ntD6cqPT
 aSYPKV5IGqGGjnOZAtlhLS1GVKIX8eKmd6VE95bEabFfWSTJh7RK0Pv+3d+SxAc1b8f42bRX7
 HXbKkuIW+pmyafwiQehyV+q3H3jU3Cifq/KQpX1XzyLFZBK2qBWzpICIqXGAmRYaBJb4O6GUm
 EE8bfliwDsRWAVr0WeIsUtkAu28+oSGWfL5uTbjDRhxhb0gw9VXzWTQbVcaXmdQqies93U1GY
 ueu/5q9WKoPkGkgh1QXLXL5TyRIezKnTndmZ6B9vsPmV5KsJHiz2ueXQ8eR+o8NpRuezzvZV4
 MBba83RSv1tGWstoW4AWrcKQmf8YH4F5l1ZjBaqaTdN8IM7L3uu1ZExPLp+e5wZimSjBgKiuV
 I6Y5dCSpztFL3D5KflUp/EaNQqoJugT4QcJSiWCCVcjF1E+YNGeChYHxVRMDNbnJVY4NogMvp
 mJVQ37HnSY8TzF+yLvJQF9viG3bPDL7jja3iEaDydijYv629vnRPLdV53dQ4ehzwpYSiFnAwS
 nW+bLbXJuGoumJ+6uXsi13yU3kVR4lHpri7Fs0yPxM+Vgnquy0XSycrVAkPjgEft7+4d6XE+9
 2GtY9Dtt7RZvLYwyGhhPGIVf4WmAxFDNAyHV8mlkqapg1cRubEs7C2aawBU2WCJQRkGGxiUsL
 OHmzyRB6PLVqipJ8GpXHXxY5TayIkb5MegrQNpdADIx28f4Gp/QSqX0tlI1xAO/Dp9zYgH/6h
 dZFCo1fOBdwppmPQVgA2SmC93eHoUwZ6KEwVQeskko94N2d5/6Ce9vrma6iXTSaq7ZinHlSTG
 dZhGVKpfe/v5Fu4MGfOlsJL1twYlmrT0cYKqt3H6FfqHHQyo2Uo7ZGE6Kjf/11Ibms9NfLh5x
 32Cy4AZNzkcrTZpo8TmOIN8THt4Z3QOXV266V7kno1vtnb3uORI7x27p/Y2SyE5K5f4+swgoG
 yUbKIONOHtmu9eVjfXXUm/y9M9rxksDrKlV2XYom7FlVX6gnxm9Gn8nQCV/LhbhULTNKm1Oez
 68mctKLHKmyObotDoniH8+2kxdH/jYYwE5CONzSe2YTAMNuz5yqK1AlEsGSaUEvb/jiwuHX3B
 QddS/15hvYHqeNg6W+lmJ5i99snKU2kDvrS
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 28 Jun 2019, Jeff King wrote:

> On Fri, Jun 28, 2019 at 02:41:03AM -0400, Jeff King wrote:
>
> > It would be nice if we had a "test_commits_bulk" that used fast-import
> > to create larger numbers of commits.
>
> So here's a patch to do that.

I like the direction, especially because it would make it super easy to go
one step further that would probably make a huge difference on Windows: to
move `test_commit_bulk` to `test-tool commit-bulk`.

Thanks,
Dscho
