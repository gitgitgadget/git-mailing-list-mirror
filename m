Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 933CD20A28
	for <e@80x24.org>; Tue, 19 Sep 2017 19:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbdISTqT convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 19 Sep 2017 15:46:19 -0400
Received: from mxo2.dft.dmz.twosigma.com ([208.77.212.182]:40620 "EHLO
        mxo2.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbdISTqS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 15:46:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTP id B5E52100059;
        Tue, 19 Sep 2017 19:46:17 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jccHDgX5z9Lj; Tue, 19 Sep 2017 19:46:17 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTPS id A4C1D8002E;
        Tue, 19 Sep 2017 19:46:17 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Tue, 19 Sep 2017 19:46:17 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Tue, 19 Sep 2017 19:46:17 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Ben Peart' <benpeart@microsoft.com>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Subject: RE: [PATCH v7 06/12] ls-files: Add support in ls-files to display the
 fsmonitor valid bit
Thread-Topic: [PATCH v7 06/12] ls-files: Add support in ls-files to display
 the fsmonitor valid bit
Thread-Index: AQHTMX2B4PBp+DHoukCxcEeYWCLnXqK8m3ag
Date:   Tue, 19 Sep 2017 19:46:17 +0000
Message-ID: <37b2e5b4ca1d490b9f50d430b3b420f0@exmbdft7.ad.twosigma.com>
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
 <20170919192744.19224-7-benpeart@microsoft.com>
In-Reply-To: <20170919192744.19224-7-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Ben Peart [mailto:benpeart@microsoft.com]
> Sent: Tuesday, September 19, 2017 3:28 PM
> To: benpeart@microsoft.com
> Cc: David Turner <David.Turner@twosigma.com>; avarab@gmail.com;
> christian.couder@gmail.com; git@vger.kernel.org; gitster@pobox.com;
> johannes.schindelin@gmx.de; pclouds@gmail.com; peff@peff.net
> Subject: [PATCH v7 06/12] ls-files: Add support in ls-files to display the
> fsmonitor valid bit
> 
> Add a new command line option (-f) to ls-files to have it use lowercase
> letters for 'fsmonitor valid' files
> 
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>  builtin/ls-files.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

This is still missing the corresponding documentation patch.  

I can see from replies that at least some of my messages got through.  In total, I sent messages about:
04/12 (I see replies)
05/12 (I see replies)
06/12 (no reply, issue not fixed)
10/12 (no reply, haven't checked whether same issue but I assume same issue since the new case I mentioned isn't added)
12/12 (no reply, typo fixed -- no reply required)

