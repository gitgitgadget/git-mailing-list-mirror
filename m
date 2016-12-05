Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BA981FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 23:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751497AbcLEXgu convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 5 Dec 2016 18:36:50 -0500
Received: from mxo2.dft.dmz.twosigma.com ([208.77.212.182]:54144 "EHLO
        mxo2.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbcLEXgt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 18:36:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTP id 05D3B10002E;
        Mon,  5 Dec 2016 23:36:48 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HGxTBb7_eTee; Mon,  5 Dec 2016 23:36:47 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTPS id EA3998002E;
        Mon,  5 Dec 2016 23:36:47 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Mon, 5 Dec 2016 23:36:47 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%25]) with mapi id
 15.00.1156.000; Mon, 5 Dec 2016 23:36:47 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Stefan Beller' <sbeller@google.com>,
        "bmwill@google.com" <bmwill@google.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "hvoigt@hvoigt.net" <hvoigt@hvoigt.net>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: RE: [RFC PATCHv2 15/17] checkout: recurse into submodules if asked to
Thread-Topic: [RFC PATCHv2 15/17] checkout: recurse into submodules if asked
 to
Thread-Index: AQHSTPyB0xThp5N770iouyO8ImFx1qD6BF1g
Date:   Mon, 5 Dec 2016 23:36:47 +0000
Message-ID: <5d42b3f7bd234d99bd626733594d9a63@exmbdft7.ad.twosigma.com>
References: <20161203003022.29797-1-sbeller@google.com>
 <20161203003022.29797-16-sbeller@google.com>
In-Reply-To: <20161203003022.29797-16-sbeller@google.com>
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
> From: Stefan Beller [mailto:sbeller@google.com]
> Sent: Friday, December 02, 2016 7:30 PM
> To: bmwill@google.com; David Turner
> Cc: git@vger.kernel.org; sandals@crustytoothpaste.net; hvoigt@hvoigt.net;
> gitster@pobox.com; Stefan Beller
> Subject: [RFC PATCHv2 15/17] checkout: recurse into submodules if asked to
> 
> Allow checkout to recurse into submodules via the command line option --
> [no-]recurse-submodules.

This option probably needs to precede 9/17 "update submodules: add scheduling to update submodules", since that patch uses --recurse-submodules. 
