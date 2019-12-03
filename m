Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA52C432C3
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 08:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6808A2053B
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 08:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfLCI3B convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 3 Dec 2019 03:29:01 -0500
Received: from cnshjsmin05.app.nokia-sbell.com ([116.246.26.45]:13949 "EHLO
        cnshjsmin05.nokia-sbell.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbfLCI3B (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 3 Dec 2019 03:29:01 -0500
X-AuditID: ac18929d-537ff70000002afa-9a-5de61cca81bb
Received: from CNSHPPEXCH1608.nsn-intra.net (Unknown_Domain [135.251.51.108])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by cnshjsmin05.nokia-sbell.com (Symantec Messaging Gateway) with SMTP id EB.D3.11002.ACC16ED5; Tue,  3 Dec 2019 16:28:58 +0800 (HKT)
Received: from CNSHPPEXCH1610.nsn-intra.net (135.251.51.110) by
 CNSHPPEXCH1608.nsn-intra.net (135.251.51.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Dec 2019 16:28:58 +0800
Received: from CNSHPPEXCH1610.nsn-intra.net ([135.251.51.110]) by
 CNSHPPEXCH1610.nsn-intra.net ([135.251.51.110]) with mapi id 15.01.1713.007;
 Tue, 3 Dec 2019 16:28:58 +0800
From:   "Lou, Pengfei (NSB - CN/Hangzhou)" <pengfei.lou@nokia-sbell.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: one bug on git
Thread-Topic: one bug on git
Thread-Index: AdWpqKh+Y3gz8IRUTs2wD1ZmDLyXiAACqzig
Date:   Tue, 3 Dec 2019 08:28:58 +0000
Message-ID: <5e27e2a9f6374742859b4b87d85c56e9@nokia-sbell.com>
References: <defeb7be75f54e8483ce529b2571478d@nokia-sbell.com>
In-Reply-To: <defeb7be75f54e8483ce529b2571478d@nokia-sbell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [135.251.51.115]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsXS/ts4R/eUzLNYg99bVC26rnQzOTB6fN4k
        F8AYxWWTkpqTWZZapG+XwJWxfmsDY8FN/ooZN7qYGxhX8XYxcnJICJhI7Fw1ibWLkYtDSOAQ
        k8SkvyvZIZw/jBJTTrcxQzgbGSU+7T7BBNLCJuAmsf9vL1CCg0NEQF+i74IoSFhYQFqi9+9m
        dhBbREBGYu+hfSwQtpHEodlPwOIsAioSq++vZAaxeQXsJJ61rWUFsYWA7DmL5oHVcArYSzxu
        bGUEsRkFxCS+n1oDtpZZQFzi1pP5TBBXC0gs2XOeGcIWlXj5+B8ryDkSAkoSfRugyvUkbkyd
        wgZha0ssW/gaaq2gxMmZT1gmMIrOQjJ1FpKWWUhaZiFpWcDIsopROjmvOCOrODczz8BULy8/
        OzNRtzgpNSdHLzk/dxMjMDrWSEyau4OxszP+EKMAB6MSD2/GryexQqyJZcWVuYcYJTiYlUR4
        t0k8jRXiTUmsrEotyo8vKs1JLT7EKM3BoiTO2zJ5YayQQHpiSWp2ampBahFMlomDU6qBUYnt
        Feeqi89DM16JBHw8x9R5ewbj/7iSuUkf/YyqbvTknv5XpLJiTc+8c2lvrx4TCNatnGE+p+OF
        6xfxn5vaC5umHNnesnl2S6e4XPwE8dUcK+2+9fZ427I+m7ZU/vrBw+++n/RLsclni5qm8DF5
        w+6Vp0Ubny19p2L4vftg/yrrbderHPSy25VYijMSDbWYi4oTAdkMHjiKAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello community 
     One problem I found recently within my working, please check my detail below. 

     I tried to run my script (check the attached file 'problem.sh') to build one git repository , it can be successful, but the command "git log -raw -1 ${revision}^ ${revision}" on that repo would generate some  unexpected result,  please check the result below

[pelou@hzling29 try_des]$ git --version
git version 2.6.2

[pelou@hzling29 try_des]$ git log --raw -1 164304f48726d31336e2e130a90e42b7f1c480f8
commit 164304f48726d31336e2e130a90e42b7f1c480f8
Author: pelou <mailto:pengfei.lou@nokia-sbell.com>
Date:   Tue Dec 3 14:54:33 2019 +0800

    3

:100644 100644 9a7456b... 8148ef7... M  lpf
[pelou@hzling29 try_des]$ git log --raw -1 164304f48726d31336e2e130a90e42b7f1c480f8^ 164304f48726d31336e2e130a90e42b7f1c480f8
commit dd1a95338ffd471e5b270a487b585bbfcf9926a5
Author: pelou <mailto:pengfei.lou@nokia-sbell.com>
Date:   Tue Dec 3 14:54:33 2019 +0800

    2

:100644 100644 d474e1b... 9a7456b... M  lpf 

     Next step I changed my script(check the attached file good.sh) and only add some delays after "git push", everything is normal, check it below
[pelou@hzling29 try_des]$ git log --raw -1 2027dc54da1896cf1dfa301c3444b1690d6cb1d8
commit 2027dc54da1896cf1dfa301c3444b1690d6cb1d8
Author: pelou <mailto:pengfei.lou@nokia-sbell.com>
Date:   Tue Dec 3 15:00:45 2019 +0800

    3

:100644 100644 9a7456b... 8148ef7... M  lpf
[pelou@hzling29 try_des]$ git log --raw -1 2027dc54da1896cf1dfa301c3444b1690d6cb1d8^ 2027dc54da1896cf1dfa301c3444b1690d6cb1d8
commit 2027dc54da1896cf1dfa301c3444b1690d6cb1d8
Author: pelou <mailto:pengfei.lou@nokia-sbell.com>
Date:   Tue Dec 3 15:00:45 2019 +0800

    3

:100644 100644 9a7456b... 8148ef7... M  lpf

So please help me fix it. Please let me know if I was wrong or miss some thing

Br, Hercules
