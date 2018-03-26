Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B29061F404
	for <e@80x24.org>; Mon, 26 Mar 2018 21:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeCZViV (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 17:38:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:54297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbeCZViU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 17:38:20 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MC3zg-1erk8A2K3c-008okv; Mon, 26
 Mar 2018 23:38:18 +0200
Date:   Mon, 26 Mar 2018 23:38:17 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Loganaden Velvindron <logan@hackers.mu>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] Allow use of TLS 1.3
In-Reply-To: <20180326092423.GA7521@voidlinux>
Message-ID: <nycvar.QRO.7.76.6.1803262336070.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180326092423.GA7521@voidlinux>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PZ7eendeYUxvSEHirbQSb60k93408YH94s+M2FwoHZLR11+ZLUg
 xiSKtdp1TWeORncBEB+a3fFpLbSokzyemiBQBex9XpnBt6+rIFSf3J0Hethj3aNqASsd0Gs
 WLCAL2AaXk1gu4S2Jx+yRx2vAHfBQ7oaaPKZaZKrDIpq3c2Kf1NLOXmW4w+4iX578+es1fp
 fHRRb9aHPsR3oNhZhqwaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YwnIYYUPFyc=:lAruLJegyq/VSLROqZqqVl
 MBlFmLzTsPJqLGu1P6aoij/7eBwhSA0VNnYpNe81SPNSkYioipaQuAHDlrkuzu5kkinaYVbB9
 rUa+IW8ej79CJHE3rPTzyhtnA3JsBqqaPG3ZsLnBn3fjQHy/aZOg1rutppd1IfP4g+kTAJ94E
 RrUNUN5X2Bt16CWFm9qWIIb4s3wSV9SGzIWDDPByAY5b5hn/fZfscmV7DxrZIawTYajQQCeQQ
 7rp2siH3qKxopbsv4t0cc8QQUvh2iKZKbbklMU+X4K/pCfR3TvuWAGqCFcCYMOuKvkQfDHt+h
 3smCrIgNPRjFtxNuFV7QRgx5mn/69yIrqpEHZWRDhRW0BpHJACf4qzgPS/8t9iG3a/V+Pk0wW
 n+R9Qt4ia5Yq61eTwoJHrBA4/LZk5ahMJdAZVl1dO0Ty71UrlHp52CH4NlN2mO0/OPDf/Y/8s
 6/U+aaaDZTPWMGeufkjyS1gQceVSKqiWRG278qoJxnetMp5gGKGp2/wSOr58T3WrOvopCY/fa
 b8hrW4893ijlU6uNTzXQsZoJysGrs4kghDO/gOSlGc8X3/T3ngDxHO58EhP5G+RqHabDkXZPr
 Vtl+K08tVkkcGFmnXhYnzqSoCvND6udRuYdVxOTJGGbTL8fOVzAQKsE+gpv9AIpI/Q/ql5Aeh
 c3wHXGfcLOxRHGHFgt988oDJxlEyx4z/RgMDYuOHtcBp9+MXuro2yC+iq5FhvFp2JiOAqQD9J
 4gLVv68J0/tvsawCfZ+ZXPuGbgKkcJKoB9KxJ1rgPPuIYGcbAqMq5K7ndCGVUtgqvg+bBsg8D
 kYcaU8gZpKyeq5345P1WTfXAPzdBG0XrPJVtJZUW2d35ojYefFS2H+93jwCux0gkAvZ+VAS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Logan,

On Mon, 26 Mar 2018, Loganaden Velvindron wrote:

> Add a tlsv1.3 option to http.sslVersion in addition to the existing
> tlsv1.[012] options. libcurl has supported this since 7.52.0.
> 
> Signed-off-by: Loganaden Velvindron <logan@hackers.mu>

Can we *please* also add that OpenSSL 1.1.* is required (or that cURL is
built with NSS or BoringSSL as the TLS backend)?

See
https://public-inbox.org/git/nycvar.QRO.7.76.6.1803240035300.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz/
for my original please.

I deem this information *really* important because a lot of Git packages
are still built against OpenSSL 1.0.2 (e.g. Git for Windows) and *won't*
benefit immediately from your patch.

Ciao,
Johannes
