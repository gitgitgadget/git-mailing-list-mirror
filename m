Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C59EE20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 20:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754652AbdASUkZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 15:40:25 -0500
Received: from mout.gmx.net ([212.227.17.22]:57111 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751012AbdASUis (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 15:38:48 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsgvV-1cNcR30cHp-012L2J; Thu, 19
 Jan 2017 21:32:04 +0100
Date:   Thu, 19 Jan 2017 21:32:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: Re: [PATCH v5 3/3] Retire the scripted difftool
In-Reply-To: <xmqqlgu72asr.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701192131300.3469@virtualbox>
References: <cover.1483373635.git.johannes.schindelin@gmx.de>        <cover.1484668473.git.johannes.schindelin@gmx.de>        <8238bba389c031b091a37396fed43cac94d944e7.1484668473.git.johannes.schindelin@gmx.de>        <xmqqk29tcqb8.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701181332230.3469@virtualbox>        <xmqqbmv49o3s.fsf@gitster.mtv.corp.google.com>        <alpine.DEB.2.20.1701191730040.3469@virtualbox> <xmqqlgu72asr.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:OcOLdv0noBdtzWN+H1GqRxSkNDqb7cwwGPIuMdWEYbYfj/9ZXxR
 KqQP6dnB1X4ToNq/MltKI2iBWHDvXFksW1SmJZYj9bmPqkmR87pBe274U57zCH4RUwy4zHq
 B7wJMv4k6B+gdI0IsGSZtsYC12I68hRzUhvW3+wWyIGcgmwBTsYPFjD+bx5/kjOp5NMkIWT
 MzOgmSdgIDDNOoW67zKnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EJ8NL1BB7J4=:159znpL7MYIhdDY4pcm+VP
 hqwhcWArmFHfQCPuVcujXZPwff9ddO6y3D5MNMbOv4FMSggqkK2XcZP2ciXCu4EuWux1zZLdH
 LHtMuKJJNS6NvfWiReVg1uBxw0VFSAYa6agAH0aBlaHy8SWECeexBJ8atdBqy0RvfsHxoFpCT
 0ltbGF7efyTMUFNSt7q/3HcfY4KG39qQwaiqGroyWenAe4glT3A+zCuqRATBd/tBJL2OXshLS
 0S54B6puOAv4HlA72MknZ3A8GzQ9coWGHRo9PAhsBYu8S0Kvk2SGG2FzrrHZ3sVwKw8BiQ39o
 xu+NMZWE23rGIFOccb4uWhDJXP6PfGaJ8GFKsIbOapWM0/iSVcgL8dLAcZ76jGc4uyQ/CJUkI
 IkqaAGd0MWbBFFLrZJmvdYlOUSDwqoXDNd4MnL/YUd87vnUCFJcOkzEi94/x48tgo+KURhy+n
 6JNeFqJsGTLgED7ycW9WZdBtPOGqT33f7LdXWcw5UrWpyFIsn4zS2FE1tRFzKEJU9kpT4/QeA
 AfmFpDSaY8CzSG6oLC3yq4fT+9ixiv+z38JpNcIdIQGleLtPchQ+CYVh7Nx/zFqLj6cC1twH+
 h4QTX35jhtLbHbr4iNPWoNXVuOcZz2naEZhbPMVWCCp63rX1ieIqRCVY+PZUgzngAvYNMr14U
 LglfPtsPMfz1v9Hd8IyqHFAgIGaSUBOOUt/RYr4exOR+0QxAXXusRF2sOO9B4gUNhRH2cv7LH
 fXojOU5y0pE7ZAB/Ab4WygVvl4//eqbX86iN6+DUp1UWjaQuzj7fCtivSMh7jA41DOA2PTEkF
 vC5xc9h5tUlq96Ea5hl2Lr/qHQDSeNnQIb0i8Yokm1U59zWRrwfhz98Pg8DE7URZ8IoT0zIxq
 GG+9P+kQkmESimN3lMHUdWeMzE7alUL8nRLSZDayoE/ppxqKLVu2LwflZbwrhMH2daMBp9HWC
 Cbq0DS0oGg76jPN7+qg6yp6Yg5Vb0fIZ3NJcd7z21Zno+zKYmwJ4iatWFx6i0+xjAso9ldrvl
 Wym6NHBjjBvwt978Ouf8QJdOMtQW8xKjL5MvXVmn8NPCdjcFSrYR2ivVtnpoAOryaw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 19 Jan 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Yep, as Git for Windows v2.11.0 is yesteryear's news, it was probably
> > obvious to you that I simply failed to spot and fix that oversight.
> 
> OK, if you want to tweak log message of either 2/3 or 3/3 to correct,
> there is still time, as they are still outside 'next'.  

Sent out v6 with the commit message reworded.

Ciao,
Johannes
