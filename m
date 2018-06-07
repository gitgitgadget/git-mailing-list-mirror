Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D61E41F403
	for <e@80x24.org>; Thu,  7 Jun 2018 12:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932124AbeFGMqm (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 08:46:42 -0400
Received: from esa2.hc2413-78.iphmx.com ([216.71.148.46]:55168 "EHLO
        esa2.hc2413-78.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbeFGMqm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 08:46:42 -0400
X-IronPort-AV: E=Sophos;i="5.49,486,1520913600"; 
   d="scan'208";a="2699587"
X-Attachment_name: 
X-BodySize: 10005
Received: from mail-sn1nam01lp0113.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([207.46.163.113])
  by ob1.hc2413-78.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jun 2018 08:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aaane.onmicrosoft.com;
 s=selector1-aaanortheast-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bca/En0d5oaWg/+eRgDBmS31w6Iic/CMiqIpGIDWRR4=;
 b=WBZFx3WTkoHasgfbrz1f8S6hK0cbL6vvzMGHyBzpS33Hh0fvqVMGlUBXRbp9pBWz3P58sye496SaY27qD5MHrMIOMhA4/99Bu+sF3jtcL3sSi5z60Vn/rkLj03LdbhqwQtVNRC23GAGXqVjcGpGEh3jjSAlhKQR41O16jKbg4n0=
Received: from BN7PR15MB2339.namprd15.prod.outlook.com (52.132.217.158) by
 BN7PR15MB2324.namprd15.prod.outlook.com (52.132.217.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.13; Thu, 7 Jun 2018 12:46:40 +0000
Received: from BN7PR15MB2339.namprd15.prod.outlook.com
 ([fe80::ad23:ffbe:ed6b:a909]) by BN7PR15MB2339.namprd15.prod.outlook.com
 ([fe80::ad23:ffbe:ed6b:a909%6]) with mapi id 15.20.0841.011; Thu, 7 Jun 2018
 12:46:40 +0000
From:   "Heinz, Steve" <SHeinz@aaanortheast.com>
To:     Bryan Turner <bturner@atlassian.com>
CC:     Git Users <git@vger.kernel.org>
Subject: RE: git question from a newbie
Thread-Topic: git question from a newbie
Thread-Index: AdP9E4Hrau+PXdtYS1KEfyewyALLmQACR2IAAFAJZyA=
Date:   Thu, 7 Jun 2018 12:46:40 +0000
Message-ID: <BN7PR15MB23395DFAB46C52BE7F414B43BB640@BN7PR15MB2339.namprd15.prod.outlook.com>
References: <BN7PR15MB23394E6E4AB05C17287E8F55BB660@BN7PR15MB2339.namprd15.prod.outlook.com>
 <CAGyf7-GN=wx4cc7WxbmMweC0VSnp_9aZ8fTUGE0W6vLK63qpVw@mail.gmail.com>
In-Reply-To: <CAGyf7-GN=wx4cc7WxbmMweC0VSnp_9aZ8fTUGE0W6vLK63qpVw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=SHeinz@aaanortheast.com; 
x-originating-ip: [12.40.107.100]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR15MB2324;7:B1fccXVHu6AMBevWkh1L7iD31aORao+6yijvZWkzmEjS52aUlYLYlbp5wLNKo3Iluh2vMFoPMA99+W9im0RcXlhW/zzDEGY3pzZRbEi3FhYVbCwol8DxGh/HguG83q2GQaCWCZLKFOi8XIf0RXb/3lj46l8pstyycQuZISoEjtPm3nD1UFbQE2XUBRVuW5GIMnBX/e95iFm/+6yTRVXXM4U3/1F4cOtNqe/4kDBcQMU/YALZ6g6Pdx+Vv8UzWLzs
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR15MB2324;
x-ms-traffictypediagnostic: BN7PR15MB2324:
x-microsoft-antispam-prvs: <BN7PR15MB2324FB01C5EAE6F192741905BB640@BN7PR15MB2324.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(253373257661254)(166708455590820)(9452136761055)(107958610860442)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR15MB2324;BCL:0;PCL:0;RULEID:;SRVR:BN7PR15MB2324;
x-forefront-prvs: 06968FD8C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(346002)(376002)(366004)(13464003)(189003)(199004)(81166006)(81156014)(5660300001)(102836004)(99286004)(7736002)(6916009)(305945005)(86362001)(76176011)(66066001)(14454004)(186003)(6436002)(6506007)(53546011)(55016002)(2900100001)(74316002)(97736004)(229853002)(8936002)(7696005)(3846002)(6116002)(316002)(68736007)(26005)(8676002)(33656002)(966005)(6306002)(72206003)(478600001)(9686003)(59450400001)(80792005)(5890100001)(53936002)(105586002)(106356001)(446003)(6246003)(25786009)(2906002)(5250100002)(486006)(476003)(3280700002)(4326008)(11346002)(3660700001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR15MB2324;H:BN7PR15MB2339.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: aaanortheast.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: SEJvyxcz6wp4hGbDh6080SSPK1rbehAScWryQ54AlgIFKQIFSSk0UXEJ7vPaRMSng4m7ubGevp5vcVdDPlgvncO85mypmCj2QdDnSiatsgOEglju9wgTR4Y0XeojwE5QkMjdHSANUYzlzLCn2Pz+sJv7d5mrnGWs0S8NftCiLUvzMeHp2p+cPcOPnayDPGxy
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 95e202d4-4748-4fd9-6752-08d5cc74b71b
X-OriginatorOrg: aaanortheast.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e202d4-4748-4fd9-6752-08d5cc74b71b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2018 12:46:40.1661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ccc4f56-0dac-42a5-a6f6-467387e586c0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2324
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QnJ5YW4NCg0KVGhhbmsgeW91LiAgSSBkaWRuJ3QgcmVhbGl6ZSB0aGF0IHdoZW4geW91IHNldCB1
cCBhIHJlbW90ZSByZXBvc2l0b3J5LCBpdCBpcyBqdXN0IGEgZm9sZGVyLiAgSSB0aG91Z2h0IHRo
ZSBmYWN0IHRoYXQgSSBoYWQgaXQgc2V0dXAgYXMgYSB3ZWJzaXRlLCB3YXMgZ29pbmcgdG8gaGFu
ZGxlIHdoYXQgSSBuZWVkZWQuDQpJdCB3YXNuJ3QgdW50aWwgeW91ciBlbWFpbCB0aGF0IEkgcmVh
bGl6ZWQgSSBoYWQgdG8gdXNlIHNvbWUgdHlwZSBvZiBjbGllbnQuICBJIGluc3RhbGxlZCBCb25v
Ym8gYXMgdGhlIHJlbW90ZSByZXBvc2l0b3J5IGFuZCBiYW0gaXQgd29ya2VkIQ0KDQpZb3UgYXJl
IHJpZ2h0IHRoYXQgdGhlIGluZm8gb24gV2luZG93cyBpcyBhIGJpdCBzcGFyc2UuICBJIGxlYXJu
ZWQgYSBsb3QgYW5kIHdhbnQgdG8gdGhhbmsgeW91IGFnYWluLg0KDQpTdGV2ZSBIZWlueg0KDQoN
ClN0ZXZlIEhlaW56IHwgTGVhZCBQcm9ncmFtbWVyIEFuYWx5c3QsIEluZm9ybWF0aW9uIFRlY2hu
b2xvZ3kNCkFBQSBOb3J0aGVhc3QgfCAxNDE1IEtlbGx1bSBQbGFjZSB8IEdhcmRlbiBDaXR5LCBO
WSAxMTUzMA0KWDgwNDIgfCBUIDUxNi01MzUtMjU4MSB8IEYgNTE2LTg3My0yMjExDQpzaGVpbnpA
YWFhbm9ydGhlYXN0LmNvbSB8IEFBQS5jb20NCg0KDQogICAgIEl0IFBheXMgdG8gQmVsb25nLg0K
DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBCcnlhbiBUdXJuZXIgPGJ0dXJu
ZXJAYXRsYXNzaWFuLmNvbT4NClNlbnQ6IFR1ZXNkYXksIEp1bmUgMDUsIDIwMTggNjoyOSBQTQ0K
VG86IEhlaW56LCBTdGV2ZSA8U0hlaW56QGFhYW5vcnRoZWFzdC5jb20+DQpDYzogR2l0IFVzZXJz
IDxnaXRAdmdlci5rZXJuZWwub3JnPg0KU3ViamVjdDogUmU6IGdpdCBxdWVzdGlvbiBmcm9tIGEg
bmV3YmllDQoNCk9uIFR1ZSwgSnVuIDUsIDIwMTggYXQgMjozMyBQTSBIZWlueiwgU3RldmUgPFNI
ZWluekBhYWFub3J0aGVhc3QuY29tPiB3cm90ZToNCj4NCj4gSGkuDQo+DQo+IEkgYW0gbmV3IHRv
IEdpdCBhbmQgaGF2ZSByZWFkIHF1aXRlIGEgZmV3IGFydGljbGVzIG9uIGl0Lg0KPiBJIGFtIHBs
YW5uaW5nIG9uIHNldHRpbmcgdXAgYSByZW1vdGUgcmVwb3NpdG9yeSBvbiBhIHdpbmRvd3MgMjAx
MiBSMiBzZXJ2ZXIgYW5kIHdpbGwgYWNjZXNzIGl0IHZpYSBIVFRQUy4NCj4gSSBhbSBzZXR0aW5n
IHVwIGEgbG9jYWwgcmVwb3NpdG9yeSBvbiBteSBkZXNrIHRvcCAob3RoZXJzIGluIG15IGdyb3Vw
IHdpbGwgZG8gdGhlIHNhbWUpLg0KPiBPbiAic2VydmVyMSI6ICBJIGluc3RhbGwgR2l0IGFuZCBj
cmVhdGUgYSByZXBvc2l0b3J5ICJyZXBvcyIuDQo+IE9uICJzZXJ2ZXIxIjogIEkgY3JlYXRlIGEg
ZHVtbXkgd2VicGFnZSAiZGVmYXVsdC5odG0iIGFuZCBwbGFjZSBpdCBpbiB0aGUgcmVwbyBmb2xk
ZXIuDQo+IE9uICJzZXJ2ZXIxIjogIEkgY3JlYXRlIGEgd2ViIGFwcGxpY2F0aW9uIGluIElJUyBw
b2ludGluZyB0byBHaXQNCj4gT24gU2VydmVyMSI6ICAgY2hhbmdlIHBlcm1pc3Npb25zIHNvIElJ
U19Vc2VyICBoYXMgYWNjZXNzIHRvIHRoZSBmb2xkZXJzLg0KPiBPbiAic2VydmVyMSI6ICBpbnNp
ZGUgdGhlICJyZXBvcyIgZm9sZGVyIGFuZCByaWdodCBjbGljayBhbmQgY2hvb3NlICJiYXNoIGhl
cmUiDQo+IE9uICJzZXJ2ZXIxIjogICAkIGdpdCBpbml0ICAtYmFyZSAgICAoaXQncyByZWFsbHkg
MiBoeXBoZW5zKQ0KDQoNClRoaXMgbWlnaHQgY3JlYXRlIGEgX3JlcG9zaXRvcnlfLCBidXQgaXQn
cyBub3QgZ29pbmcgdG8gc2V0IHVwIGFueSBHaXQgaG9zdGluZyBwcm9jZXNzaW5nIGZvciBpdC4g
WW91IG1pZ2h0IGJlIGFibGUgdG8gY2xvbmUgdXNpbmcgdGhlIGZhbGxiYWNrIHRvIHRoZSAiZHVt
YiIgSFRUUCBwcm90b2NvbCAodGhvdWdoIEkgZG91YnQgaXQsIHdpdGggdGhlIHN0ZXBzIHlvdSd2
ZSBzaG93bikgLCBidXQgeW91IHdvbid0IGJlIGFibGUgdG8gcHVzaC4NCg0KWW91IG5lZWQgaGFu
ZGxlcnMgZm9yIGdpdC1odHRwLWJhY2tlbmQgd2hpY2ggaGFuZGxlIGluZm8vcmVmcyBhbmQgb3Ro
ZXIgcmVxdWVzdHMgdGhhdCBhcmUgcmVsYXRlZCB0byB0aGUgR2l0IEhUVFAgd2lyZSBwcm90b2Nv
bC5bMV0NCg0KRG9jdW1lbnRhdGlvbiBmb3Igc2V0dGluZyB1cCBHaXQncyBIVFRQIHByb3RvY29s
IHZpYSBBcGFjaGUgYXJlIHByZXR0eSBlYXN5IHRvIGZpbmRbMl0sIGJ1dCBJSVMgaW5zdHJ1Y3Rp
b25zIGFyZSBhIGJpdCBtb3JlIHNwYXJzZS4gSSBkb24ndCBrbm93IG9mIGFueSBnb29kIG9uZXMg
b2ZmIHRoZSB0b3Agb2YgbXkgaGVhZC4gQnV0IHRoYXQncyB5b3VyIGlzc3VlOyB5b3VyIElJUyBz
ZXR1cCBpc24ndCByZWFsbHkgYSB2YWxpZCBHaXQgcmVtb3RlOyBpdCdzIGp1c3QgYSBHaXQgcmVw
b3NpdG9yeSB3aXRoIGNvbnRlbnRzIHZpc2libGUgdmlhIEhUVFAuDQoNClsxXSBodHRwczovL2dp
dGh1Yi5jb20vZ2l0L2dpdC9ibG9iL21hc3Rlci9Eb2N1bWVudGF0aW9uL3RlY2huaWNhbC9odHRw
LXByb3RvY29sLnR4dA0KWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9naXQvZ2l0L2Jsb2IvbWFzdGVy
L0RvY3VtZW50YXRpb24vaG93dG8vc2V0dXAtZ2l0LXNlcnZlci1vdmVyLWh0dHAudHh0DQoNCkJy
eWFuDQpUaGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgZW1haWwgbWVzc2FnZSBpcyBp
bnRlbmRlZCBvbmx5IGZvciB0aGUgcHJpdmF0ZSBhbmQgY29uZmlkZW50aWFsIHVzZSBvZiB0aGUg
cmVjaXBpZW50KHMpIG5hbWVkIGFib3ZlLCB1bmxlc3MgdGhlIHNlbmRlciBleHByZXNzbHkgYWdy
ZWVzIG90aGVyd2lzZS4gSW4gbm8gZXZlbnQgc2hhbGwgQUFBIE5vcnRoZWFzdCBvciBhbnkgb2Yg
aXRzIGFmZmlsaWF0ZXMgYWNjZXB0IGFueSByZXNwb25zaWJpbGl0eSBmb3IgdGhlIGxvc3MsIHVz
ZSBvciBtaXN1c2Ugb2YgYW55IGluZm9ybWF0aW9uIGluY2x1ZGluZyBjb25maWRlbnRpYWwgaW5m
b3JtYXRpb24sIHdoaWNoIGlzIHNlbnQgdG8gQUFBIE5vcnRoZWFzdCBvciBpdHMgYWZmaWxpYXRl
cyB2aWEgZW1haWwsIG9yIGVtYWlsIGF0dGFjaG1lbnQuIEFBQSBOb3J0aGVhc3QgZG9lcyBub3Qg
Z3VhcmFudGVlIHRoZSBhY2N1cmFjeSBvZiBhbnkgZW1haWwgb3IgZW1haWwgYXR0YWNobWVudC4g
SWYgdGhlIHJlYWRlciBvZiB0aGlzIG1lc3NhZ2UgaXMgbm90IHRoZSBpbnRlbmRlZCByZWNpcGll
bnQgYW5kL29yIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZW1haWwgaW4gZXJyb3IsIHlvdSBtdXN0
IHRha2Ugbm8gYWN0aW9uIGJhc2VkIG9uIHRoZSBpbmZvcm1hdGlvbiBpbiB0aGlzIGVtYWlsIGFu
ZCB5b3UgYXJlIGhlcmVieSBub3RpZmllZCB0aGF0IGFueSBkaXNzZW1pbmF0aW9uLCBtaXN1c2Ug
b3IgY29weWluZyBvciBkaXNjbG9zdXJlIG9mIHRoaXMgY29tbXVuaWNhdGlvbiBpcyBzdHJpY3Rs
eSBwcm9oaWJpdGVkLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGNvbW11bmljYXRpb24gaW4g
ZXJyb3IsIHBsZWFzZSBub3RpZnkgdXMgaW1tZWRpYXRlbHkgYnkgZW1haWwgYW5kIGRlbGV0ZSB0
aGUgb3JpZ2luYWwgbWVzc2FnZS4NCg==
