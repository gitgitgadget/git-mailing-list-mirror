Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BC5D1F406
	for <e@80x24.org>; Mon, 14 May 2018 17:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeENRoK (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 13:44:10 -0400
Received: from mail-db5eur01on0098.outbound.protection.outlook.com ([104.47.2.98]:31088
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751449AbeENRoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 13:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3KYB4bk35HuE19MzGY0lLsrc04f5QZe05mZYTc0+s7E=;
 b=QgHeFJ+JAiM+4I8nlvbXhkNF0H7strwXnvX6lhvS2MRpifU4Hoppt/v/rQnjIswPsxTfwy9g0D/GI7+ehzt+8faHoex/Z3TnVE7rXfUIfo4StBkFJJroYWGhevz0LQW9Uzycv+6/DN+4vPGJT4I81l3vZFYoIscJe4LojCfz8+I=
Received: from AM4PR0701MB2116.eurprd07.prod.outlook.com (10.167.132.137) by
 AM4PR0701MB2050.eurprd07.prod.outlook.com (10.168.5.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.4; Mon, 14 May 2018 17:44:07 +0000
Received: from AM4PR0701MB2116.eurprd07.prod.outlook.com
 ([fe80::f87c:4ed0:b533:e9c1]) by AM4PR0701MB2116.eurprd07.prod.outlook.com
 ([fe80::f87c:4ed0:b533:e9c1%2]) with mapi id 15.20.0776.008; Mon, 14 May 2018
 17:44:06 +0000
From:   "Barodia, Anjali (Nokia - IN/Noida)" <anjali.barodia@nokia.com>
To:     "repo-discuss@googlegroups.com" <repo-discuss@googlegroups.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git push error due to hooks error
Thread-Topic: Git push error due to hooks error
Thread-Index: AdPrqwJ1evyh2XcERPuXD6RIOBtxmg==
Date:   Mon, 14 May 2018 17:44:06 +0000
Message-ID: <AM4PR0701MB2116C3BBD0A1E4892EAB09BB8A9C0@AM4PR0701MB2116.eurprd07.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anjali.barodia@nokia.com; 
x-originating-ip: [47.30.16.141]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0701MB2050;7:VaHTbKP4boFYSi4RkpVB+CjUqPQLJJSVLK4Wyol+CFDnF6iyOOFV+UQGo7GX7Dl5AxmaEJijqJvmY6bY9kEH0jiIp3fqnbH4w9JGrQJMsXFiuAR4XnwKkYL7W0hkJ8K/m/TVeF0GCUTsbqWiYZr6wTIXjp+UG+Riu/q2nzMEZ+K8/LK/VBkjeptRYdcCIr0/diFrBDXkYU/Z0i2S7wFogAh0TX8S6sldCTKY7cpM3zvh76FQ5U6Ng4lBzQxwK/79
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(48565401081)(2017052603328)(7193020);SRVR:AM4PR0701MB2050;
x-ms-traffictypediagnostic: AM4PR0701MB2050:
x-microsoft-antispam-prvs: <AM4PR0701MB20507D9D6F7408D9AC9D03D28A9C0@AM4PR0701MB2050.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(11241501184)(806099)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:AM4PR0701MB2050;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0701MB2050;
x-forefront-prvs: 067270ECAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39860400002)(39380400002)(53474002)(189003)(199004)(25786009)(8676002)(97736004)(105586002)(6916009)(33656002)(2906002)(2351001)(53936002)(5640700003)(2501003)(305945005)(106356001)(5250100002)(9686003)(55016002)(5660300001)(4326008)(7736002)(86362001)(68736007)(81156014)(81166006)(6436002)(66066001)(8936002)(74316002)(99286004)(486006)(3846002)(7696005)(102836004)(6116002)(59450400001)(14454004)(6506007)(3280700002)(186003)(26005)(3660700001)(2900100001)(476003)(316002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0701MB2050;H:AM4PR0701MB2116.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YzYH3FFV/ylDOo0LUwbGC+LjQLzQh2L+4NDY6NRFuGD2cEugodM6VBtFlGum9spU+SA6PCGPMMghZSe8uZeYglRqX28h76IP6DfjXHTBE+6nWdx0tIPe1+N2VsnOJc4HIvRJWQcF9/fpZ3a96R1oizD7H/+MfvtRPck08Yz4pwWt+pxeSd9PhsbV3CiZiaLRCXbV1b+2cExmc2xv5ehbugIEjuX2w0NbU7Axkfs6uN6HfcZr03aAVUKgweMWJN8G
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 98240dbf-4bdb-41ea-bbc2-08d5b9c24aa0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98240dbf-4bdb-41ea-bbc2-08d5b9c24aa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2018 17:44:06.8697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0701MB2050
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Support,


I was trying to push local git to another git on gerrit, but stuck with an =
hook error.
This is a very large repo and while running the command "git push origin --=
all"
I am getting this errors:

remote: (W) 92e19d4: too many commit message lines longer than 70 character=
s; manually wrap lines
remote: (W) de2245b: too many commit message lines longer than 70 character=
s; manually wrap lines
remote: (W) dc6e982: too many commit message lines longer than 70 character=
s; manually wrap lines
remote: (W) d2e2efd: too many commit message lines longer than 70 character=
s; manually wrap lines
remote: error: internal error while processing changes To ssh_url_path:8282=
/SI_VF.git
 ! [remote rejected]   master -> master (Error running hook /opt/gerrit/hoo=
ks/re    f-update)
error: failed to push some refs to 'ssh_user@url_path:8282/SI_VF.git'

I tried to push after deleting the .git/hooks, but still get the same error=
.
Please help me in fixing this error.

Thanks with Regards,
Anjali Barodia
