Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B24D72013E
	for <e@80x24.org>; Fri,  3 Mar 2017 02:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbdCCCZN (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 21:25:13 -0500
Received: from mout.gmx.net ([212.227.17.20]:50457 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751409AbdCCCZL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 21:25:11 -0500
Received: from virtualbox ([89.204.153.4]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4kfR-1cMamX2RQr-00yvF6; Fri, 03
 Mar 2017 03:17:32 +0100
Date:   Fri, 3 Mar 2017 03:17:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
In-Reply-To: <xmqqinnrd098.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703030315580.3767@virtualbox>
References: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de> <20170302105157.59791-1-larsxschneider@gmail.com> <alpine.DEB.2.20.1703021210170.3767@virtualbox> <CFA1C4B4-0FDA-424D-87A4-EEE1F9BB3712@gmail.com>
 <xmqqinnrd098.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:84imlS2pom/ZyTESj76WWPcAurPtKdzopUArhGu9fOlpsFk3uiw
 7WNsjLBp5iOwacdHn0vRRcYR4hkjBRBhULpEqaK6PgtkiAKzAx9E9L8g2JbtQZELhNqIClO
 pg4Ql3fd4RuYC7Q8xQo99M9YaTT+2a7SiJTZUVizV9x8vbgNKFBV0x1wjYJ1Jpqu6p004hl
 vGfJLUVEipbFkphxtBXvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9YSK10k0LdI=:2VTmfnv/1O4eztSq+fz17C
 9M1QivZRfwLDNar7Tm9IXNxF/sHoYWR/rdB+BEFTY50drtrxWk33FpCZ8US3QehdWh86POOuI
 s/at3Ow47wNw0U+VoFFTdgyH4snsH0N9wVwklfyZa1ARQZfSri+wY1JJZQCt724eYSEQq1hkd
 whb1Ww2/Zh4b2vmj4O+rSd5ctHPJUBW2Xpl48UZaofUbrrQURor2/VVgIOoklumT0b7Y5qe8D
 35j94xiXA4bV3H0HH8PTpripwk2F1kn8bUh6snmYavdWAnb62LMLjUXD9psK5qcNmJQyRE4CO
 maadi084Q3+YCwp0aGkPN1O/QoS72wFTbhSY77VXsOtGNXmPqcN8LiHkauTIgokDwgVNruce8
 rWUVl4CTHaQNmrrk7gfHfe40UdIncUrT1J4C/oMlSIPo8N+/sKcSeBmvmVVqC8APsC1L7YPx9
 aQAV5UfcJmIRseNun3xisVjpqEeVdSycyNs1gdqh1dL3Nu0915f4VEkrLwyTZudlxHyaBqM8n
 wGZFxTjJ968KEs1NkQzYx4ARQShmYclyw0Gky4VDAkM1VTp1QFloCXqJMG6vHNIQRnmQXAuCX
 5zBs/ZdP+Jy/yy91oX5CrOqf2RpHhyMI8qMYbD5ELOIdYWcpkJ0s+WyrwrNzFv8b/pvUvKhmC
 wENvbsUzf071Y36I9Hqs4SyYrb6VQ81LnG4fFNM76ye2pQeUs9PWuMvgXuTu2yB7Ib7n96FK7
 z3LIhtET8W/pMHh1uj+In4leg8PGfn8SoFCLcPKOgqnAPkqZv06DtvweK9LOMmFbakugCdwzW
 7ofUF52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 2 Mar 2017, Junio C Hamano wrote:

> Another question is which v3 people mean in the discussion, when you
> and Dscho work on improvements at the same time and each post the
> "next" version marked as "v3", and they comment on one of them?

But then, Lars & I communicate in a more direct way than the mailing list
when discussing teeny tiny details such as: "could you have a look at my
mail" or "how would you change .travis.yml to do XYZ".

With that level of communication, there is almost no danger of two v3s.

Ciao,
Johannes
