Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDF981F404
	for <e@80x24.org>; Thu, 22 Mar 2018 16:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbeCVQkp (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 12:40:45 -0400
Received: from mail-co1nam03on0047.outbound.protection.outlook.com ([104.47.40.47]:22390
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751553AbeCVQko (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 12:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mindbody.onmicrosoft.com; s=selector1-mindbodyonline-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hDvXZseByX9J7Cm+Q2oopiO1NV4Vk/LZscxScdydf18=;
 b=eTWHOQYlFRAGQ87vVD+TwI/mal/pPdFwyeEj4MWjufA52aXeSedyMhf2bpfYslLhCV66toFaKVHrEO+IoKQtGHYbw2rYH5kYPUCRaiS9iU+gi7t/aionWU0o+EcFxqd8E240Zv3hfx6ClIXvRjJIp0WS7UzmZ5ZlUGfvHNfE/L8=
Received: from DM5PR05MB3548.namprd05.prod.outlook.com (10.174.242.153) by
 DM5PR05MB3148.namprd05.prod.outlook.com (10.173.219.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.631.5; Thu, 22 Mar 2018 16:40:43 +0000
Received: from DM5PR05MB3548.namprd05.prod.outlook.com
 ([fe80::88d6:f789:d91c:4e00]) by DM5PR05MB3548.namprd05.prod.outlook.com
 ([fe80::88d6:f789:d91c:4e00%3]) with mapi id 15.20.0609.006; Thu, 22 Mar 2018
 16:40:43 +0000
From:   John Chesshir <John.Chesshir@mindbodyonline.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: UriFormatException output when interacting with a Git server
Thread-Topic: UriFormatException output when interacting with a Git server
Thread-Index: AdPB+6BgMgfjOBkiQC692R1oac1TRg==
Date:   Thu, 22 Mar 2018 16:40:42 +0000
Message-ID: <DM5PR05MB35484CC117C6E758F520600994A90@DM5PR05MB3548.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Chesshir@mindbodyonline.com; 
x-originating-ip: [136.179.14.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR05MB3148;7:2TM+cGNkWU5D17+mKqb8ac1HSIqM2Y6l4KWmWUqPcr2LlauXL/Bu5xOr/mipDyCfoNdG2vqIrWKQjWEwII4s/QWtSa+wDTlSEZdXHypHMiz2lFev97TKRWSlwiODTxWei80+qlB78fMkOuW7wKPFUAKgCAikOuVfFnC0SIjDTQdwgvnUldvdGdVSnJhq8EIpDYWG/EZBGrbfGOsU1HBgrwhCCfo1+dwWEeFiORvDzj5G8VTYyb5M0j7s7JPgjhx+
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: fcb63252-6444-4a1e-d58e-08d59013a765
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR05MB3148;
x-ms-traffictypediagnostic: DM5PR05MB3148:
x-microsoft-antispam-prvs: <DM5PR05MB314822E77AC42D7037A1094194A90@DM5PR05MB3148.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(185212123834332);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR05MB3148;BCL:0;PCL:0;RULEID:;SRVR:DM5PR05MB3148;
x-forefront-prvs: 0619D53754
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(189003)(199004)(966005)(14454004)(99286004)(6306002)(66066001)(9686003)(106356001)(25786009)(305945005)(7736002)(2351001)(53936002)(186003)(5640700003)(68736007)(7696005)(2900100001)(72206003)(478600001)(6436002)(26005)(86362001)(55016002)(316002)(33656002)(5660300001)(8676002)(97736004)(2501003)(81156014)(102836004)(105586002)(6506007)(2906002)(5250100002)(1730700003)(3846002)(81166006)(3660700001)(8936002)(74316002)(3280700002)(6116002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR05MB3148;H:DM5PR05MB3548.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mindbodyonline.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: +Ftmbfm8lbhpYongn+qZxV4dT+niKOqGKWOSi3q8s9KJO850LFFkum1U3Izh7fYpGOgJzBA+VTHO4rLeLu43bv3e8ZfkH1K56HQzoNgcb6FVlA760ZjP9X0vneEtfwIpDjEB1J4sDE7SHKzuvAs8mYUORLcaFd6xkf/Bv1kZLrl+xIDJVCRqUi2eQKgVlc3LVYlrREIpgVHyclVnq1/btAmYj5RHEbYwkzKcpNJ2fMzjILvtzO57aT6fii3n9HccQG6cpadxTrGWZliNE5cgVpdDRIyEMSGiUxuMJ9TjZhTGlW2Cs0hfp2fwlTmwqbLQdi2ts6JOB+cfMSmJCiKlqQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mindbodyonline.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb63252-6444-4a1e-d58e-08d59013a765
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2018 16:40:42.9415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f2dfe35-1884-424a-b8d0-7c69ffcf7d92
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR05MB3148
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm getting this error on a fresh install of git version 2.16.2.windows.1:

fatal: UriFormatException encountered.
=A0=A0 queryUrl

See this post I found, https://stackoverflow.com/questions/48775400/git-fat=
al-uriformatexception-encountered-actualurl for more details.=A0 Note that =
the latest comments are mine, and describe the conditions on which I first =
saw the problem.=A0 I'll warn you, it's weird.

Thank you,
John Chesshir

P.S.=A0 I also found this older post, which appears related, but has clearl=
y been fixed: https://superuser.com/questions/1114193/when-cloning-on-with-=
git-bash-on-windows-getting-fatal-uriformatexception-enco.=A0 Include just =
in case that helps get closer to the latest problem.
