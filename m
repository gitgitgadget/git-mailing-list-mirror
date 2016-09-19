Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 699E22070F
	for <e@80x24.org>; Mon, 19 Sep 2016 20:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753156AbcISUNw (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 16:13:52 -0400
Received: from mail-by2on0086.outbound.protection.outlook.com ([207.46.100.86]:19314
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753103AbcISUNv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 16:13:51 -0400
Received: from YQXPR01MB0023.CANPRD01.PROD.OUTLOOK.COM (10.165.130.13) by
 YQXPR01MB0021.CANPRD01.PROD.OUTLOOK.COM (10.165.130.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.629.8; Mon, 19 Sep 2016 20:13:48 +0000
Received: from YQXPR01MB0023.CANPRD01.PROD.OUTLOOK.COM ([10.165.130.13]) by
 YQXPR01MB0023.CANPRD01.PROD.OUTLOOK.COM ([10.165.130.13]) with mapi id
 15.01.0629.006; Mon, 19 Sep 2016 20:13:48 +0000
From:   Paul Williamson <paul.williamson@mediamiser.com>
To:     Jacob Keller <jacob.keller@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Switching branches not working in a cloned repo
Thread-Topic: Switching branches not working in a cloned repo
Thread-Index: AdISfZQ3kSlGE8JHQfuYXxD9ERxQOgAMW5sAAACkPeA=
Date:   Mon, 19 Sep 2016 20:13:48 +0000
Message-ID: <YQXPR01MB00235F24FF4BF39B9DDB252B9EF40@YQXPR01MB0023.CANPRD01.PROD.OUTLOOK.COM>
References: <YQXPR01MB0023CDCFA27BDD4959B4F9B19EF40@YQXPR01MB0023.CANPRD01.PROD.OUTLOOK.COM>
 <CA+P7+xqR6i6eieVrEHXMNuVo6yfmRRZqX8RdVAE7y4=xSLLYyA@mail.gmail.com>
In-Reply-To: <CA+P7+xqR6i6eieVrEHXMNuVo6yfmRRZqX8RdVAE7y4=xSLLYyA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paul.williamson@mediamiser.com; 
x-originating-ip: [72.143.112.138]
x-ms-office365-filtering-correlation-id: cfe44c18-bbd8-41b6-7f8c-08d3e0c97761
x-microsoft-exchange-diagnostics: 1;YQXPR01MB0021;6:0KaMbJTHJsYZscoVV+1qdP+ZBjHIHkAR4CYlCvEQBBzXUJ5eBZwqicwGG7RO97bWJRyqEDxqFR5Elu+lM/SnwnKdeNZkK4ZxlIOD0OIt1gMv0a+CsB4d356CUS4Ok2TnYmcgOEki3lYW+t8TFxmQJ3K3E/lY651QgN8sbn/S6aScwxQxEbOWhqxyuhqmXi3s4G3CuXE39jf13R7DQwXMdZslSKBOQQ8UPv74djukGetzAKsq8m0nLCyc3W33+EFjBWl+V5UYOLOOfu6fvK0GVwi1kTI9//8TXKDPZOKQrs30Xzkl9MYdE5teCE3UMX6I;5:M5sDp1ApcZP1MpNhe6TiYqBAyKicmuncVJYs/SYW7CHMM15TFGYjCVr4/BoxVLF9DI6mgOrST/4i6wsyedUCj8uuhfm9Y9unlSRZibhKBEUWaOWvAm5TbS7T9yxA7A9MZ7DGX8ug1aAXoHBkvdChEQ==;24:C+VjIu6XhXxFO1ou6gErrebf5XTuRYJVSAaIoS6X1FXDPAUfIGSPt++YZIUg7BmWnwrGBDCrhuc1EmV/9xWh9ny1pGak/y2HEj4UfLDke0I=;7:uuIKAw6KW187hHhY//NZY7xoxZ+NzVQSmxyOoSbLYb+mvqG97OWQjCEbGS2IVTSGqpNtlIy5qwXEsmH+8NlQ0VhjAoOSbIaWsSWscKp0+sx4Krr7YxL5P49fxB7ZBPbpcYgzwuJ6jliyZnRM1V3xBGCpcsWGxkWR9zrSO6VKCBWUZyCgIrB9t5J7ufCQYCl/u54iKbvdKjvzcu+7bq1re7r85V2yWpSMGHv/iC2FAaqDd5dMQ2eHKOaPB5HJZ9nx0xz5KovrL9ce6utaXVpzQCs2toS/jbljeTAIELyebQoV7h+VdKYAp1aCa7svbWjo
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:YQXPR01MB0021;
x-microsoft-antispam-prvs: <YQXPR01MB00211B87B933C81E70E889B69EF40@YQXPR01MB0021.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040176)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6043046)(6042046);SRVR:YQXPR01MB0021;BCL:0;PCL:0;RULEID:;SRVR:YQXPR01MB0021;
x-forefront-prvs: 0070A8666B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(7916002)(199003)(189002)(52314003)(13464003)(4326007)(7696004)(3846002)(305945005)(2906002)(102836003)(92566002)(7736002)(7846002)(6116002)(105586002)(11100500001)(74316002)(87936001)(586003)(86362001)(10400500002)(66066001)(8676002)(81156014)(81166006)(5002640100001)(8936002)(19580395003)(122556002)(110136003)(77096005)(3660700001)(19580405001)(5660300001)(68736007)(2950100001)(189998001)(97736004)(54356999)(106356001)(76176999)(101416001)(9686002)(2900100001)(50986999)(3280700002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:YQXPR01MB0021;H:YQXPR01MB0023.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: mediamiser.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mediamiser.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2016 20:13:48.4167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9009f71a-c1b6-4b55-a665-0aeb582e95d3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB0021
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEphY29iIEtlbGxlciBbbWFpbHRvOmph
Y29iLmtlbGxlckBnbWFpbC5jb21dIA0KDQo+VHJ5IGEgZnJlc2ggY2xvbmUgd2l0aCAiZ2l0IGNo
ZWNrb3V0IC0tdHJhY2sgb3JpZ2luL3dlYl9kZXYiIGFuZCB0aGVuIGEgImdpdCBzdGF0dXMgLXYi
IGFuZCBsZXQgdXMga25vdyB3aGF0IGhhcHBlbnMuIEkgc3VzcGVjdCB0aGF0IG9sZGVyIGNsb25l
cyBoYXZlIHRoZSBjb3JyZWN0IGJyYW5jaGVzIGFscmVhZHkgc2V0dXAgZm9yIHRyYWNraW5nLCBi
dXQgdGhlIG5ldyBjbG9uZSA+aXNuJ3QgZG9pbmcgaXQgYXV0b21hdGljYWxseSwgc28gd2hlbiB5
b3UgcnVuIGdpdCBjaGVja291dCB3ZWJfZGV2IHlvdSdyZSBqdXN0IGNyZWF0aW5nIGEgbmV3IGxv
Y2FsIGNvcHkuDQoNCkhpIEpha2UsIHRoaXMgd29ya2VkIQ0KDQpZb3VyIGV4cGxhbmF0aW9uIHNl
ZW1zIGNvcnJlY3QgLSBJIGNvdWxkIHN0aWxsIGxpc3QgdGhlIHJlbW90ZSBicmFuY2hlcywgdGhh
bmtzIHRvIHRoZSBjb21tYW5kIHRoYXQgUGhpbGlwIHN1Z2dlc3RlZCwgYnV0IHRoZSBsaW5rYWdl
IGJldHdlZW4gdGhlIHR3byB3YXMgbm90IHRoZXJlIGJ5IGRlZmF1bHQgZm9yIHNvbWUgcmVhc29u
LiBWZXJ5IHN0cmFuZ2UsIEkgaGF2ZSBuZXZlciBzZWVuIHRoYXQgaGFwcGVuIGJlZm9yZS4NCg0K
QW55d2F5LCB0aGlzIHNvbHV0aW9uIGlzIHNvdW5kIGFuZCBzZWVtcyB0byBzZXQgZXZlcnl0aGlu
ZyAoaGlzdG9yeSBldGMpIGJhY2sgdG8gaG93IGl0IHNob3VsZCBiZS4NCg0KVGhhbmtzIHZlcnkg
bXVjaCBmb3IgeW91ciBoZWxwIQ0KDQpQYXVsDQo=
