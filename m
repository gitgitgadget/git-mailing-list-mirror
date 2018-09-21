Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19A961F453
	for <e@80x24.org>; Fri, 21 Sep 2018 17:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389683AbeIUWvV (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 18:51:21 -0400
Received: from relays-agent07.techservices.illinois.edu ([192.17.82.73]:53420
        "EHLO illinois.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728149AbeIUWvU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 18:51:20 -0400
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Sep 2018 18:51:19 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=campusrelays;
 bh=OMsvs2RquETwqZjXIY1r+w67BAdhTX9gHpLycDxIFP8=;
 b=Gqmidayiqa8gGlFGQhTOkKeNFDwR9ewraqP2UvCnoH5A+2gExgshJPWO4q24dEjPyxf8
 hHWlh6yteYN7QGkKmyhtjxW1XZ9vNgW/pRbUVT3cJWiXVrLWsuV/0cCWe1QJQZIovxlk
 YhnPF2yhSMbP27+H4X5QTDP7qmJYefTkdUfpUALtmtn/7c+i1WS4x00rvULILXvHYjTj
 y98zjgJDM9ZZtI4Dlhf6GajsMuOLD6teq6YNCmMTL6uwpwsNQR79MQFg5Q6cF0fddMou
 DPux7nus9y8pBJJ08vv5D58+mXp3pBS4vBkyCf5h5HUFwaDcuYwt2lhrh8V8PMXEuPLi XA== 
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (mail-by2nam03lp0049.outbound.protection.outlook.com [216.32.180.49])
        by relays-agent07.techservices.illinois.edu (8.16.0.22/8.16.0.22) with ESMTPS id w8LGuMMQ011468
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 11:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uillinoisedu.onmicrosoft.com; s=selector1-illinois-edu;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMsvs2RquETwqZjXIY1r+w67BAdhTX9gHpLycDxIFP8=;
 b=K5MenjcsNg23iPymAA3tfG7/A8yMp5IB1lu+d2IhlU1ULE1dkUmzse9nfcW4Z0Bf4+/XzDfMwrY4Do1tz4oCJyHSoFt2uc+LPpOpFXXbWG4qS/0BHXVjD85M6M08E/lBDJgmDzj5xQIacmXoHe+ztKZyIu6o8P83wo5JYSkUtDQ=
Received: from MWHPR11MB1294.namprd11.prod.outlook.com (10.169.237.137) by
 MWHPR11MB1502.namprd11.prod.outlook.com (10.172.53.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Fri, 21 Sep 2018 16:56:20 +0000
Received: from MWHPR11MB1294.namprd11.prod.outlook.com
 ([fe80::655c:d053:2618:abea]) by MWHPR11MB1294.namprd11.prod.outlook.com
 ([fe80::655c:d053:2618:abea%3]) with mapi id 15.20.1143.019; Fri, 21 Sep 2018
 16:56:20 +0000
From:   "Zych, David M" <dmrz@illinois.edu>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: credential.<url>.helper with partial url path
Thread-Topic: credential.<url>.helper with partial url path
Thread-Index: AQHUUcwF3K0fYeprLUWXDJD+xAc6/g==
Date:   Fri, 21 Sep 2018 16:56:20 +0000
Message-ID: <c3147945-2b5c-68f8-91e7-6edc78a05801@illinois.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
x-originating-ip: [130.126.255.226]
openpgp: preference=signencrypt
x-clientproxiedby: DM5PR15CA0043.namprd15.prod.outlook.com
 (2603:10b6:4:4b::29) To MWHPR11MB1294.namprd11.prod.outlook.com
 (2603:10b6:300:2b::9)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1502;6:Xc5JkXOW0UK9QeNzOxQa2MVBf9TGcHZcfp4sU4t4PuOd/wKhiQGk9osuSrrWk++LoCb0vH8ns4/BnU1chRVeDT5dGkHQafzFMKqn0joLoPq/EBsA5buZ7QPi7WungljU109r9z76qvZqTIkx29ihhdsSPrGpRNyKJkiHho5NyGOtjEgDgUMswVW/KcpCy6dsoeD0UuGe0AwV9VbU6ofN3CzFw1IlqVsGVjFNAi5DFEpfgDjd1m7aF7g95VlgaIOl2EiL++yRWimO6C24qzABbbff/P1PO1U+UqaUmf7oKT8+JsR0vdoRLoIapCSb+5/TkYLqKmSRcU1d/bWJzOsW+fvR3gElBpJzOWdpsVUsIctdqysrLOAViCQ3net7SC5mxnAOmYvt2oNuhQpM0Y5bwiocg8f8+PuAEIcq9JhGmxrHn5gmXw/g4FMtWdqvuuhhQHPAsHG0CKcGBVfWIJgbbA==;5:iohiWKRpwDfPGRA2OjASHDvXvKqFzRC5ja3eITt9+dZL3VJvB0zHMZ1aUC8YpiNkcZJWzSFlLqCIr/39MlROq2RThhMAaAku5SaLoJyroYqVdDabupZbWhvs3/ZI1OfB0+p4oMxTNT+ZEBAeqTZdXYGyws814N5250eoR6m7fXc=;7:1Ckt4K9rMxUUsMsxk0vdnPEBUwSG0FBXmhqOMUeZH1mENsBRr+gQXaTuDRH1NHuHffiFqyqk4rSHAbk4oaUEMtqJTBdl7x6AQYMCGgBmytvIYwuESRffAsWxmeXNzP9bVFYIgUGB2xDR3tqRnnGAn4JzcTcPhP63wNR7V8w/PUON+IvqDUKMqRC1TkZAv5KLoQEjVLLIjmRd0rrcZGShHdpQ24wL171h1hmiSgni6aa+VvuiJE15yWmdReDFK9zl
x-ms-office365-filtering-correlation-id: b28d23c5-94b8-4927-9267-08d61fe32797
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1502;
x-ms-traffictypediagnostic: MWHPR11MB1502:
x-microsoft-antispam-prvs: <MWHPR11MB15024C01A3914C650E03B575BA120@MWHPR11MB1502.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:MWHPR11MB1502;BCL:0;PCL:0;RULEID:;SRVR:MWHPR11MB1502;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(136003)(376002)(189003)(199004)(2616005)(65826007)(71200400001)(71190400001)(256004)(478600001)(53936002)(52116002)(966005)(6306002)(105586002)(31696002)(5660300001)(6116002)(106356001)(86362001)(386003)(3846002)(6506007)(99286004)(68736007)(36756003)(31686004)(25786009)(81156014)(81166006)(64126003)(186003)(1730700003)(2906002)(2900100001)(6916009)(6486002)(14454004)(305945005)(5640700003)(97736004)(75432002)(7736002)(2501003)(786003)(102836004)(53376002)(8936002)(316002)(26005)(58126008)(6512007)(88552002)(2351001)(65806001)(66066001)(65956001)(8676002)(476003)(6436002)(5250100002)(486006)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1502;H:MWHPR11MB1294.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: illinois.edu does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: u2xVSgcQer6PKXsZtUPGMS61shhzFXQlVEeAnLHjhXzZH7BWD95os7f+xi0YMFKeQQ2lNYm6rYmtosAduDO/2kH7SU8fZN/yMW6eGNU903283zx+F5NASw0ImPaZPO3dNs9c4v7lhXGQg6ab6RsBSoCTynoYShuV1D7pqZHx9vuWKWAMQ6MJPUwNd1yn/NX4V3ZqVW/1rUYL1X/EPJhigtx7ZUa95N7adRtVJpWf/TWbDfHmdxxy3O7lkja68V887WIOnaTkB9u19Fzh1/5MNuBTCd92sarYgXN/S/LDn7XGvrJoh6ZiEVPGasHj8QTFYrYOhyE8a3mQccNHShjY37B5+d+YBqvY3y1S3WaI6dg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <04E61E0460D7844DA4EBB0DE3ADAFBF0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b28d23c5-94b8-4927-9267-08d61fe32797
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 16:56:20.7010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1502
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

U3VwcG9zZSBJIG5lZWQgdG8gdXNlIGRpZmZlcmVudCBjcmVkZW50aWFsLmhlbHBlciB2YWx1ZXMg
Zm9yIGRpZmZlcmVudCANCnJlcG9zaXRvcmllcyBvbiB0aGUgc2FtZSBIVFRQUyBob3N0LiAgSWRl
YWxseSBJIHdvdWxkIGxpa2UgdG8gYmUgYWJsZSB0byANCndyaXRlIHRoaXMgbG9naWMgdXNpbmcg
YSBwYXJ0aWFsIFVSTCBwYXRoIHByZWZpeCwgZm9yIGV4YW1wbGUgaW4gDQp+Ly5naXRjb25maWcN
Cg0KW2NyZWRlbnRpYWwgImh0dHBzOi8vZXhhbXBsZS5jb20vcHJlZml4MS9mb28uZ2l0Il0NCiAg
ICAgICAgIGhlbHBlciA9ICFaWloNCltjcmVkZW50aWFsICJodHRwczovL2V4YW1wbGUuY29tL3By
ZWZpeDEvIl0NCiAgICAgICAgIGhlbHBlciA9ICFZWVkNCltjcmVkZW50aWFsICJodHRwczovL2V4
YW1wbGUuY29tLyJdDQogICAgICAgICB1c2VIdHRwUGF0aCA9IHRydWUNCiAgICAgICAgIGhlbHBl
ciA9ICFYWFgNCg0KRm9yIHByZWZpeDEvZm9vLmdpdCAoZXhhY3QgcGF0aCBtYXRjaCkgdGhpcyB0
cmllcyBaWlogZmlyc3QgYXMgZGVzaXJlZDoNCg0KJCBnaXQgY3JlZGVudGlhbCBmaWxsDQpwcm90
b2NvbD1odHRwcw0KaG9zdD1leGFtcGxlLmNvbQ0KcGF0aD1wcmVmaXgxL2Zvby5naXQNCg0KWlpa
IGdldDogWlpaOiBjb21tYW5kIG5vdCBmb3VuZA0KWFhYIGdldDogWFhYOiBjb21tYW5kIG5vdCBm
b3VuZA0KVXNlcm5hbWUgZm9yICdodHRwczovL2V4YW1wbGUuY29tL3ByZWZpeDEvZm9vLmdpdCc6
IF5DDQoNCkhvd2V2ZXIsIHByZWZpeDEvYmFyLmdpdCBkb2VzIG5vdCB0cnkgWVlZOg0KDQokIGdp
dCBjcmVkZW50aWFsIGZpbGwNCnByb3RvY29sPWh0dHBzDQpob3N0PWV4YW1wbGUuY29tDQpwYXRo
PXByZWZpeDEvYmFyLmdpdA0KDQpYWFggZ2V0OiBYWFg6IGNvbW1hbmQgbm90IGZvdW5kDQpVc2Vy
bmFtZSBmb3IgJ2h0dHBzOi8vZXhhbXBsZS5jb20vcHJlZml4MS9iYXIuZ2l0JzogXkMNCg0KZXZl
biB0aG91Z2ggKEFGQUlDVCkgdGhlIGdlbmVyYWwgYmVoYXZpb3Igb2YgZ2l0LWNvbmZpZyBzZWVt
cyB0byBpbXBseSANCnRoYXQgaXQgd291bGQgZG8gc286DQoNCiQgZ2l0IGNvbmZpZyAtLWdldC11
cmxtYXRjaCBjcmVkZW50aWFsIGh0dHBzOi8vZXhhbXBsZS5jb20vcHJlZml4MS9iYXIuZ2l0DQpj
cmVkZW50aWFsLmhlbHBlciAhWVlZDQpjcmVkZW50aWFsLnVzZWh0dHBwYXRoIHRydWUNCg0KSXMg
dGhpcyBkaXNjcmVwYW5jeSBpbnRlbmRlZD8NCg0KVGhlIGRvY3VtZW50YXRpb24gaW4gYG1hbiBn
aXRjcmVkZW50aWFsc2AgDQooaHR0cHM6Ly9naXQtc2NtLmNvbS9kb2NzL2dpdGNyZWRlbnRpYWxz
KSBwb2ludHMgb3V0IHF1aXRlIGV4cGxpY2l0bHkgDQp0aGF0IG15IHBhdHRlcm5zIHdpbGwgbm90
IG1hdGNoIGZvby5leGFtcGxlLmNvbSBub3IgcGxhaW4gaHR0cCwgYnV0IGJvdGggDQpvZiB0aG9z
ZSBydWxlcyBhcmUgY29uc2lzdGVudCB3aXRoIHdoYXQgZ2l0LWNvbmZpZyByZXBvcnRzOg0KDQok
IGdpdCBjb25maWcgLS1nZXQtdXJsbWF0Y2ggY3JlZGVudGlhbCBodHRwczovL2Zvby5leGFtcGxl
LmNvbS8NCmNyZWRlbnRpYWwuaGVscGVyIG9zeGtleWNoYWluDQokIGdpdCBjb25maWcgLS1nZXQt
dXJsbWF0Y2ggY3JlZGVudGlhbCBodHRwOi8vZXhhbXBsZS5jb20vDQpjcmVkZW50aWFsLmhlbHBl
ciBvc3hrZXljaGFpbg0KDQpJZiBpbmRlZWQgdGhlIGN1cnJlbnQgYmVoYXZpb3Igb2YgZ2l0LWNy
ZWRlbnRpYWwgaXMgYXMgaW50ZW5kZWQsIEkgdGhpbmsgDQppdCB3b3VsZCBiZSBoZWxwZnVsIGZv
ciB0aGF0IG1hbnBhZ2UgdG8gZXhwbGljaXRseSBtZW50aW9uIGl0IChpLmUuIHRoYXQgDQp5b3Ug
bWF5IHNwZWNpZnkgYSBVUkwgcGF0aCBjb21wb25lbnQgYnV0IHRoYXQgaXQgbXVzdCBtYXRjaCBl
eGFjdGx5KS4gDQpSaWdodCBub3cgdGhlIG9ubHkgZXhhbXBsZSBnaXZlbiBpcyBvbmUgaW4gd2hp
Y2ggJ3RoZSAicGF0dGVybiIgVVJMIGRvZXMgDQpub3QgY2FyZSBhYm91dCB0aGUgcGF0aCBjb21w
b25lbnQgYXQgYWxsLicNCg0KSSdtIHRlc3RpbmcgYWdhaW5zdA0KDQokIGdpdCAtLXZlcnNpb24N
CmdpdCB2ZXJzaW9uIDIuMTkuMA0KDQppbnN0YWxsZWQgdmlhIGhvbWVicmV3IG9uIE1hYyBPUyBY
Lg0KDQpUaGFua3MsDQpEYXZpZA0KDQotLSANCkRhdmlkIFp5Y2gNCkxlYWQgTmV0d29yayBTZXJ2
aWNlIEVuZ2luZWVyDQpVbml2ZXJzaXR5IG9mIElsbGlub2lzIFRlY2hub2xvZ3kgU2VydmljZXMN
Cg==
