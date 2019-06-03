Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D63E1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 21:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfFCVng (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 17:43:36 -0400
Received: from mail-eopbgr740129.outbound.protection.outlook.com ([40.107.74.129]:22976
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726055AbfFCVng (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 17:43:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=jiZv46g2SIpzw/RryknSY2qHms2JEN/go/RPN3cZDbcrFLu2cmil1RwgsRig50DzBkMW6RjEJfULOaHcQcrMHXeb7MAdkiL/9DhZ7fbiyY+o9ZHTbV3FA9Bl7m9F9L7J6pWEHiMgyLBuOxA40If/kVm5OzFcVYI34sXpH3HchGM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdueSGM3to4xXbUKbI9iKRwC5t9vU1+kPY8+yoQJYqI=;
 b=Dop3WoQDCZM5d7wCdeYZgtnRCVonXMT6QyPfbc45yBOdc/7V+c/FAwEWoRPvsTG0895oyAcSU8kyncsppWUt947OBwsiGyZOFRZaLHCxk1zDsI8FFyO0rKk+onSG/bPHh3FCeJgwGF1xlDAG/TXaOeQDvOnOk2k+AYuSxwhhCGE=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdueSGM3to4xXbUKbI9iKRwC5t9vU1+kPY8+yoQJYqI=;
 b=JXoPY6A+FsF9WZMUktyW60vh/1OgzIGWZpL6lgS4UBk1nPyv5+prCPCmZamP6IZ3i2weCrNer6Dy2SGBB/zi1hFdP6GEkI5QfwV9znB+KbTiw8MSAXDiVCvwed+f4e8Nf6ek1GfLuzjul10FTE7dS9bq8Et6JBWuHr9rPW6xL+8=
Received: from BN8PR21MB1156.namprd21.prod.outlook.com (2603:10b6:408:73::11)
 by BN8PR21MB1137.namprd21.prod.outlook.com (2603:10b6:408:71::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.3; Mon, 3 Jun
 2019 21:34:26 +0000
Received: from BN8PR21MB1156.namprd21.prod.outlook.com
 ([fe80::2147:f6c0:c7f:30e1]) by BN8PR21MB1156.namprd21.prod.outlook.com
 ([fe80::2147:f6c0:c7f:30e1%6]) with mapi id 15.20.1987.003; Mon, 3 Jun 2019
 21:34:26 +0000
From:   Cliff Schomburg <clisc@microsoft.com>
To:     Patryk Obara <dreamer.tan@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Simple shortcut for "git push --set-upstream origin
 newBranchName"
Thread-Topic: Simple shortcut for "git push --set-upstream origin
 newBranchName"
Thread-Index: AdUXME7sW+dzzd+8STqmdbLpESwchwABfZYAAAAnfwAAIhlQgAAAP3sAAAAXsKAAAGgqAAAAPcTgAKQjJ/A=
Date:   Mon, 3 Jun 2019 21:34:26 +0000
Message-ID: <BN8PR21MB11569B2A49F0ACB69E883458B7140@BN8PR21MB1156.namprd21.prod.outlook.com>
References: <BN8PR21MB1156ED141AE2662BC5328A22B7180@BN8PR21MB1156.namprd21.prod.outlook.com>
 <BN8PR21MB1156F593DAEBD7194DA7041EB7180@BN8PR21MB1156.namprd21.prod.outlook.com>
 <BN8PR21MB1156DA1893F64814F1BE8709B7180@BN8PR21MB1156.namprd21.prod.outlook.com>
 <BN8PR21MB1156F7F3E7EFF9C8A60F33D0B7190@BN8PR21MB1156.namprd21.prod.outlook.com>
 <ac62f96f-0ebc-2dff-3365-781e6b9142a3@gmail.com>
 <BN8PR21MB115693C381F65E97AB65FA18B7190@BN8PR21MB1156.namprd21.prod.outlook.com>
 <ebc03b4e-daf8-d47f-94ca-a4a549589773@gmail.com>
 <BN8PR21MB1156D785177A40EA7D8341ABB7190@BN8PR21MB1156.namprd21.prod.outlook.com>
In-Reply-To: <BN8PR21MB1156D785177A40EA7D8341ABB7190@BN8PR21MB1156.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=clisc@microsoft.com; 
x-originating-ip: [24.182.67.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3898ef99-717b-461e-4893-08d6e86b40ff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BN8PR21MB1137;
x-ms-traffictypediagnostic: BN8PR21MB1137:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN8PR21MB11379E257824EA15F5B178C5B7140@BN8PR21MB1137.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(39860400002)(376002)(13464003)(199004)(189003)(6436002)(6506007)(256004)(55016002)(74316002)(66476007)(25786009)(102836004)(22452003)(316002)(53546011)(66446008)(66556008)(64756008)(6306002)(9686003)(229853002)(66946007)(73956011)(6116002)(3846002)(10090500001)(76116006)(486006)(8990500004)(966005)(11346002)(66066001)(71200400001)(71190400001)(53936002)(2501003)(446003)(14454004)(476003)(478600001)(68736007)(26005)(6246003)(52536014)(5660300002)(10290500003)(186003)(76176011)(8936002)(86362001)(52396003)(7696005)(2906002)(7736002)(305945005)(33656002)(81166006)(110136005)(8676002)(99286004)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1137;H:BN8PR21MB1156.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9be6MxZl4wydkXSTXBi/zKz0a3Dq3oDecfSH8K/9nBLNHDDInHmdonFqF0S+IZHF3q55Olag5eYNraKdtBl93by4UzkqNB82ELCinrOPzBZQT5/d3fUo1sZzxKJq4L5QbV4gMG+aPOfvOEoOhEASlzHm36gvCpge43NX27ys5RyzMwt0Si4DhkBEMpQXy6Bwwwgy4dxhhlWs0BdjnBn1q8LbdjgixqUARjZcrpkZyueOG4psCo6sMN+dOhIxU4USA1vBuy15BoEV4kyTBuKvyhtRy/zxVdG+oCX+56HHqTWtXNB5sW/eAcBhbFwexXQz3RiUSpHIQydCJ4aHJj44S7hEHNdItn161/rrL43hddXHFOtISmSQU14Yg35VA6bgBoWOxwH6K836O0zSjeHn5xO8lzN6drSSeJdWi0BZuF8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3898ef99-717b-461e-4893-08d6e86b40ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 21:34:26.7261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clisc@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1137
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

U28gSSBnYXZlIHRoaXMgYSB0cnkgYW5kIGl0IHNlZW1zIG5vdCB0byBiZSBiZWhhdmluZyBhcyBl
eHBlY3RlZDoNCg0KPmdpdCBwdXNoIC11DQpmYXRhbDogVGhlIGN1cnJlbnQgYnJhbmNoIHticmFu
Y2hOYW1lfSBoYXMgbm8gdXBzdHJlYW0gYnJhbmNoLg0KVG8gcHVzaCB0aGUgY3VycmVudCBicmFu
Y2ggYW5kIHNldCB0aGUgcmVtb3RlIGFzIHVwc3RyZWFtLCB1c2UNCg0KICAgIGdpdCBwdXNoIC0t
c2V0LXVwc3RyZWFtIG9yaWdpbiB7YnJhbmNoTmFtZX0NCg0KSSdtIHVzaW5nIEdpdCBmb3IgV2lu
ZG93cyBpbiBhIFdpbmRvd3MgQ01EIHByb21wdCwgaWYgdGhhdCBtYXR0ZXJzIGF0IGFsbC4NCg0K
VGhhbmtzLG0NCkNsaWZmDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENs
aWZmIFNjaG9tYnVyZyANClNlbnQ6IEZyaWRheSwgTWF5IDMxLCAyMDE5IDExOjEzIEFNDQpUbzog
UGF0cnlrIE9iYXJhIDxkcmVhbWVyLnRhbkBnbWFpbC5jb20+OyBnaXRAdmdlci5rZXJuZWwub3Jn
DQpTdWJqZWN0OiBSRTogU2ltcGxlIHNob3J0Y3V0IGZvciAiZ2l0IHB1c2ggLS1zZXQtdXBzdHJl
YW0gb3JpZ2luIG5ld0JyYW5jaE5hbWUiDQoNClRoYW5rcywgUGF0cnlrLiAgSXQncyBhbHdheXMg
bmljZSB0byBzZWUgdGhlIGZlYXR1cmUgSSB3YW50IGlzIGFscmVhZHkgaW1wbGVtZW50ZWQhICDw
n5iKDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBQYXRyeWsgT2JhcmEgPGRy
ZWFtZXIudGFuQGdtYWlsLmNvbT4gDQpTZW50OiBGcmlkYXksIE1heSAzMSwgMjAxOSAxMTowNSBB
TQ0KVG86IENsaWZmIFNjaG9tYnVyZyA8Y2xpc2NAbWljcm9zb2Z0LmNvbT47IGdpdEB2Z2VyLmtl
cm5lbC5vcmcNClN1YmplY3Q6IFJlOiBTaW1wbGUgc2hvcnRjdXQgZm9yICJnaXQgcHVzaCAtLXNl
dC11cHN0cmVhbSBvcmlnaW4gbmV3QnJhbmNoTmFtZSINCg0KT24gMzEvMDUvMjAxOSAxNjo1Niwg
Q2xpZmYgU2Nob21idXJnIHdyb3RlOg0KPiBXb3csIEkgZGlkIG5vdCBzZWUgdGhhdCBpbiB0aGUg
bWFuIHBhZ2VzLi4uIGJ1dCBJIHNlZSBpdCBub3cuICBUaGFua3MhDQo+IA0KPiBTbyBJIGd1ZXNz
IEkgd291bGQgY2hhbmdlIG15IGFzayB0byB0aGlzOg0KPiANCj4gImdpdCBwdXNoIC11Ig0KPiAN
Cj4gU2hvdWxkIGRlZmF1bHQgdG8gIm9yaWdpbiBicmFuY2giIGlmIG5vIHBhcmFtZXRlcnMgYXJl
IHByb3ZpZGVkLg0KDQpJIHRoaW5rIG1vc3QgcGVvcGxlIHdpbGwgYWdyZWUsIGNvbnNpZGVyaW5n
IGl0IGFscmVhZHkgd29ya3MgdGhpcyB3YXkgOikNCg0KVGhlIGRlZmF1bHQgYmVoYXZpb3VyIG9m
IGdpdCBwdXNoIGNoYW5nZWQgaW4gR2l0IDIuMCwgcGVyaGFwcyB5b3Ugd2VyZSByZWFkaW5nIHNv
bWUgb2xkIHR1dG9yaWFsLiBZb3UgY2FuIGNvbmZpZ3VyZSBpdCB0byBtYXRjaCB5b3VyIHByZWZl
cmVuY2VzIGJ5IGNoYW5naW5nIHB1c2guZGVmYXVsdCB2YWx1ZSBpbiB5b3VyIGdpdCBjb25maWc6
DQoNCmh0dHBzOi8vbmFtMDYuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRmdpdC1zY20uY29tJTJGZG9jcyUyRmdpdC1jb25maWclMjNEb2N1bWVudGF0
aW9uJTJGZ2l0LWNvbmZpZy50eHQtcHVzaGRlZmF1bHQmYW1wO2RhdGE9MDIlN0MwMSU3Q2NsaXNj
JTQwbWljcm9zb2Z0LmNvbSU3Q2Y1MmQ2OTljM2ZjMTQ5ZDIwZGU1MDhkNmU1ZDk2YTRjJTdDNzJm
OTg4YmY4NmYxNDFhZjkxYWIyZDdjZDAxMWRiNDclN0MxJTdDMCU3QzYzNjk0OTExOTI4OTc3MDgz
OCZhbXA7c2RhdGE9SzJOZXp3T1d6WnJxc1U3bDhHeWJqYkp1d21SbkMybGxUNzdVaHZGJTJCOFJV
JTNEJmFtcDtyZXNlcnZlZD0wDQoNCi0tDQpQYXRyeWsgT2JhcmENCg==
