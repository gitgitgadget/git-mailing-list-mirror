Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22DED1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 16:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756357AbcLSQDN (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 11:03:13 -0500
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:33795 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756080AbcLSQDL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 11:03:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id 40F8F100052;
        Mon, 19 Dec 2016 16:03:10 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AcExpGgncDD7; Mon, 19 Dec 2016 16:03:10 +0000 (GMT)
Received: from exmbdft8.ad.twosigma.com (exmbdft8.ad.twosigma.com [172.22.2.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id 3094380035;
        Mon, 19 Dec 2016 16:03:10 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft8.ad.twosigma.com (172.22.2.84) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Mon, 19 Dec 2016 16:03:09 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%25]) with mapi id
 15.00.1156.000; Mon, 19 Dec 2016 16:03:09 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Jeff King' <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH] pack-objects: don't warn about bitmaps on incremental
 pack
Thread-Topic: [PATCH] pack-objects: don't warn about bitmaps on incremental
 pack
Thread-Index: AQHSWBqu7cHaskm6y0Kh0b5Pr7+FeqEPb9Fw
Date:   Mon, 19 Dec 2016 16:03:09 +0000
Message-ID: <84da83e80fff40e3b7de43d2a11d440d@exmbdft7.ad.twosigma.com>
References: <20161216214906.z53yp2x4n6hdc27m@sigill.intra.peff.net>
 <1481932775-12952-1-git-send-email-dturner@twosigma.com>
 <20161217040426.7qeixbihiou5mbsl@sigill.intra.peff.net>
In-Reply-To: <20161217040426.7qeixbihiou5mbsl@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.11]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBkaWZmIC0tZ2l0IGEvYnVpbHRpbi9nYy5jIGIvYnVpbHRpbi9nYy5jIGluZGV4IDA2OTk1MGQw
YjQuLmQzYzk3OGM3NjUNCj4gMTAwNjQ0DQo+IC0tLSBhL2J1aWx0aW4vZ2MuYw0KPiArKysgYi9i
dWlsdGluL2djLmMNCj4gQEAgLTE5MSw2ICsxOTEsMTEgQEAgc3RhdGljIHZvaWQgYWRkX3JlcGFj
a19hbGxfb3B0aW9uKHZvaWQpDQo+ICAJfQ0KPiAgfQ0KPiANCj4gK3N0YXRpYyB2b2lkIGFkZF9y
ZXBhY2tfaW5jcmVtZW50YWxfb3B0aW9uKHZvaWQpDQo+ICt7DQo+ICsJYXJndl9hcnJheV9wdXNo
KCZyZXBhY2ssICItLW5vLXdyaXRlLWJpdG1hcC1pbmRleCIpOyB9DQo+ICsNCj4gIHN0YXRpYyBp
bnQgbmVlZF90b19nYyh2b2lkKQ0KPiAgew0KPiAgCS8qDQo+IEBAIC0yMDgsNyArMjEzLDkgQEAg
c3RhdGljIGludCBuZWVkX3RvX2djKHZvaWQpDQo+ICAJICovDQo+ICAJaWYgKHRvb19tYW55X3Bh
Y2tzKCkpDQo+ICAJCWFkZF9yZXBhY2tfYWxsX29wdGlvbigpOw0KPiAtCWVsc2UgaWYgKCF0b29f
bWFueV9sb29zZV9vYmplY3RzKCkpDQo+ICsJZWxzZSBpZiAodG9vX21hbnlfbG9vc2Vfb2JqZWN0
cygpKQ0KPiArCQlhZGRfcmVwYWNrX2luY3JlbWVudGFsX29wdGlvbigpOw0KPiArCWVsc2UNCj4g
IAkJcmV0dXJuIDA7DQo+IA0KPiAgCWlmIChydW5faG9va19sZShOVUxMLCAicHJlLWF1dG8tZ2Mi
LCBOVUxMKSkNCg0KU3VyZSwgdGhhdCdzIGZpbmUuDQo=
