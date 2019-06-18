Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_IMPORTANCE_HIGH,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE5CD1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 14:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfFRObv (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 10:31:51 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:13160 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727584AbfFRObv (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 18 Jun 2019 10:31:51 -0400
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5IET4F2019598;
        Tue, 18 Jun 2019 14:31:50 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 2t70j0gruw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jun 2019 14:31:49 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id 48F916B;
        Tue, 18 Jun 2019 14:31:49 +0000 (UTC)
Received: from G9W8666.americas.hpqcorp.net (16.220.49.25) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 18 Jun 2019 14:31:48 +0000
Received: from G9W9209.americas.hpqcorp.net (2002:10dc:429c::10dc:429c) by
 G9W8666.americas.hpqcorp.net (2002:10dc:3119::10dc:3119) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 18 Jun 2019 14:31:47 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G9W9209.americas.hpqcorp.net (16.220.66.156) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 18 Jun 2019 14:31:48 +0000
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM (10.169.47.13) by
 TU4PR8401MB0815.NAMPRD84.PROD.OUTLOOK.COM (10.169.45.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 18 Jun 2019 14:31:47 +0000
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7d08:b407:2c60:393]) by TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7d08:b407:2c60:393%4]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 14:31:47 +0000
From:   "Vanak, Ibrahim" <ibrahim.vanak@hpe.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: GIT issue while cloning (fatal: pack is corrupted (SHA1
 mismatch)) !!!
Thread-Topic: GIT issue while cloning (fatal: pack is corrupted (SHA1
 mismatch)) !!!
Thread-Index: AdUVNK2vOdBL1LuLQeCX2A7XwcsEXwAAGetAAAD4WwAAEw7MAAAF1FgAAA1+/nAABZVi4AAFOOfwADhKkgACZUPI8AFbnsCg
Importance: high
X-Priority: 1
Date:   Tue, 18 Jun 2019 14:31:47 +0000
Message-ID: <TU4PR8401MB1216962E3F135E850E81E407E1EA0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
References: <TU4PR8401MB121664A8A588D799803F1E84E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190528093728.GA15106@sigill.intra.peff.net>
 <TU4PR8401MB1216A7B920D40B5063123A94E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190528213004.GF24650@sigill.intra.peff.net>
 <TU4PR8401MB12166DBE2156683ADF28E9A4E11F0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <TU4PR8401MB1216339F1E7A378C45DF9B36E11F0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190530115742.GC31607@sigill.intra.peff.net>
 <TU4PR8401MB12163C00148C39F0083C732DE1ED0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <TU4PR8401MB12163C00148C39F0083C732DE1ED0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.172.64.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b670084e-5d0c-4943-d9cf-08d6f3f9b1c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TU4PR8401MB0815;
