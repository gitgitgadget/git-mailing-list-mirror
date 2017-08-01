Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A1E12047F
	for <e@80x24.org>; Tue,  1 Aug 2017 20:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbdHAUKs convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 1 Aug 2017 16:10:48 -0400
Received: from mxo1.nje.dmz.twosigma.com ([208.77.214.160]:48520 "EHLO
        mxo1.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbdHAUKq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 16:10:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTP id 698F4100054
        for <git@vger.kernel.org>; Tue,  1 Aug 2017 20:10:45 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KQwq7dyOK78o for <git@vger.kernel.org>;
        Tue,  1 Aug 2017 20:10:45 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (exmbdft7.ad.twosigma.com [172.22.2.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTPS id 5800B8002E
        for <git@vger.kernel.org>; Tue,  1 Aug 2017 20:10:45 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft7.ad.twosigma.com (172.22.2.43) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Tue, 1 Aug 2017 20:10:45 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Tue, 1 Aug 2017 20:10:45 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git-fast-export doesn't support mergetag header
Thread-Topic: git-fast-export doesn't support mergetag header
Thread-Index: AdMLAiPXG7DWur0BTI2vztyGDqvUYA==
Date:   Tue, 1 Aug 2017 20:10:44 +0000
Message-ID: <9955b90cde034eee8c2cdb33064b9262@exmbdft7.ad.twosigma.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.9]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It looks to me like git-fast-export doesn't export the mergetag header on a commit.  Is this intentional, or an oversight?
