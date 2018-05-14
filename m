Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6307C1F406
	for <e@80x24.org>; Mon, 14 May 2018 17:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752917AbeENRci (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 13:32:38 -0400
Received: from mail-ve1eur01on0131.outbound.protection.outlook.com ([104.47.1.131]:5013
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752343AbeENRch (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 13:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OQAOkZs8mV2wqt1ri9kYASMEPrueJ94HGrVUXRlczR4=;
 b=dMGyszFf9WkUYakPbYM48w4unWXgfgN8pVvmhR9oJDdJh1nmpgHLFCglcX1/ZMdrAqBrhQRiCjUYDcwwEW3fsM5Hw1rcpG/PXxmQo/QyqfEFGGEu3LmjlaoaYpjHtcf/FLYne3HR1eUhvF8I4iRKjY9B5OvCKrrf+j08CNBTEBc=
Received: from AM4PR0701MB2116.eurprd07.prod.outlook.com (10.167.132.137) by
 AM4PR0701MB2226.eurprd07.prod.outlook.com (10.168.37.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.4; Mon, 14 May 2018 17:32:35 +0000
Received: from AM4PR0701MB2116.eurprd07.prod.outlook.com
 ([fe80::f87c:4ed0:b533:e9c1]) by AM4PR0701MB2116.eurprd07.prod.outlook.com
 ([fe80::f87c:4ed0:b533:e9c1%2]) with mapi id 15.20.0776.008; Mon, 14 May 2018
 17:32:35 +0000
From:   "Barodia, Anjali (Nokia - IN/Noida)" <anjali.barodia@nokia.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git push error due to hooks error
Thread-Topic: Git push error due to hooks error
Thread-Index: AdPrqYnvQeqi4lzfRYGYVffRNjcCrg==
Date:   Mon, 14 May 2018 17:32:35 +0000
Message-ID: <AM4PR0701MB21165697A8485CA4B42ADFFB8A9C0@AM4PR0701MB2116.eurprd07.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4327cfd9-47ed-48f1-9376-4ab3148935bb_Enabled=True;
 MSIP_Label_4327cfd9-47ed-48f1-9376-4ab3148935bb_SiteId=5d471751-9675-428d-917b-70f44f9630b0;
 MSIP_Label_4327cfd9-47ed-48f1-9376-4ab3148935bb_Ref=https://api.informationprotection.azure.com/api/5d471751-9675-428d-917b-70f44f9630b0;
 MSIP_Label_4327cfd9-47ed-48f1-9376-4ab3148935bb_Owner=anjali.barodia@nokia.com;
 MSIP_Label_4327cfd9-47ed-48f1-9376-4ab3148935bb_SetDate=2018-05-14T22:58:48.6327432+05:30;
 MSIP_Label_4327cfd9-47ed-48f1-9376-4ab3148935bb_Name=Personal;
 MSIP_Label_4327cfd9-47ed-48f1-9376-4ab3148935bb_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_4327cfd9-47ed-48f1-9376-4ab3148935bb_Extended_MSFT_Method=Manual;
 Sensitivity=Personal
x-originating-ip: [47.30.16.141]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0701MB2226;7:vdwzM1mRymIuBg8Bw2CVprLv8SyT54jqW61euJim6CK8kG7X2gNCBv23zASz2lyj1oIWcYael3JZh9Lyf51ct6jE+Lo14wPQKBj4Z1Nrbtrer738kztVDZfy8FnFYx7ETqyteoT+1GBnf5jMyVeXQV7AJoA1VWIe8ImyLZ3IqRvKRSrLcU6c66zU2Z71U3FZEPApZbQaVd1kneFHBeWtMBKUDi23yNQFfwnzYSLpRKjZjbHMo9wiB6QDnaX/22Iv
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(48565401081)(2017052603328)(7193020);SRVR:AM4PR0701MB2226;
x-ms-traffictypediagnostic: AM4PR0701MB2226:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anjali.barodia@nokia.com; 
x-microsoft-antispam-prvs: <AM4PR0701MB22266BDA9266520F389ABA8D8A9C0@AM4PR0701MB2226.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(11241501184)(806099)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:AM4PR0701MB2226;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0701MB2226;
x-forefront-prvs: 067270ECAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39380400002)(39860400002)(53474002)(189003)(199004)(97736004)(7696005)(99286004)(6436002)(8676002)(5640700003)(2900100001)(3660700001)(6916009)(2906002)(3280700002)(81166006)(25786009)(1730700003)(81156014)(86362001)(55016002)(6506007)(59450400001)(8936002)(186003)(316002)(9686003)(102836004)(7736002)(53936002)(14454004)(74316002)(5660300001)(478600001)(5250100002)(33656002)(476003)(2351001)(2501003)(305945005)(486006)(106356001)(26005)(3846002)(66066001)(105586002)(68736007)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0701MB2226;H:AM4PR0701MB2116.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: T7/ZC99O5HbJQSSh9mcfFlTzLeskPnYBbkDf1V0zpFf8+xsJOt6EcZfbBncUDDzXWPU02X308mRzR1b87Rv5Rkq+x3VfhXs2SLZ3PzuAMeQjfOxDLBBbuBmm8vhtnrkjl9ykhsnOGrGl6q5Ovz9vO0rGoPqRzuMHW0D8Cr0sNhGFaZdMnaOD8T5NjLmxg9vo9QMeWLjEZEF90Dqu7kGlSaksVI+igD5EISh9FkIY4EPsgL9ebGlZWl5TKWUw53/M
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0bf1c1e9-2fa9-4a30-d53f-08d5b9c0ae4a
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf1c1e9-2fa9-4a30-d53f-08d5b9c0ae4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2018 17:32:35.0854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0701MB2226
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
remote: error: internal error while processing changes
To ssh_url_path:8282/SI_VF.git
 ! [remote rejected]   master -> master (Error running hook /opt/gerrit/hoo=
ks/re    f-update)
error: failed to push some refs to 'ssh_user@url_path:8282/SI_VF.git'

I tried to push after deleting the .git/hooks, but still get the same error=
.
Please help me in fixing this error.

Thanks with Regards,
Anjali Barodia
