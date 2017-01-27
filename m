Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 218CF1F437
	for <e@80x24.org>; Fri, 27 Jan 2017 15:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933090AbdA0Pnq (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 10:43:46 -0500
Received: from mout.web.de ([212.227.15.3]:54173 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933072AbdA0Pls (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 10:41:48 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPY5x-1cbHMa3gdF-004gJj; Fri, 27
 Jan 2017 16:39:49 +0100
Subject: Re: [PATCH 2/2] use absolute_pathdup()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <d94d742d-1247-ac35-c081-7db1f2178d34@web.de>
 <d15fdbb9-2a21-eeab-1fee-4a1553bd3bcb@web.de>
 <alpine.DEB.2.20.1701271121120.3469@virtualbox>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0555c0aa-fcb4-19fb-a533-c451e1e477e3@web.de>
Date:   Fri, 27 Jan 2017 16:39:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1701271121120.3469@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:VWOGQS3v53utuOSIZCfyXRuxZ2zlgE8hZxb17OKTOindkyaoZxR
 aEoGNsPijwZJ1h3hkg+r5s/CeViJAjCcWODNIn4Hk+s0r/1rjmeyZTih8Cv7nd6jiKPvIsr
 D5TZ6ZYNOQxQy1FeDwyaALjQ+bmnj9hqkAXf0K3Tz6B13y2cVx8dsyYJHi+OzjyZCL1hbXs
 +kIYt/AIIG7kPeNlRxzag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e641s9k3/kE=:hv6E1BOoG7RaVIlx2ftCav
 LZUbyB6DRQwR0GKZxshA7wOhsD9fKHyPmm0VDV3k646xAG+z+RDouhKe1XHj2QzKcfvDF8tes
 vfmtuNhGsVylMXo3RG3ezVlC//yFj3mZyMgXYWw7JCiR0Uvo+9HVbZO/yv0276h4gY+HmC9QY
 q2XRTm3V2Tq/uGE3tMQMepyWoydL6Vnfxu8LVzkE1jAs8eHlZn2UoHyyNM8dVAd2HBsIfNicp
 UspRdY2nTU4V019+jHsbDEN/r30Jm++mn2nRrAkFUEEKZfgta0BY7rqrcupvLDyyvjK/qO40o
 Igyquf/PB90HPy6oLja6wy7s81v1YfiA1jPWKjSCRGhF58KEEjhcohF3xr5HpZEEXKgdpbF1j
 OPD6DUej5DTe5dDP6EFVKjQv3Jp5XAc7NPvoGXIELH8x9ZhPETWF3UmC19X2Hd+mHtPNex5ou
 BkyAKdACBDvXkn9SPvW551Llv76Gl+lomzq2s15M2PeuhZcLkg/FNETG1JlBf/OyRlWJiDB/v
 vXhJZ7gwc7FRXlgMRM6q5okp9s7wvG+zULeveVt78UR61vS0UmFWX/EvfvVrI8K5SAIrLVCW5
 Z3/BQ8guwouOi53bOyRXH0gCiGZwIdOk/VBFaQZHZkixJ3rCqBF48YXt7fdBIH2r1Xocl1DqR
 1SoqqDBSzeU3W7lS/XjFL6Zeeh2ZD11rKQOeHDlvazt9y55vK5LH3eWEjtXyAz4q8LvOrQaau
 f38MEVdgZ5CSan7HxqW8GNDJ+TcDEHFttlH5zi8yRFcitKSkNExx6AVoHCAlfnbtqRxop2nDN
 ghB+iIU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Am 27.01.2017 um 11:21 schrieb Johannes Schindelin:
> On Thu, 26 Jan 2017, René Scharfe wrote:
>> Apply the symantic patch for converting callers that duplicate the
>
> s/symantic/semantic/

thank you!  I wonder where this came from.  And where my spellchecker 
went without as much as a farewell.  Reinstalled it now..

René
