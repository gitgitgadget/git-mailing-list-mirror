Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB89207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 21:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933294AbcI3ViU (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 17:38:20 -0400
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:59789 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932883AbcI3ViS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 17:38:18 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Sep 2016 17:38:18 EDT
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id 98DD410005D;
        Fri, 30 Sep 2016 21:32:04 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QfkEDmO397Qg; Fri, 30 Sep 2016 21:32:04 +0000 (GMT)
Received: from exmbdft8.ad.twosigma.com (exmbdft8.ad.twosigma.com [172.22.2.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id 886FD80035;
        Fri, 30 Sep 2016 21:32:04 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft8.ad.twosigma.com (172.22.2.84) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Fri, 30 Sep 2016 21:32:04 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef]) by
 exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef%17]) with mapi id
 15.00.1156.000; Fri, 30 Sep 2016 21:32:04 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Jeff King' <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH 3/6] tmp-objdir: introduce API for temporary object
 directories
Thread-Topic: [PATCH 3/6] tmp-objdir: introduce API for temporary object
 directories
Thread-Index: AQHSG1pMQwb/ldXAYUWzW5NCDp/JCaCSh1nA
Date:   Fri, 30 Sep 2016 21:32:04 +0000
Message-ID: <b7136f0690244aee94ff2db726a7edce@exmbdft7.ad.twosigma.com>
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
 <20160930193613.dwpjiw5xps6a3wgj@sigill.intra.peff.net>
In-Reply-To: <20160930193613.dwpjiw5xps6a3wgj@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.13]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiArc3RhdGljIHZvaWQgZW52X2FwcGVuZChzdHJ1Y3QgYXJndl9hcnJheSAqZW52LCBjb25zdCBj
aGFyICprZXksIGNvbnN0DQo+ICtjaGFyICp2YWwpIHsNCj4gKwljb25zdCBjaGFyICpvbGQgPSBn
ZXRlbnYoa2V5KTsNCj4gKw0KPiArCWlmICghb2xkKQ0KPiArCQlhcmd2X2FycmF5X3B1c2hmKGVu
diwgIiVzPSVzIiwga2V5LCB2YWwpOw0KPiArCWVsc2UNCj4gKwkJYXJndl9hcnJheV9wdXNoZihl
bnYsICIlcz0lcyVjJXMiLCBrZXksIG9sZCwgUEFUSF9TRVAsDQo+IHZhbCk7IA0KPit9DQoNCkkg
d291bGQgbGlrZSBhIGNvbW1lbnQgZXhwbGFpbmluZyB0aGlzIGZ1bmN0aW9uLiANCg0KPiArICog
RmluYWxpemUgYSB0ZW1wb3Jhcnkgb2JqZWN0IGRpcmVjdG9yeSBieSBtaWdyYXRpbmcgaXRzIG9i
amVjdHMgaW50bw0KPiArdGhlIG1haW4NCj4gKyAqIG9iamVjdCBkYXRhYmFzZS4NCj4gKyAqLw0K
DQpUaGlzIHNob3VsZCBtZW50aW9uIHRoYXQgaXQgZnJlZXMgaXRzIGFyZ3VtZW50Lg0KDQo=
