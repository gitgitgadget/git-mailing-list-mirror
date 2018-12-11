Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AAB420A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 00:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeLKAmZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 19:42:25 -0500
Received: from mo-csw1514.securemx.jp ([210.130.202.153]:60412 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbeLKAmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 19:42:25 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id wBB0gMcx020522; Tue, 11 Dec 2018 09:42:22 +0900
X-Iguazu-Qid: 34tMYWMHxQFkFaOpAh
X-Iguazu-QSIG: v=2; s=0; t=1544488941; q=34tMYWMHxQFkFaOpAh; m=UltHW97Sc2yj47JLPalZGBInSx57P2+X6OtEVR1vp3g=
Received: from gwmailsv1.oki.co.jp (okigate.oki.co.jp [202.226.91.194])
        by relay.securemx.jp (mx-mr1511) id wBB0g1XJ023023;
        Tue, 11 Dec 2018 09:42:21 +0900
Received: by gwmailsv1.oki.co.jp (Postfix, from userid 0)
        id 7F483CF898; Tue, 11 Dec 2018 09:42:21 +0900 (JST)
Received: from s24c62.dm1.oii.oki.co.jp (localhost.localdomain [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 49D33150ADD2;
        Tue, 11 Dec 2018 09:42:21 +0900 (JST)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01lp2053.outbound.protection.outlook.com [104.47.125.53])
        by s24c62.dm1.oii.oki.co.jp (Postfix) with ESMTP id D6E84150AE9A;
        Tue, 11 Dec 2018 09:42:20 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oki365.onmicrosoft.com; s=selector1-oki-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oU0d9j4WamKMUxIUwYb6/xp61q6c/Oh+akxjcgcYw+s=;
 b=C84Mf5j+ONy4lOA3xqZ8HEox43jsFQzNh311wTTgTdfonrNKXb0wOqm1uKweORc73lW3vGQfCa3Hno7bC0rW0cxPyNf9qtGljwPvTKY9wevcrTODFY5MDsxOSRSfWjfZHJ2jZlrAWd5X/BjgaVFyRPyqnEsaWdGlrPS06GbudUU=
Received: from TY2PR01MB2700.jpnprd01.prod.outlook.com (20.177.96.83) by
 TY2PR01MB2972.jpnprd01.prod.outlook.com (20.177.98.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 00:42:19 +0000
Received: from TY2PR01MB2700.jpnprd01.prod.outlook.com
 ([fe80::6518:9914:43d3:c516]) by TY2PR01MB2700.jpnprd01.prod.outlook.com
 ([fe80::6518:9914:43d3:c516%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 00:42:19 +0000
From:   =?utf-8?B?5q2m5LqVIOWFi+aYjg==?= <takei744@oki.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Questions about ubifs,ubi and mtd?
Thread-Topic: Questions about ubifs,ubi and mtd?
Thread-Index: AdSQgt7XzXPTMw3JRJybNXlGyOJFFAAFEZoAABSkp2A=
Date:   Tue, 11 Dec 2018 00:42:19 +0000
Message-ID: <TY2PR01MB2700640A3797C10A905F9EA79DA60@TY2PR01MB2700.jpnprd01.prod.outlook.com>
References: <TY2PR01MB2700AD659601C0341B5C06929DA50@TY2PR01MB2700.jpnprd01.prod.outlook.com>
 <87o99txwvp.fsf@evledraar.gmail.com>
In-Reply-To: <87o99txwvp.fsf@evledraar.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcaGMwNzc0OTVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy05YTQzZDA5Zi1mY2RkLTExZTgtYmNlYy1kNDZkNmRjNTc4YzVcYW1lLXRlc3RcOWE0M2QwYTAtZmNkZC0xMWU4LWJjZWMtZDQ2ZDZkYzU3OGM1Ym9keS50eHQiIHN6PSIxNzc2IiB0PSIxMzE4ODk2MjUzNzk1MDQ0MjUiIGg9InN3S25FVWIyUDlyQnNMVUJQZTcrWmdCb2FkVT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=takei744@oki.com; 
x-originating-ip: [202.226.91.114]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR01MB2972;20:u5LdDS9/LcnXZVh0ivQTAia91lUCEU0lX10n5u5JRbrEyy59P5U55dkJD40dAhTTlpLuiSfC9H+t18UKu4XPC3PsETFmoCQCdqJ7VLnTPgeXssiLpw5s0foVQh7mKy6RZiiJosKe+uCdybyC+TammWVxuE4ugv0u9xx14Nwq89E=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f039aff2-c797-44e8-9d4b-08d65f01819e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB2972;
x-ms-traffictypediagnostic: TY2PR01MB2972:
x-microsoft-antispam-prvs: <TY2PR01MB29722A08514524924478745E9DA60@TY2PR01MB2972.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231455)(999002)(944501520)(4982022)(52105112)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:TY2PR01MB2972;BCL:0;PCL:0;RULEID:;SRVR:TY2PR01MB2972;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(366004)(396003)(199004)(189003)(53754006)(13464003)(478600001)(2906002)(1411001)(14454004)(86362001)(6436002)(966005)(229853002)(85182001)(97736004)(33656002)(81156014)(6916009)(25786009)(8676002)(105586002)(81166006)(6116002)(3846002)(8936002)(316002)(486006)(102836004)(476003)(11346002)(26005)(446003)(7696005)(99286004)(66066001)(53546011)(71190400001)(14444005)(71200400001)(6506007)(76176011)(74316002)(5660300001)(4326008)(305945005)(6246003)(6306002)(53936002)(9686003)(66574011)(39060400002)(186003)(345774005)(256004)(68736007)(106356001)(7736002)(55016002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:TY2PR01MB2972;H:TY2PR01MB2700.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: oki.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YdcXOvXqRipYDvo/pGn0H7yVAqny2AIxoQythEFpgeGUSYXkSRj88STa2OaCpUDhmCh8B19ZsybWkylrnc5QE4rWn5LTmoyJLKyJjiUW3V1lB2oVWBoAj/YZWIvqYO6YiNWpdIfA1NussJZTUg8MlKYBlnC1Qjgo5iHkyoUKDDPHCBFu/v18h/9Vvgns4+u9mI6T9I6H51bDfGA+OmDyj5t1JGcMCqrKOGQyADNrKU9DNNuQ4kGh+F7Dpdf1bcabMDfsoVIpyC7Gun6ZTx8O6fX8HhAAWNp+veFE1UjHvCXsoDPpwjiGmI5pK1VWXvn7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oki.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f039aff2-c797-44e8-9d4b-08d65f01819e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 00:42:19.2995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e23be703-cb62-4f3f-96f6-127abea71aef
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2972
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RGVhciDDhnZhciBBcm5masO2csOwIEJqYXJtYXNvbiwNCg0KIFRoYW5rIHlvdSBmb3IgeW91ciBh
ZHZpY2UuDQogSSB3aWxsIGFzayBteSBxdWVzdGlvbiB0byBNTCB3aG8gdG9sZCBtZS4NCg0KQmVz
dCByZWdhcmRzLA0KS2F0c3Vha2kgVGFrZWkvT2tpIEVsZWN0cmljIEluZHVzdHJ5IENvLiwgTHRk
Li9KUA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IMOGdmFyIEFybmZq
w7Zyw7AgQmphcm1hc29uIDxhdmFyYWJAZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIERlY2Vt
YmVyIDEwLCAyMDE4IDExOjQ3IFBNDQo+IFRvOiDmrabkupUg5YWL5piOIDx0YWtlaTc0NEBva2ku
Y29tPg0KPiBDYzogZ2l0QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogUXVlc3Rpb25z
IGFib3V0IHViaWZzLHViaSBhbmQgbXRkPw0KPiANCj4gDQo+IE9uIE1vbiwgRGVjIDEwIDIwMTgs
IOatpuS6lSDlhYvmmI4gd3JvdGU6DQo+IA0KPiA+IEhpIGFsbCwNCj4gPg0KPiA+IFdlIGFyZSBk
ZXZlbG9waW5nIHRoZSBwcm9kdWN0IHVzaW5nIGZpbGUgc3lzdGVtIHVzaW5nIHViaSwgdWJpZnMg
b24gaGFyZHdhcmUNCj4gd2l0aCBOQU5EIGZsYXNoIG1lbW9yeS4NCj4gPg0KPiA+IEFsdGhvdWdo
IHRoZSBkZXZlbG9wbWVudCBvZiB0aGUgcHJvZHVjdCB3YXMgY29tcGxldGVkLCB3ZSBhcmUgc2Vl
a2luZw0KPiB5b3VyIGhlbHAgYXMgdGhlIGN1c3RvbWVyIHdobyBpcyB1c2luZyBpdCBpcyBoYXZp
bmcgdHJvdWJsZSB3aXRoIGl0Lg0KPiA+DQo+ID4gVGhlIHByb2R1Y3Qgd2UgaGF2ZSBkZXZlbG9w
ZWQgaGFzIDYgTVREIHBhcnRpdGlvbnMgZm9yIE5BTkQgZmxhc2gNCj4gbWVtb3J5Lg0KPiA+IFRo
ZXNlIGNvbnNpc3Qgb2YgNiBNVERzIG5hbWVkICdrZXJuZWwtYScgJ2tlcm5lbC1iJywgJ3Jvb3Rm
cy1hJywgJ3Jvb3Rmcy1iJywNCj4gJ2RhdGEtMScsICdkYXRhLTInLCBhbmQgb25saW5lIHByb2dy
YW0gb25seSBhY2Nlc3NlcyAnZGF0YS0xJyBhbmQgJ2RhdGEtMicgZm9yDQo+IHdyaXRlIGFjY2Vz
cy4NCj4gPiBOZXZlcnRoZWxlc3MsIHdoZW4gbG9hZGluZyBvdXIgcHJvZ3JhbSBmcm9tICdyb290
ZnMtYScsIHRyeWluZyB0byByZWFkDQo+ID4gdGhlIGlub2RlIHdpdGggdGhlIHViaWZzX3JlYWRf
bm9kZSgpIGZ1bmN0aW9uIHdpbGwgcmVzdWx0IGluICJiYWQgbm9kZQ0KPiA+IHR5cGUiIChleDog
MTkzIGJ1dCBleHBlY3RlZCA5KSBhbmQgdGhlIExFQiBjYW4gbm90IGJlIHJlYWQgd2l0aCB0aGUN
Cj4gPiBleHBlY3RlZCB2YWx1ZS4gKEV2ZW4gdGhvdWdoIHlvdSBkbyBub3QgaGF2ZSB3cml0ZSBh
Y2Nlc3MgdG8gcm9vdGZzKQ0KPiA+DQo+ID4gSXMgdGhlcmUgYW55b25lIHdobyBlbmNvdW50ZXJl
ZCBzdWNoIGEgcHJvYmxlbT8gSXMgdGhlcmUgcGF0Y2g/DQo+ID4NCj4gPiBQbGVhc2UgbGV0IG1l
IGtub3csIGlmIHlvdSBoYXZlIGFueSBxdWVzdGlvbnMuDQo+ID4NCj4gPiBCZXN0IHJlZ2FyZHMs
DQo+ID4gS2F0c3Vha2kgVGFrZWkvT2tpIEVsZWN0cmljIEluZHVzdHJ5IENvLiwgTHRkLi9KUA0K
PiANCj4gSGkuIEkgdGhpbmsgeW91J3JlIG9uIHRoZSB3cm9uZyBtYWlsaW5nIGxpc3QgKGdpdEAp
LiBZb3UgcHJvYmFibHkgd2FudCB0byBjb250YWN0DQo+IG9uZSBvZiB0aGUgbGludXggbGlzdHMs
IHBlcmhhcHMNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1tdGQgPw0K
