Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFCED1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 20:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbeK1H2u (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 02:28:50 -0500
Received: from mx0a-00099f01.pphosted.com ([67.231.149.228]:35504 "EHLO
        mx0b-00099f01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726068AbeK1H2u (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Nov 2018 02:28:50 -0500
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Nov 2018 02:28:49 EST
Received: from pps.filterd (m0074058.ppops.net [127.0.0.1])
        by mx0a-00099f01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wARKDJ15019812
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 14:24:17 -0600
Received: from crexpp02.us.aegon.com (email1.aegonusa.com [162.123.17.223])
        by mx0a-00099f01.pphosted.com with ESMTP id 2p0pnf4cbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 14:24:17 -0600
Received: from pps.filterd (crexpp02.us.aegon.com [127.0.0.1])
        by crexpp02.us.aegon.com (8.16.0.22/8.16.0.22) with SMTP id wARK37lG010617
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 14:24:15 -0600
From:   "Moon, John" <john.moon@transamerica.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git difftool --dir-diff not saving new files copied from LOCAL to
 REMOTE
Thread-Topic: git difftool --dir-diff not saving new files copied from LOCAL
 to REMOTE
Thread-Index: AQHUho8pQYOhrxEMD0++gDp/GbzPGw==
Date:   Tue, 27 Nov 2018 20:24:12 +0000
Message-ID: <7E2121D5-C95D-4C38-A495-C9971678374F@transamerica.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.39.4.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR05MB4059;20:X40VXgllJ3JHeYkYgeHd0zDWP9uQgh/+SXnjcJ/lK2VSNAEtvqmqurO2YSRhwLOWgXutSF1eapAKgcN70uQ9CVymMLAJ7iwBkkddch8MT6hhipvmxE5N4kO45wHjbtikAnoMf5576Z/13gipA9+0hyWJeJ2H0GSTRLyhDOB+Pzk5YuYJ/bCtsHU3vo2wSUx81JcX1B+CYzX7AKsFiR7kZtDqAgEundoyeME/Il+2xxFvMdQKQMTI6VTIScjoI2c35bYe9pE28pgCMg7o3Dn3llY4P1yDkPeWtmtji6OSS5BlMfao2FnManAt2iyR4iRqrtY2t1lDcQpKwgai75R7P4/01fzbIa0qz15Nf6gLnzPGxhnzunAjlR8A67gl7M2SFUmLeCuA2Qvo49lizMfxtBnDWY+h0kUhTv/YlXFlbTJ/6AW6dJbX5aFPBP+XkLGenOrP9IAvJOo172BpSqJUyabnI4AYKkm9mI9SHfmDhojruwvY+/ZUnuB4qu3chBCT
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c540bbb9-7542-4b06-a347-08d654a64ba5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR05MB4059;
x-ms-traffictypediagnostic: DM6PR05MB4059:
x-microsoft-antispam-prvs: <DM6PR05MB405997AB429F68E4C665D0D191D00@DM6PR05MB4059.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231443)(944501430)(52105112)(10201501046)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM6PR05MB4059;BCL:0;PCL:0;RULEID:;SRVR:DM6PR05MB4059;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(53754006)(6512007)(2351001)(102836004)(66066001)(5640700003)(2906002)(99286004)(256004)(6436002)(86362001)(81166006)(1730700003)(6116002)(8936002)(8676002)(25786009)(82746002)(71190400001)(3846002)(7736002)(305945005)(33656002)(53936002)(81156014)(2501003)(97736004)(71200400001)(26005)(316002)(5660300001)(68736007)(6916009)(36756003)(6486002)(478600001)(186003)(486006)(6506007)(83716004)(14454004)(476003)(2616005)(106356001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR05MB4059;H:DM6PR05MB4986.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: transamerica.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: bnjWeHFXesGuvcDXCZeVZUxWHNRq1JzaKixFyJO3RJcyS+8vlTdq25Z2d8RcTjApGcH+qtbVhy3WfwPc5cU64Xu1V2AUDYHvkdC+KxAV+B9vMUplGm88IujUfXX+VgK3Z+H+zWG7RPFDIJE7A/AD5j2ktA805tLS7FJREYboYUMlDnY9j7I3v4RNzWAqvvWtsGx2DYwqqtPhUzBXpVqaSLqbPFADH0GmzS1rfU7+AoVWnI4tr/r4b77cWm7goy3GHhZGjBEFfyRuXUAwZhTn8vBWlTFoNlARF3MggrMKzr8ooIp/c2+NmpMvx45gi7ibYieY5A/gXteMRXSMiPPMGhHfLqv4Go2PW5pnaZhLdR4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <66A816D645DE494FB271C4F57312162F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c540bbb9-7542-4b06-a347-08d654a64ba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 20:24:12.8533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46e16835-c804-41de-be3c-55835d14dee4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4059
X-EXCLAIMER-MD-CONFIG: 7562670a-beab-4c6e-8ed2-ab3b5287c042
X-OriginatorOrg: transamerica.com
x-crexppdlp-TriggeredRule: module.access.rule.forcepoint_dlp_reroute v2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_17:,,
 signatures=0
X-VPM-MSG-ID: 59a4874a-db94-4cd6-baef-d06c1407bd2f
X-VPM-HOST: crexzx02.inet.nogea.local
X-VPM-GROUP-ID: 7d0af873-a78b-43f8-b105-41ee8379bb0b
X-VPM-ENC-REGIME: Plaintext
X-VPM-IS-HYBRID: 0
x-crexpp01-TriggeredRule: module.access.rule.Strip_Receive_HeadersV2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_16:,,
 signatures=0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_17:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgYWxsLA0KDQpJ4oCZbSB1c2luZyB2aW0gRGlyRGlmZiBwbHVnaW4gdG8gY29tcGFyZSAyIGJy
YW5jaGVzLiAgVGhpcyB3b3JrcyBncmVhdCBmb3IgdGhlIG1vc3QgcGFydCBleGNlcHQ6DQoNCldo
ZW4gSSBjb21wYXJlIGEgYnJhbmNoIHRvIHRoZSBjdXJyZW50IGJyYW5jaCAoZ2l0IGRpZmZ0b29s
IC10IHZpbURpckRpZmYgLS1kaXItZGlmZiBtYXN0ZXIpDQoNCklmIHRoZXJlIGlzIGEgZmlsZSB0
aGF0IGV4aXN0cyBpbiAkTE9DQUwgdGhhdCBpcyBub3QgaW4gJFJFTU9URSBJIGNvcHkgdGhlIGZp
bGUgaW50byAkUkVNT1RFLCBidXQgd2hlbiBJIGV4aXQgdGhlIGRpZmZ0b29sIHRoZSBmaWxlIGlz
IG5vdCBpbiB0aGUgY3VycmVudCBicmFuY2guICBJIHdvdWxkIGV4cGVjdCB0aGUgbmV3IGZpbGUg
dG8gYmUgdGhlcmUgc28gSSBjYW4gYWRkIGl0Lg0KDQpJcyB0aGVyZSBhIHdheSB0byBtYWtlIGl0
IHN5bmMgdGhlIG5ldyBmaWxlcyBpbiB0aGUgdGVtcCBmb2xkZXIgd2l0aCB0aGUgY3VycmVudCBi
cmFuY2g/ICBPciBldmVuIHRvIHVzZSB0aGUgY3VycmVudCBkaXJlY3RvcnkgZm9yICRSRU1PVEUN
Cg0KVGhhbmtzLiANCg0K

