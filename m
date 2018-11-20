Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 527711F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 05:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbeKTPoD (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 10:44:03 -0500
Received: from mout.web.de ([212.227.17.11]:54091 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbeKTPoD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 10:44:03 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ma2YF-1g9uta24gZ-00LmMd for
 <git@vger.kernel.org>; Tue, 20 Nov 2018 06:16:49 +0100
Date:   Tue, 20 Nov 2018 06:16:49 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     git@vger.kernel.org
Subject: Re: [PATCH/RFC v2 1/1] Use size_t instead of 'unsigned long' for
 data in memory
Message-ID: <20181120051649.GA16814@tor.lan>
References: <20181120050454.16673-1-tboegi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181120050454.16673-1-tboegi@web.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:O2Oyd70o8S+KGvhton1oWJmtQMC9RGkvtFToJwdyniNIfLr/nqz
 YPe5VMufw1h0we7bemLbB6oiIdAZzxfM7tun8IXM9z+9g5I9rTxcXgciSyQ29BGMjIl0WBn
 gLei8YMLAaiYZJL+ZoSS2dmELDYqa6KJK+nlmZdkkzarq+OnHcFJuciy0b/3DMLDCiaeTay
 vZ+UaI/QHqMcrtF6Uq9qQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RNH53SwqvdY=:aApFlVVLd1pGkI+3i2ZOnQ
 Zm30Cy+trlcooSWmqnRyJogcG+PwwUJo3ZnbB44Ki9+0Ook+M2NmtTVwxj3g1Xs/7weoAKo8X
 2FpKBeF2g7kMMb3tXQEC34TAYpbw8DY/umdAzwI/dtnHelHeWlYZNdn+uzsM4KiOu1g2priEW
 Do/tu0WDX3x9OZ1vYccLan+bWGLehWGCUIMaMeGssnIeYl1k+SBgrMpDU+ZFQYO9HSXw4EEF/
 OVv51gd8oOe889oNMrTw/jb6y6tFzL9wKWOlTy1muSEh9PxwmoZ2Gl9Z0TRmMpdJAzpK1Jsw/
 XHp8McOkebSEH+ksjZ/HiB7UjCj1H4ByTE2NHH4cgK7jAtwlYsrMu28bjRqeNR+buMHx3PQQo
 ef6L71y/zlp9VJdnjvkHlJVrqjhnPSbal2K1DggDVbRLrOSnupSvfypsuGUcXvUrI9Qr9gIts
 o8eJaO6mtOIIjxbAdQJdVHMK01N9cXAQF9M3L6ZrbSgh+IWrK8g8CE2XOHukRrlFpm9pizeIq
 BeQ58q8rnWGLDWGQ9O97PZHHUZdLNAGT7DVj1iHTf+CXsBnQ4EyhkSfGCWYEIkIp0tBW0UXiB
 jBeG/KWOZDG4JmwlQFgWnr+4zxtA+CosEDFsvc0IP0hp8GaRq+vKZXwIs4qwnGHyqd7HlHUbc
 vY5LuzmWaTwPkKz0+e+L3jgfjDWViUuvPkHPNB8cEvpJkEgFbkiuG5HrjWHEMO9dR01fH//Uz
 L7aim5eBbVkgMb5f1u3F2lT9x1rKIZG2EKePkSXHsrz8O1AvpG1v3YFLWjD21Oxgn4bkStgD6
 8mgyzQmTD/bD/gPe05NdyUPVmkG9u3MlB0AcUdXRjNz161ipSRS96K28wWYVLSNmjjtzHGtNE
 SfjrxiEesus8jO9phFcCNSFbBopxyiUgw9goVk7No=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 20, 2018 at 06:04:54AM +0100, tboegi@web.de wrote:
> From: Torsten Bögershausen <tboegi@web.de>
> 
> Currently the length of data which is stored in memory is stored
> in "unsigned long" at many places in the code base.
> This is OK when both "unsigned long" and size_t are 32 bits,
> (and is OK when both are 64 bits).
> On a 64 bit Windows system am "unsigned long" is 32 bit, and
> that may be too short to measure the size of objects in memory,
> a size_t is the natural choice.
> 
> Improve the code base in "small steps", as small as possible.
> The smallest step seems to be much bigger than expected.

Ops, it seems as if I send this message out twice -
please ignore the "PATCH/RFC v2 1/1"
Sorry for the noise.
