Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AE3C20248
	for <e@80x24.org>; Wed, 13 Mar 2019 22:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfCMWR5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 18:17:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:57273 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbfCMWR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 18:17:56 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXVr0-1halqq3WCc-00WVBu; Wed, 13
 Mar 2019 23:17:50 +0100
Date:   Wed, 13 Mar 2019 23:17:50 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v1 09/11] t: add tests for restore
In-Reply-To: <CACsJy8Ce3Sn7sWDOqGPeOk7JiXg+3KSaox4PFZxfh90B6E81_Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903132316220.41@tvgsbejvaqbjf.bet>
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-10-pclouds@gmail.com> <nycvar.QRO.7.76.6.1903131005180.41@tvgsbejvaqbjf.bet> <CACsJy8Ce3Sn7sWDOqGPeOk7JiXg+3KSaox4PFZxfh90B6E81_Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:U+mi+C3zRfyrfjbR2ZD8yWFVrFaSPAAW6Cnd6WUIo6KMrqsA0lU
 YvXU9844pNd5WSwDGhJNtp6PNPzxRJQaZkEMcFtz3h6wwXtHgmZ269F/RnZqmDiYj61Hhni
 7vdv6gUqSQg9wzYE9lz/BD5NAuqlsE8a+Ot1hIdxoAWCN/QjbEp677rTDEBypE67P86TJcs
 ga8GVyhV7pKf4w3K0Ij5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ir+nDj8joKA=:Ijo/CAzTAzDbkk9MKfYzPx
 XxhGudCnQYVyv9QgM8NdAW+Lvb8LoysKplGyBWFHyWlZYiBXhqHv3IMnF0JZgmJNNEDMcF8dz
 Wj9/pRbzOG2mJptkmwSpLhOiudZE4KgRgGXoFvpfFCSRmp0+xfRup4O24PQ+Kxp1mvOTFus94
 LqtoS/s5hDUweMkNRnewSA+Il5Oz3x4wrTY9YPNgW0NiMFBJDOT2Xkyu16opO5/wNwD7tCk6I
 hw70zlewdpwT2HURQVhGEu3bVemWjLpe44ZNwwaH2d/pAuE9x9QzwxVd5UovTiU/ReWYb2W5t
 Aj7F2KaH40WPJaOvbu/rcWcrzqbzqBA84wQMsxzPNT3dDEE/sDGvrrfa0gzAZaJvxhSDUJY5x
 +s9vCezauNijjfyEEqhB0oQwuRO/lS3mv+4JrCOBA4Qi6HzT09s1FCO2O7f1Pwi1r/tI58po9
 F6CMzoUNI8TwLFBFQPgKLwx9AF2dIj6hnvc3VLQOREqphBe64OIhJ2Y6OtvhrF42nRb6CKhjJ
 VaLrgGKaH/VBO1rD+WBmfK4hthFmDq0BERAJi49EMnXQlePP2Pq996aMvZwigoc56C6YvO+88
 qomB5yc1oV81blnBB3eYSYztsg2VzubEoiZ/RrrifSZ9xUdUWfCqfjxnqLWZlgRhrSLfKv2RZ
 H4ZZgrQmw1WiYsIC7SxqRMJixg6rflkzMd/2qWL/4jcsjlilz68lQn1cjAHqqkXE3XVppwUS/
 labWVdjhh9ALmm6hZd3wS0o0da0EuIHojLPXLvbueTs0wPkN/ny9gbe+L+PcOmbiVuoxbpVTF
 8f0CX8aBR4rvHg0SCdT1nB3B3/pTWvEBi5S7pn8onoHrEGABcVMLccGuaQm9S4M2kyeVai7id
 s9M/jmyyZMNUCR4lIPwZg5ugYpaX1pCEtCtJOTUbEx+n9PCzQCbeZoHf+D6nNitnPtyD/CSck
 j/GKcmLocoQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Wed, 13 Mar 2019, Duy Nguyen wrote:

> On Wed, Mar 13, 2019 at 4:13 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Duy, have you thought about making use of the CI builds? You could catch
> > those bugs before they hit the Git mailing list...
> 
> Using Azure? No.

This hostility is totally unnecessary. Especially since we still have
Travis builds that you could also use to catch your bugs early, so that I
would not have to catch them.

You could also work on setting up Circle CI, or whatever else you have in
mind. As long as you catch your bugs early.

Thanks,
Johannes
