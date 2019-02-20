Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 458861F453
	for <e@80x24.org>; Wed, 20 Feb 2019 20:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfBTUrL (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 15:47:11 -0500
Received: from mout.gmx.net ([212.227.17.21]:51633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfBTUrK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 15:47:10 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMGWH-1gxM6l2GC5-0080pP; Wed, 20
 Feb 2019 21:46:54 +0100
Date:   Wed, 20 Feb 2019 21:46:37 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.21.0-rc2
In-Reply-To: <xmqqftsiw8l8.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902202146060.41@tvgsbejvaqbjf.bet>
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com> <012601d4c8b5$54f1b730$fed52590$@nexbridge.com> <xmqqftsiw8l8.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AzRjfyyWMLKn70jJFW/+J5eW7PG4QbEnlLMGmk2PnHZ/OKoJOqv
 VjvsdP1MCbw1C2WkXhvB2CPFGw5TzaVBiKLa7vIjxTz5RlUiqjYp4UblMkZzi6jLUtlMj3P
 FnfMMjnKyo8oUxAOtxx4/fxd5XsV0jtPWF748BboR0+4Y1JTupywHBLfQA1LIzDcos7u41x
 3829PvJPPEtMEgbw9W+/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x+ViWzxsU+o=:mgDOxNv9RXgumfL9qKeVDs
 HOlpxjaMGtyXcdzyIONO+rAsu3q8c3s0dM9pY9H9vXqtcCr+jrXA4EvQEh6Y5cBzIHo3SdNag
 hKo+5lD48Jcybqnip9b8jN2x+ykpjRr8FOVO0kyuo+ZSkyTRcZuDfqTJxEHADAxhLyseqKBvF
 2ClbAZpKnDWGpojtPqh/GOQ7LDeD91AHBhsA8In1tcRsnDmuexOcWoK/ovNsQNysWTNsk2bDl
 u2+EMWXg0dH6GM1lCisBStclGL+7M6o5URPh+6K6E+Tbyb5ySFGcjQF/uvN5He9jrKr4q9Kk2
 Xr2jtkf6Smog80uI4fF0F8Mxhv6OMnsGrqYBOxbG6wHVrjF4cjeJuYYT9VEk5FGGozl3pYwPH
 fmQJyo8hhbyuVWp6qLFJ7VVYec3OEeB8y85qvOFGJfDD8q4naArhQxd+3DBf4EmHviiBKH8Ap
 IaiL9mE6YSrs3vlIa3Bv/7W/zv7hPOnA/Zrc+0bt8KARmpTkoQcgSZbABow/tmtU0wJ0xxhXP
 fcgUJH3Ckm+udB+9Rmc4lG1KAfvpWdrrIQKSUbkor0Had6VIa1Zc+yOCu503fY3+0aSr8lKkO
 1IbVCIpWmm0KNYKmUIPINo4f/w/rRDyBMNnXUBZz7jaQ6zar4ckAD3XbDIFTwpD7ijP6XBQ75
 gP37o2aDeIiNH1/kQtwFbBn+X94oIcY84CdgBlnBm0wQNCkeFEXEr8hid+CRndQzwUD/gJdsM
 XksEn7Sui0oV9hZ9PB7BEXb3FklQEFZagiLFvkGezBxCJyFvO9AJNSN2uSL3UFwgtrCo7rO7j
 UZd+EW3HZii4T/iyvA93DNQWJ4lhS+4DJuD77kznz7TKT5j2xcNVwEahmRBPOcfzTfNoCOTSS
 2FqmbqjVbCqDOuDQlXzi75QFWLTSuy2E5KUULibABd71UIs//v17keM2EebUplaRmTDqdK3a3
 C3bUMahUSXg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 20 Feb 2019, Junio C Hamano wrote:

> Hopefully Dscho's Azure thing would also be happy with one less use
> of Perl script.

My "Azure thing" does not time out anymore, indeed!

Thank you so much, Junio,
Dscho
