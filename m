Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F8561F462
	for <e@80x24.org>; Fri, 31 May 2019 14:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfEaO4R (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 10:56:17 -0400
Received: from mail-eopbgr710130.outbound.protection.outlook.com ([40.107.71.130]:48379
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726501AbfEaO4R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 10:56:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=VpPbSIZeMowJT7MAzKBUDftf69ZwBofiR5hO8xUemY27A4z4XvVrHt6OfqfEs+qZoDFVCh3N20SHxrNDu6ErjQ2/lJVmtHmi5ks9e7de7gcfr4Q8U5DLnwgibG8ZUZeE8CaXzNEuoGY9reyIiZXmxR4/jjbQfKktXcJ4i6Jog6I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN6DvdJR7mBSUF81HK5N4+1s3g/U7kU70rEhxOB/X6s=;
 b=RB+vxWKM/+wVjGEaxa3gGULlcHeYdrftHQFe9mbUnPotyIeNiBlB3C6u2l2pjb+TcJZNcWtvDNajFoa+14mkf5QoL2VGJhMPg/GywnN+Gh8mw2fyFYTp2WhDgC6Kyc5Qaydj8h84bkXsBPfhMg0ud5soGLKt7RSPknNUD+5MRfM=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN6DvdJR7mBSUF81HK5N4+1s3g/U7kU70rEhxOB/X6s=;
 b=KH/OnXW8NTPUXbVNVbJj6Cf/dUQuIIB+MsFROuFSWtLa5YXAsrTkqfbNtb0JyUs55vqbkhcesuAja60R5rs+GAVFYl0LjKA2kUqMQB0MvU4KMMoFD5BosE3E8IOUj254DSrP90lBmUXglUeXZ2R71sY5XvuQab3AHuwitP5M1D8=
Received: from BN8PR21MB1156.namprd21.prod.outlook.com (2603:10b6:408:73::11)
 by BN8PR21MB1137.namprd21.prod.outlook.com (2603:10b6:408:71::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.1; Fri, 31 May
 2019 14:56:12 +0000
Received: from BN8PR21MB1156.namprd21.prod.outlook.com
 ([fe80::2147:f6c0:c7f:30e1]) by BN8PR21MB1156.namprd21.prod.outlook.com
 ([fe80::2147:f6c0:c7f:30e1%7]) with mapi id 15.20.1965.003; Fri, 31 May 2019
 14:56:12 +0000
From:   Cliff Schomburg <clisc@microsoft.com>
To:     Patryk Obara <dreamer.tan@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Simple shortcut for "git push --set-upstream origin
 newBranchName"
Thread-Topic: Simple shortcut for "git push --set-upstream origin
 newBranchName"
Thread-Index: AdUXME7sW+dzzd+8STqmdbLpESwchwABfZYAAAAnfwAAIhlQgAAAP3sAAAAXsKA=
Date:   Fri, 31 May 2019 14:56:12 +0000
Message-ID: <BN8PR21MB115693C381F65E97AB65FA18B7190@BN8PR21MB1156.namprd21.prod.outlook.com>
References: <BN8PR21MB1156ED141AE2662BC5328A22B7180@BN8PR21MB1156.namprd21.prod.outlook.com>
 <BN8PR21MB1156F593DAEBD7194DA7041EB7180@BN8PR21MB1156.namprd21.prod.outlook.com>
 <BN8PR21MB1156DA1893F64814F1BE8709B7180@BN8PR21MB1156.namprd21.prod.outlook.com>
 <BN8PR21MB1156F7F3E7EFF9C8A60F33D0B7190@BN8PR21MB1156.namprd21.prod.outlook.com>
 <ac62f96f-0ebc-2dff-3365-781e6b9142a3@gmail.com>
In-Reply-To: <ac62f96f-0ebc-2dff-3365-781e6b9142a3@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=clisc@microsoft.com; 
x-originating-ip: [24.182.67.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eca1ddf3-35fe-4738-968f-08d6e5d81fbb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BN8PR21MB1137;
x-ms-traffictypediagnostic: BN8PR21MB1137:
x-microsoft-antispam-prvs: <BN8PR21MB1137202385766521DB3895C6B7190@BN8PR21MB1137.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(346002)(376002)(13464003)(199004)(189003)(186003)(71200400001)(71190400001)(26005)(52536014)(5660300002)(10090500001)(2501003)(66066001)(6116002)(3846002)(446003)(33656002)(486006)(11346002)(316002)(6436002)(66446008)(66946007)(73956011)(76116006)(66476007)(22452003)(64756008)(66556008)(25786009)(55016002)(86362001)(476003)(229853002)(8676002)(256004)(4744005)(8936002)(81166006)(53936002)(81156014)(7736002)(6246003)(9686003)(305945005)(99286004)(10290500003)(76176011)(14454004)(102836004)(74316002)(7696005)(2906002)(52396003)(110136005)(6506007)(53546011)(68736007)(478600001)(8990500004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1137;H:BN8PR21MB1156.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PHjdM2UCrAIKeOVgrd+H5I4z+PrR+vmGIkrsFg6LCTpMwCy2mHZ7boBVtuHLYRV2yhdtgKcJzc0AhiKhmiVadxnFtqmbtcaM6W3ktbVuqs6V2Ebtc+GqM3p3wKMs4psk/ZL9K3+Ro5b1aiWR/s2Zmy3/Xpn2axAKCUEZXLBON1cGsv8ltuHbV4Z2US/w1ijbu8CCEuOGQLi9Tr5M2aDL/RG7Apbxmkrc8EUbmWmO4M2dpH8pQDRBDGxqAFDUBizSGZ8rBRGG2NWb4FAmiWGDDtOE9sMj0YXuLp2xAocbQu3VnXVn9cDEGny4xFhhouiPsrA/Q/nfjB5dlk07+WFiUkfLbUG3ktj64MfYRyCWNR13g8h8pmRXTp9TXNhU0t3J19hn1pZJtfF60JsqT5ho+PenFQP+aJFUJQNm9AE2nVg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca1ddf3-35fe-4738-968f-08d6e5d81fbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 14:56:12.5089
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

V293LCBJIGRpZCBub3Qgc2VlIHRoYXQgaW4gdGhlIG1hbiBwYWdlcy4uLiBidXQgSSBzZWUgaXQg
bm93LiAgVGhhbmtzIQ0KDQpTbyBJIGd1ZXNzIEkgd291bGQgY2hhbmdlIG15IGFzayB0byB0aGlz
Og0KDQoiZ2l0IHB1c2ggLXUiDQoNClNob3VsZCBkZWZhdWx0IHRvICJvcmlnaW4gYnJhbmNoIiBp
ZiBubyBwYXJhbWV0ZXJzIGFyZSBwcm92aWRlZC4gIFRob3VnaHRzPw0KDQpUaGFua3MsDQpDbGlm
Zg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUGF0cnlrIE9iYXJhIDxkcmVh
bWVyLnRhbkBnbWFpbC5jb20+IA0KU2VudDogRnJpZGF5LCBNYXkgMzEsIDIwMTkgMTA6NTEgQU0N
ClRvOiBDbGlmZiBTY2hvbWJ1cmcgPGNsaXNjQG1pY3Jvc29mdC5jb20+OyBnaXRAdmdlci5rZXJu
ZWwub3JnDQpTdWJqZWN0OiBSZTogU2ltcGxlIHNob3J0Y3V0IGZvciAiZ2l0IHB1c2ggLS1zZXQt
dXBzdHJlYW0gb3JpZ2luIG5ld0JyYW5jaE5hbWUiDQoNCk9uIDMxLzA1LzIwMTkgMTY6NDUsIENs
aWZmIFNjaG9tYnVyZyB3cm90ZToNCj4gSSdtIHByb3Bvc2luZyBhIHNob3J0Y3V0IGZvciB0aGlz
IGNvbW1hbmQuDQoNCldoYXQncyB3cm9uZyB3aXRoICIkIGdpdCBwdXNoIC11IG9yaWdpbiBicmFu
Y2giPw0KDQotLQ0KUGF0cnlrIE9iYXJhDQo=
