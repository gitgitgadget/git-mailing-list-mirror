Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B943A1F406
	for <e@80x24.org>; Fri, 22 Dec 2017 17:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756201AbdLVRUj (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 12:20:39 -0500
Received: from mout.gmx.net ([212.227.15.15]:50480 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756131AbdLVRUj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 12:20:39 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LsChr-1f7Z1D2RyB-013ukk; Fri, 22
 Dec 2017 18:20:32 +0100
Date:   Fri, 22 Dec 2017 18:20:31 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     "phillip.wood@talktalk.net" <phillip.wood@talktalk.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH] sequencer: assign only free()able strings to gpg_sign
In-Reply-To: <17655681.1077671513947507373.JavaMail.defaultUser@defaultHost>
Message-ID: <alpine.DEB.2.21.1.1712221817470.406@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <f4420880aa4ee73b7c8e435de1efccf9a969fd41.1513943347.git.johannes.schindelin@gmx.de> <17655681.1077671513947507373.JavaMail.defaultUser@defaultHost>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GR6khb3sT647+QsmRWJktXTWjumhlrew9GHfWp0rV4S1Ew9n3fT
 fFjipEtL4Im5YSmO5v1Tls5Qya/TR05TedIAjuniN7f0h7uOjItCxMSAnmjYrQKPI4asS/9
 UhXW5KDkGAA/TkXaO4ytUcVZySbQ5OmRkHUhQ3D1rjLZciC079uef5b1sgpYwiGMCo8HA5K
 SAFKlFrjNhewlie+yMlZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IQ8DIBJUmwo=:Ka+AmGbUcpT/efBi35X4Os
 kGcv1gdiXXQDZk5Y1VHZkGfQKOte/c/z1a1b5mDizFxu69HPqmj2C87eI3lomA/03QyNlhN6q
 VuhBw40w6JpX8EyR9qtTyNy92W8+GA1tecxTvOkkSa3N7JBkmSN2/f2EPLVhLzlDh0xjNi6HY
 gYEIIY2vVDnQJosZaF743PINWVoPYm7988CdI2/o8Uq5jTm+vTl5QimLq8tQBR/J5NjRVeto7
 YwiZ6E9TNwisvxEajXKXLpwb7ehIIyDQQIs/LZZkIVF2x33JzrVL8ACctpTRyTf+jigE7iHhi
 Yk4SParflAhsqn1fgiBk1NwzSLl4HR1V3+qOHOMweur7mbsAJ130b6SKGSnJcBwGTuDCkUqBq
 pXCANmPvmOkUyhtE+8GGNiuRfHqTLnsIwsXRPcSrDumRHaGD7dreMCdPDOpgvCwUpX+w67nGs
 mGFf3acKEXXVE0xzsKK7C05EcaIjxoo6XOilSsbtZgpVtaUAS4k0qO5v0Sr7xFRC24gE3ohep
 rxTNnsDOZazVg7XGybbLX+tNe1hEWi/uubIIU/8VyVjApn70IGAWFBFksSTp78SadPiduU/Bc
 RfmfeZJJW5nBcVIzpfqTDNJIVI7VHh5PW215PZyPKv+ieu2ZRpPdMJcueVyx99+RPI/NXTl0h
 pUI+gnnGdkuClFG9J0UHOl08r6lKKo+paHvLvP6pdqGCpUl23NZTmXryU5CT4JFJLpVSn7ESh
 w3Lig1dcKXNm9rHRXYLqChulSoR8RH1Yo1om62GdWTdzpumkVRpyDt7+79pyhMx5p8edE4naK
 QOzZVDuuoA1vmdLrXRMyAphulAL0lxMPjvv2o4Q06dptOWLSfM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 22 Dec 2017, phillip.wood@talktalk.net wrote:

> I thought the bug could be triggered when commit.gpgsign was true and 
> it was not overriden on the commandline, is it worth adding a test for 
> that?

Everybody working with extensive test suites seems to write/blog these
days that you have to be careful to test meaningfully, i.e. you need to
avoid making running the test suite so expensive that developers start to
avoid running it.

In that light, what do we want to test? If we want to verify that the
gpg_sign is correctly allocated before it is free()d, then the test case I
added *already* covers it, and another test case would only increase the
runtime of the test suite (which, as I hinted above, I deem a bad thing).

So I'm really in favor of keeping the tests concise.

Ciao,
Dscho