x-ms-traffictypediagnostic: TU4PR8401MB0815:
x-microsoft-antispam-prvs: <TU4PR8401MB0815508EE5013467D7C4FB4FE1EA0@TU4PR8401MB0815.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(136003)(39860400002)(376002)(53754006)(189003)(199004)(13464003)(8676002)(256004)(7696005)(68736007)(66476007)(99286004)(76116006)(478600001)(6916009)(66446008)(66556008)(64756008)(9686003)(33656002)(11346002)(305945005)(25786009)(66946007)(71200400001)(74316002)(476003)(6246003)(53936002)(7736002)(486006)(14454004)(3846002)(4326008)(71190400001)(6116002)(66066001)(5660300002)(446003)(316002)(73956011)(102836004)(2906002)(55016002)(76176011)(86362001)(229853002)(8936002)(81166006)(53546011)(6506007)(26005)(6436002)(81686011)(52536014)(186003)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0815;H:TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DUpchJxzxCOTv+t5XVl9hW5sGJhjLjC+0YTQ6gU0JCwM11ZJV+8rn+NWbq4jKF1KkWx4Y0F/BcZE9CHeYuH5Xuqg2CeSVA+wVRE2SHIvjLWp+SwqoItkHSPzkCFH/s5l2QBxw/p5rKAQWUDVIPss25l6s25RpkH2J6FVjlN1Bk3PecM2uzfAZwxJJ64ZMxSMqN9upHTXrfcYfc2nBgQA4crC9mhLwOipTi6AdWlDETDSVeWdrqQR1xdwTNvGflLqirtGhs6fXEanjtDLZ7YyVzSiWtRzDA+k+oLRfQ/n7WrKtov7zv8G4jLZEbhU/a2tJ9zWCv3p38Q8dmF0EQ/4yotqWSbEsPzU4hvT4leeJA0UiUe+UvHmklyXKhF8U1W4SEPiZsuyZHSnHg/89uRy1yh8PcR7misruSOCQqCmaLI=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-Network-Message-Id: b670084e-5d0c-4943-d9cf-08d6f3f9b1c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 14:31:47.3461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibrahim.vanak@hpe.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0815
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906180117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8gQUxMIGFnYWluLA0KDQpIYXMgYW55b25lIHRlc3RlZCB0aGUgcGVyZm9ybWFuY2Ugb2Yg
R0lUIG9uIEhQLVVYIHBsYXRmb3JtPyBDYW4gc29tZW9uZSBwbGVhc2UgbG9vayBpbnRvIHRoZSBp
c3N1ZSB3ZSBhcmUgc2VlaW5nLg0KDQpUaGFua3MsDQpJYnJhaGltDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBWYW5haywgSWJyYWhpbSANClNlbnQ6IFR1ZXNkYXksIEp1bmUg
MTEsIDIwMTkgMTA6MDkgUE0NClRvOiBKZWZmIEtpbmcgPHBlZmZAcGVmZi5uZXQ+DQpDYzogZ2l0
QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUkU6IEdJVCBpc3N1ZSB3aGlsZSBjbG9uaW5nIChm
YXRhbDogcGFjayBpcyBjb3JydXB0ZWQgKFNIQTEgbWlzbWF0Y2gpKSAhISENCg0KVGhhbmsgUGVm
Zi4gVW5mb3J0dW5hdGVseSBJIGFtIGxpdmluZyB3aXRoIHRoaXMgaXNzdWUsIG5vIG9uZSBhYmxl
IHRvIGZpbmQgb3V0IHdoYXQgaXMgY2F1c2luZyB0aGlzIHNpZ25pZmljYW50IGRlbGF5LiBSZS1p
bml0aWF0aW5nIHRoaXMgdGhyZWFkIGlmIHNvbWVvbmUgY2FuIGhlbHAgb24gdGhpcy4NCg0KVGhh
bmtzICYgUmVnYXJkcywNCklicmFoaW0gVmFuYWsNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IEplZmYgS2luZyBbbWFpbHRvOnBlZmZAcGVmZi5uZXRdDQpTZW50OiBUaHVyc2Rh
eSwgTWF5IDMwLCAyMDE5IDU6MjggUE0NClRvOiBWYW5haywgSWJyYWhpbSA8aWJyYWhpbS52YW5h
a0BocGUuY29tPg0KQ2M6IGdpdEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBHSVQgaXNz
dWUgd2hpbGUgY2xvbmluZyAoZmF0YWw6IHBhY2sgaXMgY29ycnVwdGVkIChTSEExIG1pc21hdGNo
KSkgISEhDQoNCk9uIFdlZCwgTWF5IDI5LCAyMDE5IGF0IDA5OjA2OjE4QU0gKzAwMDAsIFZhbmFr
LCBJYnJhaGltIHdyb3RlOg0KDQo+IEFmdGVyIGNsb25pbmcgd2hlbiBJIHRyaWVkIHRvIGNoZWNr
b3V0IGEgYnJhbmNoIG9uIEhQVVggYW5kIExpbnV4LCBJIA0KPiBzdGlsbCBzaWduaWZpY2FudCB0
aW1lIGRpZmZlcmVuY2UgdGhlcmUgYXMgd2VsbCBldmVuIHRob3VnaCBuZXR3b3JrIGlzIA0KPiBu
b3QgaW52b2x2ZSBoZXJlLiBEbyB5b3Ugc3VzcGVjdCBhbnl0aGluZyB3aXRoIEhQVVggT1M/IERv
IHlvdSBoYXZlIA0KPiBhbnkgbWVjaGFuaXNtIHRvIGZpbmQgb3V0IHdobyBpcyB0aGUgY2F1c2lu
ZyBnaWdhbnRpYyBkZWxheSA/DQoNCklmIGl0J3MgaGFwcGVuaW5nIGZvciBqdXN0IGEgbG9jYWwg
Y2hlY2tvdXQgb3BlcmF0aW9uLCBJJ2Qgc3VzcGVjdCB2ZXJ5IHBvb3IgZmlsZXN5c3RlbSBwZXJm
b3JtYW5jZS4gT24gTGludXgsIEknZCBydW4gaXQgdW5kZXIgInBlcmYiIHRvIHNlZSB3aGVyZSB0
aGUgdGltZSBpcyBnb2luZy4gT3IgcG9zc2libHkgInN0cmFjZSAtVCIgdG8gdGltZSBzeXN0ZW0g
Y2FsbHMuIEkgZG9uJ3Qga25vdyB3aGF0IHRvb2xzIGFyZSBhdmFpbGFibGUgdW5kZXIgSFAtVVgg
Zm9yIHRoYXQga2luZCBvZiBwcm9maWxpbmcuDQoNCi1QZWZmDQo=
