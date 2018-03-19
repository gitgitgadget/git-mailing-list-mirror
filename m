Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4201F404
	for <e@80x24.org>; Mon, 19 Mar 2018 12:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755270AbeCSM4Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 08:56:24 -0400
Received: from mail-sn1nam01on0086.outbound.protection.outlook.com ([104.47.32.86]:55552
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755058AbeCSM4X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 08:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aei.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/CPK/gqxCh204aLtvZeef3cfRqjia4hDSLFcmu3X4Xk=;
 b=HWqKAYo5Wt7RlOCYjkRT8lhiU9CUsSZA+4F0ynZVZ+Z7yXFRcS/upujx8pZkuZ+sz+Yh4OqXxCYIKEouo1AiCT8YXBd7E+Wl4Z1391Dn/R5W97mh5H+qqbYopOt/T+Ai+Ouzkl8hYH0UsRmNegBsRQHu1CAMs+p1JSGz9ZyGvX0=
Received: from CY4PR02MB2262.namprd02.prod.outlook.com (10.169.181.15) by
 CY4PR02MB3191.namprd02.prod.outlook.com (10.165.88.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.588.14; Mon, 19 Mar 2018 12:56:20 +0000
Received: from CY4PR02MB2262.namprd02.prod.outlook.com
 ([fe80::68ff:36cb:be97:49ee]) by CY4PR02MB2262.namprd02.prod.outlook.com
 ([fe80::68ff:36cb:be97:49ee%17]) with mapi id 15.20.0588.017; Mon, 19 Mar
 2018 12:56:20 +0000
From:   "Briggs, John" <JOHN.BRIGGS@aei.com>
To:     Bryan Turner <bturner@atlassian.com>
CC:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "git-for-windows@googlegroups.com" <git-for-windows@googlegroups.com>
Subject: RE: getting fatal error trying to open git gui
Thread-Topic: getting fatal error trying to open git gui
Thread-Index: AdO9WOQXVglR2Ht0QsiCtxNKgnqGlAACC9gAAADf8BAAAQndgAAAEKvQAADwrQAAhSMj8A==
Date:   Mon, 19 Mar 2018 12:56:20 +0000
Message-ID: <CY4PR02MB22621A5F713D150BCF4BDE71FFD40@CY4PR02MB2262.namprd02.prod.outlook.com>
References: <CY4PR02MB22621DE7751427686029C1B3FFD70@CY4PR02MB2262.namprd02.prod.outlook.com>
 <20180316195756.GA151588@aiede.svl.corp.google.com>
 <CY4PR02MB2262A567EE2D2A54316BFE3FFFD70@CY4PR02MB2262.namprd02.prod.outlook.com>
 <20180316205243.GB151588@aiede.svl.corp.google.com>
 <CY4PR02MB2262A382E033B50B3800A69CFFD70@CY4PR02MB2262.namprd02.prod.outlook.com>
 <CAGyf7-HmO_URV3kuB2t=PJ7Wf=t9UjAOYbpCLkUNiDPGQ7ca-g@mail.gmail.com>
In-Reply-To: <CAGyf7-HmO_URV3kuB2t=PJ7Wf=t9UjAOYbpCLkUNiDPGQ7ca-g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcamJyaWdnc1xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWVhMGY3MTRkLTJiNzQtMTFlOC1hOTA3LWQ0ODFkN2E2MmViNlxhbWUtdGVzdFxlYTBmNzE0Zi0yYjc0LTExZTgtYTkwNy1kNDgxZDdhNjJlYjZib2R5LnR4dCIgc3o9IjE0ODkiIHQ9IjEzMTY1OTM3Nzc4ODAyMDU0MCIgaD0iN1JEdkg5UXZXTWdaZ2hoTW5KendhbDdvZ0tNPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOHN.BRIGGS@aei.com; 
x-originating-ip: [8.39.233.11]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR02MB3191;7:YCL9ROKVPCfbFLaNAYD2DM3OJYcjzhmfK1rId5VA0X2XD2NuMZyig3XpR1ec3X2xe0FEFekKXNG8teXgoU6WGT1seEbp9sDSIDjd7oAee75jYUkJeh5aurriOrpCVce4d91b4qb8IeWv0IWVRjbh1CQTJoSS0LP8YRW5JfSz1tMwc48nzyK0ZSKbu8fOrIHS0N2tMDEVZqIISCswd6yEzfSwhJx5k0G5W0MTBkGi8AFVF5sEmmo5NWpMw885+qsL;20:gYOM+MkVU7g8JTGKUFw2TZNWSF4jSiVZcLS8g1sa63AjBHeasm/IvjDE3IvsZMfJHG+5Cdvuk+w4Qr2dFdAl+77mxjsKfICnPQOrqrLLzggpQn+OyxdSaZAzAYqyupEi0nD4Hpb6kq00f89ZIYHuS8VGvMoZoSV4DE6AeDgGRAY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 58367e55-40c7-4426-ed4e-08d58d98cff1
x-microsoft-antispam: UriScan:(215639381216008)(28748798796193);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:CY4PR02MB3191;
x-ms-traffictypediagnostic: CY4PR02MB3191:
x-ms-exchange-orgnaization-bypassclutter: true
x-microsoft-antispam-prvs: <CY4PR02MB31919940713AF2DC04C4F193FFD40@CY4PR02MB3191.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(215639381216008)(253373257661254)(9452136761055)(85827821059158)(28748798796193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR02MB3191;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB3191;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(39850400004)(396003)(376002)(346002)(13464003)(199004)(189003)(55016002)(99286004)(26005)(6916009)(316002)(186003)(6436002)(86362001)(9686003)(53546011)(54906003)(6506007)(7696005)(6246003)(5660300001)(105586002)(76176011)(53936002)(229853002)(93886005)(102836004)(2950100002)(3280700002)(97736004)(2900100001)(68736007)(305945005)(74316002)(33656002)(5250100002)(7736002)(8936002)(81156014)(81166006)(66066001)(8676002)(4326008)(14454004)(72206003)(478600001)(25786009)(2906002)(6116002)(3846002)(39060400002)(3660700001)(106356001)(460985005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB3191;H:CY4PR02MB2262.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: aei.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fVYEl/9kZl+PxfuHSvH+CfClrzu9BWwjhTp0zw0P9tg0SjQIuMMNQbFd/eNPq1uV6uHOdCEQiQK+QPFBP6Nvh7rwp3fg+pzZRXyAUlZtT7SmZp18KR8ekbouApT36zZVDTDS8BZ4gPSeoXDe45pl7WJBIIseVDUO8w8vlVW1PNGXzLsmKoJRR1zfr26DSTLO824U1SH+HOPjgjcFx/lja0zLJiIw9RGtqXlLCBIONqX+VJdUzaNcR/7KUx1Y8Q/zji6+iyo2YeDODf56HaWttkJwnbbU/Ib4zxW9SpVDd/LH932+BPz2Cm8cBrtnlZj4lSjWJoGD6YXcfIhvgRrp2w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aei.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58367e55-40c7-4426-ed4e-08d58d98cff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 12:56:20.5139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cfa7d515-0462-4766-8d7f-867b7825994a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3191
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSB1c2VkIEdpdC0yLjE2LjItNjQtYml0LmV4ZSB0byBpbnN0YWxsLiBJIHVzZWQgYWxsIGRlZmF1
bHRzIGV4Y2VwdCBmb3IgZWRpdG9yLCB3aGVyZSBJIGNob3NlIE5vdHBhZCsrLg0KDQpKb2huDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBCcnlhbiBUdXJuZXIgPGJ0dXJuZXJA
YXRsYXNzaWFuLmNvbT4gDQpTZW50OiBGcmlkYXksIE1hcmNoIDE2LCAyMDE4IDM6MjIgUE0NClRv
OiBCcmlnZ3MsIEpvaG4gPEpPSE4uQlJJR0dTQGFlaS5jb20+DQpDYzogSm9uYXRoYW4gTmllZGVy
IDxqcm5pZWRlckBnbWFpbC5jb20+OyBnaXRAdmdlci5rZXJuZWwub3JnOyBnaXQtZm9yLXdpbmRv
d3NAZ29vZ2xlZ3JvdXBzLmNvbQ0KU3ViamVjdDogUmU6IGdldHRpbmcgZmF0YWwgZXJyb3IgdHJ5
aW5nIHRvIG9wZW4gZ2l0IGd1aQ0KDQpPbiBGcmksIE1hciAxNiwgMjAxOCBhdCAyOjAxIFBNLCBC
cmlnZ3MsIEpvaG4gPEpPSE4uQlJJR0dTQGFlaS5jb20+IHdyb3RlOg0KPiBObywgaXQgd2FzIGEg
ZnJlc2ggaW5zdGFsbC4gIFBsdXMgZmlsZSBzZWFyY2ggcmV2ZWFscyBvbmx5IG9uZSBjb3B5IG9m
IHRoZSBmaWxlLg0KPg0KPiBJIGFsc28gbm90aWNlZCB0aGF0IEkgY2Fubm90IHVzZSB0aGUgZmls
ZSBwcm9wZXJ0aWVzIHRvIHJ1biBhcyBhZG1pbmlzdHJhdG9yLiBJIG11c3QgcmlnaHQtY2xpY2sg
b24gR2l0IEdVSSBhbmQgc2VsZWN0ICJNb3JlID4+IFJ1biBhcyBhZG1pbmlzdHJhdG9yIiBpbiB0
aGUgc3RhcnQgbWVudS4gRXZlbiB0aG91Z2ggSSBoYXZlICJydW4gYXMgYWRtaW5pc3RyYXRvciIg
Y2hlY2tlZCBvbiBib3RoIHNob3J0Y3V0IGFuZCB0aGUgcHJvZ3JhbSAob3IgYW55IGNvbWJvIG9m
KS4NCg0KWW91IGRlZmluaXRlbHkgc2hvdWxkbid0IG5lZWQgdG8gcnVuIGl0IGFzIGFuIGFkbWlu
aXN0cmF0b3IgYXQgYWxsLiBJIGhhdmUgdGhlIHNhbWUgdmVyc2lvbiBpbnN0YWxsZWQ6DQoNCiQg
Z2l0IHZlcnNpb24NCmdpdCB2ZXJzaW9uIDIuMTYuMi53aW5kb3dzLjENCg0KUnVubmluZyBHaXQg
R1VJIGZyb20gdGhlIFN0YXJ0IG1lbnUsIGl0IHN0YXJ0cyB3aXRob3V0IGEgVUFDIHByb21wdCAo
d2hpY2ggbWVhbnMgaXQncyBub3QgcnVubmluZyBhcyBBZG1pbmlzdHJhdG9yKSBhbmQgcnVucyB3
aXRob3V0IGlzc3VlLiBTdGFydGluZyBpdCBmcm9tIGEgbm9uLWVzY2FsYXRlZCBjb21tYW5kIHBy
b21wdCB2aWEgImdpdCBndWkiDQphbHNvIGRvZXMgbm90IGhhdmUgYSBVQUMgcHJvbXB0IGFuZCBy
dW5zIHdpdGhvdXQgaXNzdWUuDQoNClNlZW1zIGxpa2UgdGhlcmUgbXVzdCBiZSBzb21ldGhpbmcg
bW9yZSBnb2luZyBvbi4gV2hhdCBvcHRpb25zIGRpZCB5b3Ugc2VsZWN0IGR1cmluZyBpbnN0YWxs
YXRpb24/IFdoYXQgaW5zdGFsbGVyIGRpZCB5b3UgdXNlPw0KDQpCcnlhbg0K
