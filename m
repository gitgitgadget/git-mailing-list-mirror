Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0F3220281
	for <e@80x24.org>; Fri, 15 Sep 2017 20:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbdIOUeH convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 15 Sep 2017 16:34:07 -0400
Received: from mxo2.nje.dmz.twosigma.com ([208.77.214.162]:57930 "EHLO
        mxo2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbdIOUeG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 16:34:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id B3AFF100049;
        Fri, 15 Sep 2017 20:34:05 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fxnHPDvHL5-w; Fri, 15 Sep 2017 20:34:05 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id A2D728002E;
        Fri, 15 Sep 2017 20:34:05 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Fri, 15 Sep 2017 20:34:05 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Fri, 15 Sep 2017 20:34:05 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Ben Peart' <benpeart@microsoft.com>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Subject: RE: [PATCH v6 06/12] ls-files: Add support in ls-files to display the
 fsmonitor valid bit
Thread-Topic: [PATCH v6 06/12] ls-files: Add support in ls-files to display
 the fsmonitor valid bit
Thread-Index: AQHTLlfZdo5nYE/U8U2J8C3ZLs/cxaK2Ztgw
Date:   Fri, 15 Sep 2017 20:34:05 +0000
Message-ID: <733a41051e084ba4b1f5c404ac8252e1@exmbdft7.ad.twosigma.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-7-benpeart@microsoft.com>
In-Reply-To: <20170915192043.4516-7-benpeart@microsoft.com>
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
> Sent: Friday, September 15, 2017 3:21 PM
> To: benpeart@microsoft.com
> Cc: David Turner <David.Turner@twosigma.com>; avarab@gmail.com;
> christian.couder@gmail.com; git@vger.kernel.org; gitster@pobox.com;
> johannes.schindelin@gmx.de; pclouds@gmail.com; peff@peff.net
> Subject: [PATCH v6 06/12] ls-files: Add support in ls-files to display the fsmonitor
> valid bit
> 
> Add a new command line option (-f) to ls-files to have it use lowercase letters
> for 'fsmonitor valid' files

Document in man page, please.
