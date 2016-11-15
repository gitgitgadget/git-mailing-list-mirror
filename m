Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4854B2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 15:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938703AbcKOPpZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 10:45:25 -0500
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:53927 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933828AbcKOPpX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 10:45:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id 8754F100075;
        Tue, 15 Nov 2016 15:45:20 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id woYP9tca6q-T; Tue, 15 Nov 2016 15:45:20 +0000 (GMT)
Received: from exmbdft8.ad.twosigma.com (exmbdft8.ad.twosigma.com [172.22.2.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id 7539E80035;
        Tue, 15 Nov 2016 15:45:20 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft8.ad.twosigma.com (172.22.2.84) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Tue, 15 Nov 2016 15:45:20 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef]) by
 exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef%17]) with mapi id
 15.00.1156.000; Tue, 15 Nov 2016 15:45:20 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Jeff King' <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "spearce@spearce.org" <spearce@spearce.org>
Subject: RE: [PATCH] remote-curl: don't hang when a server dies before any
 output
Thread-Topic: [PATCH] remote-curl: don't hang when a server dies before any
 output
Thread-Index: AQHSPqRXYl8XykiMv0OTBeEAHSKu4qDY4LeAgAA9QGCAAAgIgIABCrag
Date:   Tue, 15 Nov 2016 15:45:19 +0000
Message-ID: <a651930afcc542fb80161a7a399aa0ce@exmbdft7.ad.twosigma.com>
References: <1478729910-26232-1-git-send-email-dturner@twosigma.com>
 <20161114182431.e7jjnq422c4xobdb@sigill.intra.peff.net>
 <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net>
 <a57cc9c4a0a840baab5b8123fac9388b@exmbdft7.ad.twosigma.com>
 <20161114234847.2nexsgedpg7zvrr5@sigill.intra.peff.net>
In-Reply-To: <20161114234847.2nexsgedpg7zvrr5@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.14]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZWZmIEtpbmcgW21haWx0bzpw
ZWZmQHBlZmYubmV0XQ0KLi4uDQo+IEknbGwgbWFrZSB0aGF0IGNoYW5nZSBhbmQgdGhlbiB0cnkg
dG8gd3JhcCB0aGlzIHVwIHdpdGggYSBjb21taXQgbWVzc2FnZS4NCj4gSSBwbGFuIHRvIHN0ZWFs
IHlvdXIgdGVzdHMsIGlmIHRoYXQncyBPSy4NCg0KUGxlYXNlIGRvIQ0KDQo=
