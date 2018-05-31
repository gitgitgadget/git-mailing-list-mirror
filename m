Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CABD41F42D
	for <e@80x24.org>; Thu, 31 May 2018 16:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755555AbeEaQAx (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 12:00:53 -0400
Received: from mail-bn3nam01on0044.outbound.protection.outlook.com ([104.47.33.44]:23824
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755544AbeEaQAw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 12:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zillowgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEIVl/0sL5FNls5nl0cqiHsGHEd/gkKv9adtaxPDqeA=;
 b=LnIdZs1d13WwWPAeuIRAJrGIHFzoUK640AvlJ14UVa4NbvnK/BIDxS5ih57qaQk7UfGo57em/ad7b2pCRiwQjg2Ok7VBHpoBbuwlfhAf3McUflnNTJYFpwJ0aJFW+ZUvAfrTbLH5m7zl6wqczQAMJG05WGTk1IUD0bOAny8R/hk=
Received: from CY1PR0601MB1990.namprd06.prod.outlook.com (10.164.221.24) by
 CY1PR0601MB1423.namprd06.prod.outlook.com (10.163.21.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.12; Thu, 31 May 2018 16:00:38 +0000
Received: from CY1PR0601MB1990.namprd06.prod.outlook.com
 ([fe80::e142:f997:293c:917]) by CY1PR0601MB1990.namprd06.prod.outlook.com
 ([fe80::e142:f997:293c:917%4]) with mapi id 15.20.0820.010; Thu, 31 May 2018
 16:00:38 +0000
From:   Erika Voss <erikav@zillowgroup.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Vulnerability Announced?
Thread-Topic: Git Vulnerability Announced?
Thread-Index: AQHT+PgUVR9HQK2Bn0Oo58yb1ByDZaRJ/tMA//+K64A=
Date:   Thu, 31 May 2018 16:00:38 +0000
Message-ID: <E1D8F36A-9317-41ED-B761-2AE15B54B927@zillowgroup.com>
References: <D47B86A7-2E5A-4401-99B2-E59FD859C7E6@zillowgroup.com>
 <001301d3f8f8$65bc6660$31353320$@nexbridge.com>
In-Reply-To: <001301d3f8f8$65bc6660$31353320$@nexbridge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=erikav@zillowgroup.com; 
x-originating-ip: [64.125.67.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0601MB1423;7:FSajCQdNsNFaShkk27nrvogGHkdj4r4giG2THS2bliXlyPX7fse6eHBhI5jlmUyogEuaGLO702SsdjpMLle6yH5fQZmL0WVYXbgS0y3yTZu17EGEn7lu9nZciYLkmferedB73EaW/aOrIRKUjkMw+/T+fUFLV4eNIKe7VgwyoKprWqs8ARljb0K13B/7RgTVNYiK7tPi2DXnRxDKdV16nZTtETgEMSUevsI+GAfMShi05Xl8zhyRKpTzk9YtsrAh
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:CY1PR0601MB1423;
x-ms-traffictypediagnostic: CY1PR0601MB1423:
x-microsoft-antispam-prvs: <CY1PR0601MB14235E776B4ED61AAC14A79FC3630@CY1PR0601MB1423.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(54094131786539)(209352067349851)(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY1PR0601MB1423;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0601MB1423;
x-forefront-prvs: 06891E23FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39380400002)(346002)(39860400002)(396003)(199004)(189003)(36756003)(2501003)(3660700001)(5250100002)(3280700002)(6246003)(25786009)(486006)(33656002)(7116003)(8936002)(6486002)(6436002)(106356001)(229853002)(81166006)(305945005)(8676002)(81156014)(105586002)(7736002)(83716003)(86362001)(110136005)(2906002)(3480700004)(316002)(5660300001)(82746002)(97736004)(6306002)(446003)(3846002)(6116002)(26005)(99286004)(68736007)(6512007)(966005)(66066001)(186003)(478600001)(53546011)(59450400001)(6506007)(2900100001)(102836004)(14454004)(76176011)(476003)(53936002)(2616005)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0601MB1423;H:CY1PR0601MB1990.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: zillowgroup.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tHCm4MC7XISLgjxwKSyLfGkp1Inczd3in8+WP/0mwcwY2ZRfMOLSI0zxOa1bXYKa8pdI4KUYc/ZJdORClkZ9K4zKJ4NVA6hR3tAh0cEApsye45aUfYfSE4NoY1YgmBqrrTPntIu11QH6X5Wm6BphyFAptVRcDtcSVQF8o5RC3VGg5gytj8jkkoWoStPZe6fF
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <45CBCC50DFDBA14AADC44459F60C4FD5@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 62f3eadf-9239-4211-4889-08d5c70fa718
X-OriginatorOrg: zillowgroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f3eadf-9239-4211-4889-08d5c70fa718
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2018 16:00:38.4216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 03346483-0d18-40e7-a588-3784ac50e16f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0601MB1423
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgUmFuZGFsbCwNCg0KWWVzIGhlcmUgaXMgd2hhdCB3YXMgc2VudCB0byBtZSAtIA0KDQpodHRw
czovL3d3dy50aGVyZWdpc3Rlci5jby51ay8yMDE4LzA1LzMwL2dpdF92dWxuZXJhYmlsaXR5X2Nv
dWxkX2xlYWRfdG9fYW5fYXR0YWNrX29mX3RoZV9yZXBvX2Nsb25lcy8NCmh0dHBzOi8vd3d3LmRl
Ymlhbi5vcmcvc2VjdXJpdHkvMjAxOC9kc2EtNDIxMg0KDQpUaGUgb25lIHRoYXQgSSBjb3VsZCBm
aW5kIGZyb20gb25saW5lIHdhczoNCmh0dHBzOi8vZ2l0LXNjbS5jb20vZG93bmxvYWQvbWFjDQoN
CkJ1dCwgdGhlIGxhdGVzdCB2ZXJzaW9uIGF2YWlsYWJsZSBvbiB0aGlzIHNpdGUgd2FzIDIuMTcu
MCwgd2hpY2ggZG9lcyBub3QgaW5jbHVkZSB0aGUgc2VjdXJpdHkgcGF0Y2guDQoNClRoYW5rIHlv
dSwNCkVyaWthDQoNCg0K77u/T24gNS8zMS8xOCwgODo1OSBBTSwgIlJhbmRhbGwgUy4gQmVja2Vy
IiA8cnNiZWNrZXJAbmV4YnJpZGdlLmNvbT4gd3JvdGU6DQoNCiAgICBPbiBNYXkgMzEsIDIwMTgg
MTE6NTcgQU0sIEVyaWthIFZvc3Mgd3JvdGU6DQogICAgPiBUaGVyZSB3YXMgYW4gYXJ0aWNsZSBJ
IGNhbWUgYWNyb3NzIHllc3RlcmRheSBpZGVudGlmeWluZyBhIHZ1bG5lcmFiaWxpdHkgdG8NCiAg
ICA+IHBhdGNoIG91ciBHaXQgZW52aXJvbm1lbnRzLiAgSSBkb27igJl0IHNlZSBvbmUgdGhhdCBp
cyBhdmFpbGFibGUgZm9yIG91ciBNYWMNCiAgICA+IENsaWVudHMgLSBpcyB0aGVyZSBhIG1vcmUg
cmVjZW50IG9uZSB0aGF0IEkgY2FuIGRvd25sb2FkIHRoYXQgaXMgYXZhaWxhYmxlIHRvDQogICAg
PiBwYXRjaCB0aGUgMi4xNy4wIHZlcnNpb24/DQogICAgDQogICAgRG8geW91IGhhdmUgYSByZWZl
cmVuY2UsIENWRSBudW1iZXIsIG9yIG90aGVyIGluZm9ybWF0aW9uIGFib3V0IHRoaXMgdnVsbmVy
YWJpbGl0eT8NCiAgICANCiAgICBDaGVlcnMsDQogICAgUmFuZGFsbA0KICAgIA0KICAgIC0tIEJy
aWVmIHdob2FtaToNCiAgICAgTm9uU3RvcCBkZXZlbG9wZXIgc2luY2UgYXBwcm94aW1hdGVseSAy
MTEyODg0NDQyMDAwMDAwMDANCiAgICAgVU5JWCBkZXZlbG9wZXIgc2luY2UgYXBwcm94aW1hdGVs
eSA0MjE2NjQ0MDANCiAgICAtLSBJbiBteSByZWFsIGxpZmUsIEkgdGFsayB0b28gbXVjaC4NCiAg
ICANCiAgICANCiAgICANCiAgICANCg0K
