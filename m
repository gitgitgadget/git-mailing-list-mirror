Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E915420A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 11:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeLMLQY (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 06:16:24 -0500
Received: from mout.gmx.net ([212.227.17.22]:56997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbeLMLQY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 06:16:24 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEFqW-1gdwP81Drs-00FS7e; Thu, 13
 Dec 2018 12:16:14 +0100
Date:   Thu, 13 Dec 2018 12:15:57 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] run-command: report exec failure
In-Reply-To: <xmqqbm5qioca.fsf_-_@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1812131215440.43@tvgsbejvaqbjf.bet>
References: <xmqqd0q8liow.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1812111327460.43@tvgsbejvaqbjf.bet> <xmqqsgz4jkgl.fsf@gitster-ct.c.googlers.com> <xmqqbm5qioca.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rggyRmU/1ipAUkl1vUwaPjZ2AR7ifG1ncMzunOJ2l5uI8yrKR4E
 S3SOlf9yqs7LAHK8z6DSjRfEQFkdqb43JNhynuid/EQMgxOnqJ17uNl0427e+At1JSDAhDb
 DkBL3Ru8CcD1A3yChLMBx3s/4J73OE7sIe958otU+rsmXhzbY3nilHA/mSSc8Zw/fhtYho5
 GXVWXcXxljgxytoEatk0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vs4rHOW8huk=:Rhxi1iFKbW4hicUbXm0j/R
 zR9GIANMt270bIO4rt+SdEfrDP5HjZuOTwskSEuEegOEYffFplXuyTBFpWnrzlXnDvmLl9EDb
 ZxyQ9no3tr9ZYY/0mjXxqCRyvONMadaDDQUa5Px/BujqvhIGJUo6N95tlnvh5r1nbzdaft75J
 N8YWXnGIB/pa1eLs32p9ngLtpVffMW0J2aYNjtcXT8gchKOnL3tkjbl1MGnFs/Tyj6y2wNtod
 Erhxw2LV2rSK6Oux3OxelThA0a7ANnU9INpBghiQdf1cOhjo7iJhAHI22Ii2YgJw0FYLOrr4U
 AJpvTTem1VTFWYIoR/eT+qhm6J3lcymEI54BE4Mc/v3gFhTQSG4Q6igV1WJFl0lqwHF4JQcMK
 X/i83oy5kFDWR7PzVUcFCqQpSkIfMZyQEvBiwAE7COhUa/1xwIvD1ZqLxaDTTLCvYgPrqgiDW
 6lP7An0nPFmZk/9raPq/07R4PaE+myK5/uR1cFcnJLjkojx98e67F9NO8n4RytPLFwCAdMfxH
 8yOi1QVVRprSPBFf9ss0OYUlAH4uk5fvbiO26QygnCC5U+QVuuxE9kiQOL4a/rEz1sauKp2ek
 M9a9IHfeo3MFxJzE++4l2sPqTBcRwYP9yqY8plTOhbHKFGiuJfNVPtkQaz7OYt3Qc7os1D4vu
 gzwfupBenk7+GkCrwqpx1mQj4YyDhFrjwk7Gmf0pzwtOuP48AF2iqGpMUMDRIWe3+7FjCTrfj
 VMtBdWqJsetzD2MAgsxvHGzX3/aB9q9s3g4CREGTDG798rBNxZUFm9IBSQTY+6QyPi2cSHA95
 uU0dl3iPuYeRCfLHynEhuXkGmm6s8rd0boeKb2fLATftNNMKkRWt7Gwhc6wfbG2ksFUHo5TYZ
 FHO3amXL9kJllN1C/yP8oyV5pmN9+YAppezRfyfZP8D3/WMfaXF9oR5BhMAub6buRcdUKzMQn
 0ZIW8ARPXzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 13 Dec 2018, Junio C Hamano wrote:

>    I am taking that https://travis-ci.org/git/git/jobs/466908193
>    that succeeded on Windows as a sign that this is now OK there.

I concur,
Dscho
