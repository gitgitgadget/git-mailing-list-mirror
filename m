Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 382301F462
	for <e@80x24.org>; Tue, 11 Jun 2019 16:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390926AbfFKQje (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 12:39:34 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:50220 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388531AbfFKQje (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Jun 2019 12:39:34 -0400
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BGQE6o028601;
        Tue, 11 Jun 2019 16:39:26 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 2t2fg9rksu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jun 2019 16:39:26 +0000
Received: from G9W9210.americas.hpqcorp.net (g9w9210.houston.hpecorp.net [16.220.66.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id BED5D53;
        Tue, 11 Jun 2019 16:39:25 +0000 (UTC)
Received: from G9W9210.americas.hpqcorp.net (2002:10dc:429b::10dc:429b) by
 G9W9210.americas.hpqcorp.net (2002:10dc:429b::10dc:429b) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 11 Jun 2019 16:39:25 +0000
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G9W9210.americas.hpqcorp.net (16.220.66.155) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 11 Jun 2019 16:39:25 +0000
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM (10.169.47.13) by
 TU4PR8401MB0542.NAMPRD84.PROD.OUTLOOK.COM (10.169.42.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Tue, 11 Jun 2019 16:39:24 +0000
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6c61:bb5d:e04b:dc38]) by TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6c61:bb5d:e04b:dc38%4]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 16:39:24 +0000
From:   "Vanak, Ibrahim" <ibrahim.vanak@hpe.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: GIT issue while cloning (fatal: pack is corrupted (SHA1
 mismatch)) !!!
Thread-Topic: GIT issue while cloning (fatal: pack is corrupted (SHA1
 mismatch)) !!!
Thread-Index: AdUVNK2vOdBL1LuLQeCX2A7XwcsEXwAAGetAAAD4WwAAEw7MAAAF1FgAAA1+/nAABZVi4AAFOOfwADhKkgACZUPI8A==
Date:   Tue, 11 Jun 2019 16:39:24 +0000
Message-ID: <TU4PR8401MB12163C00148C39F0083C732DE1ED0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
References: <TU4PR8401MB121664A8A588D799803F1E84E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190528093728.GA15106@sigill.intra.peff.net>
 <TU4PR8401MB1216A7B920D40B5063123A94E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190528213004.GF24650@sigill.intra.peff.net>
 <TU4PR8401MB12166DBE2156683ADF28E9A4E11F0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <TU4PR8401MB1216339F1E7A378C45DF9B36E11F0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190530115742.GC31607@sigill.intra.peff.net>
In-Reply-To: <20190530115742.GC31607@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.172.121.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7595f3df-0dc5-4046-ac13-08d6ee8b5cb6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TU4PR8401MB0542;
x-ms-traffictypediagnostic: TU4PR8401MB0542:
x-microsoft-antispam-prvs: <TU4PR8401MB0542F826ABD13C38D8FCCC90E1ED0@TU4PR8401MB0542.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(136003)(189003)(199004)(13464003)(66946007)(76176011)(14454004)(6506007)(4326008)(53936002)(6246003)(478600001)(102836004)(53546011)(74316002)(33656002)(66066001)(316002)(66556008)(64756008)(66446008)(5660300002)(76116006)(73956011)(6916009)(66476007)(52536014)(2906002)(7736002)(3846002)(11346002)(68736007)(186003)(55016002)(26005)(305945005)(9686003)(6116002)(446003)(71200400001)(256004)(81166006)(229853002)(99286004)(7696005)(8676002)(486006)(6436002)(25786009)(81156014)(8936002)(476003)(86362001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0542;H:TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fOXSOCtQ4LaCqvtccYnVRy//+Mp19yZmS1loqXacY/5ovbkc1RV9Zyi/0bQemZ+Md+B1BIjaF4IIyrOcDD7Gu89TS59m7Rj/W/Ogdt0h+QzTafZLetf66wQgnJp6O7svKua91tFTqB8fn6PQzArvEvrJEnabIGQB4S2/0MzN1Z9vqSjfZ/9JJrEav+L5mC/WSXq7It6X+24+PP9GCE6P4ShFA3Sgb//yD80PCI/OAXzkC26nk7/gTRzQaJjToBHSrk5wS6I6z3udd/L8v7Dn1oVHGDdfKemtvz0VgyC/Y4Q5gFb7y48A2MqrLmEFQrKLkpX4V7oGFHVhDHb4/5IKEWKDxwKW2MQtoGU286zvC/0l99CHC4UmilqOidN83n7CXMT3TdnVJXOB0z2sn/DOSyMHl5GJ72bk1lAVmxFbMIo=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-Network-Message-Id: 7595f3df-0dc5-4046-ac13-08d6ee8b5cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 16:39:24.0862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibrahim.vanak@hpe.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0542
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110106
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmsgUGVmZi4gVW5mb3J0dW5hdGVseSBJIGFtIGxpdmluZyB3aXRoIHRoaXMgaXNzdWUsIG5v
IG9uZSBhYmxlIHRvIGZpbmQgb3V0IHdoYXQgaXMgY2F1c2luZyB0aGlzIHNpZ25pZmljYW50IGRl
bGF5LiBSZS1pbml0aWF0aW5nIHRoaXMgdGhyZWFkIGlmIHNvbWVvbmUgY2FuIGhlbHAgb24gdGhp
cy4NCg0KVGhhbmtzICYgUmVnYXJkcywNCklicmFoaW0gVmFuYWsNCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IEplZmYgS2luZyBbbWFpbHRvOnBlZmZAcGVmZi5uZXRdIA0KU2Vu
dDogVGh1cnNkYXksIE1heSAzMCwgMjAxOSA1OjI4IFBNDQpUbzogVmFuYWssIElicmFoaW0gPGli
cmFoaW0udmFuYWtAaHBlLmNvbT4NCkNjOiBnaXRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBS
ZTogR0lUIGlzc3VlIHdoaWxlIGNsb25pbmcgKGZhdGFsOiBwYWNrIGlzIGNvcnJ1cHRlZCAoU0hB
MSBtaXNtYXRjaCkpICEhIQ0KDQpPbiBXZWQsIE1heSAyOSwgMjAxOSBhdCAwOTowNjoxOEFNICsw
MDAwLCBWYW5haywgSWJyYWhpbSB3cm90ZToNCg0KPiBBZnRlciBjbG9uaW5nIHdoZW4gSSB0cmll
ZCB0byBjaGVja291dCBhIGJyYW5jaCBvbiBIUFVYIGFuZCBMaW51eCwgSSANCj4gc3RpbGwgc2ln
bmlmaWNhbnQgdGltZSBkaWZmZXJlbmNlIHRoZXJlIGFzIHdlbGwgZXZlbiB0aG91Z2ggbmV0d29y
ayBpcyANCj4gbm90IGludm9sdmUgaGVyZS4gRG8geW91IHN1c3BlY3QgYW55dGhpbmcgd2l0aCBI
UFVYIE9TPyBEbyB5b3UgaGF2ZSANCj4gYW55IG1lY2hhbmlzbSB0byBmaW5kIG91dCB3aG8gaXMg
dGhlIGNhdXNpbmcgZ2lnYW50aWMgZGVsYXkgPw0KDQpJZiBpdCdzIGhhcHBlbmluZyBmb3IganVz
dCBhIGxvY2FsIGNoZWNrb3V0IG9wZXJhdGlvbiwgSSdkIHN1c3BlY3QgdmVyeSBwb29yIGZpbGVz
eXN0ZW0gcGVyZm9ybWFuY2UuIE9uIExpbnV4LCBJJ2QgcnVuIGl0IHVuZGVyICJwZXJmIiB0byBz
ZWUgd2hlcmUgdGhlIHRpbWUgaXMgZ29pbmcuIE9yIHBvc3NpYmx5ICJzdHJhY2UgLVQiIHRvIHRp
bWUgc3lzdGVtIGNhbGxzLiBJIGRvbid0IGtub3cgd2hhdCB0b29scyBhcmUgYXZhaWxhYmxlIHVu
ZGVyIEhQLVVYIGZvciB0aGF0IGtpbmQgb2YgcHJvZmlsaW5nLg0KDQotUGVmZg0K
