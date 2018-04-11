Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC2E91F404
	for <e@80x24.org>; Wed, 11 Apr 2018 01:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeDKBQq (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 21:16:46 -0400
Received: from mail-bl2nam02on0046.outbound.protection.outlook.com ([104.47.38.46]:38223
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751775AbeDKBQp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 21:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Seeq.onmicrosoft.com;
 s=selector1-seeq-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=iwJc5fSU1ZSpZ3qfdzSiwk8c4zleYjYhLqIqRDb/7DM=;
 b=p5CVK0/b/G2/wKT9NE1kdtqJir7SSjg0fkTY1RkAy9r3i0r8qTOD3WFx+d0UJ9Tn7H8f08lu9A+ncO0ztkMddxYX6cllF6YbnmVA5ezX4fS2rvvtouwl3Zu4eXavIf9BSc/oTRqdcJfwlnFFMrLSAdirSffonzCw5iXoSxR8BFo=
Received: from SN6PR06MB3824.namprd06.prod.outlook.com (52.132.125.144) by
 SN6PR06MB4109.namprd06.prod.outlook.com (52.132.124.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.653.12; Wed, 11 Apr 2018 01:16:42 +0000
Received: from SN6PR06MB3824.namprd06.prod.outlook.com
 ([fe80::3d14:fc74:d946:1a74]) by SN6PR06MB3824.namprd06.prod.outlook.com
 ([fe80::3d14:fc74:d946:1a74%13]) with mapi id 15.20.0653.014; Wed, 11 Apr
 2018 01:16:42 +0000
From:   John Sullivan <john.sullivan@seeq.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git-lfs question
Thread-Topic: git-lfs question
Thread-Index: AdPRMkDGr74BKtdtRsiO+nGgxpeIPQAAGyQQ
Date:   Wed, 11 Apr 2018 01:16:42 +0000
Message-ID: <SN6PR06MB382452FA81CAD6654E40EEB58CBD0@SN6PR06MB3824.namprd06.prod.outlook.com>
References: <SN6PR06MB3824DE625D893166EEE35D358CBD0@SN6PR06MB3824.namprd06.prod.outlook.com>
In-Reply-To: <SN6PR06MB3824DE625D893166EEE35D358CBD0@SN6PR06MB3824.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [73.40.112.164]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR06MB4109;7:DJjW2A4+OPDWMZ37l4UTUlFfafsAGYoNT5k+VziejzfkB31p0cgjprIf+7coycLXRh+TJMgSbwinQCr7KhwfGWJxu7HYK4oPfSHcXCiswwkhRlLzpFOtrlcugjgiX+b58HOb+kFch2VMUCoAizBIcHr8rG/ndCz6171wQJ1Vkxw04y3g20l78az7fVtNnI8P7t5fYVZDdq6G8ZNndtDnb0riEc6+5o/A2b7TydwqWOzHM+yNWcw+9BjfHdANdsln
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(3008032)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:SN6PR06MB4109;
x-ms-traffictypediagnostic: SN6PR06MB4109:
x-microsoft-antispam-prvs: <SN6PR06MB410964F21067EA07389128B38CBD0@SN6PR06MB4109.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123564045)(20161123562045)(2016111802025)(20161123560045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:SN6PR06MB4109;BCL:0;PCL:0;RULEID:;SRVR:SN6PR06MB4109;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(346002)(39840400004)(366004)(199004)(189003)(3660700001)(97736004)(102836004)(316002)(106356001)(7696005)(86362001)(76176011)(6116002)(66066001)(68736007)(3846002)(105586002)(2900100001)(2906002)(6506007)(305945005)(99286004)(5250100002)(14454004)(3280700002)(74316002)(6916009)(5660300001)(2351001)(2940100002)(25786009)(53936002)(478600001)(9686003)(55016002)(6436002)(5640700003)(186003)(6346003)(11346002)(8936002)(8676002)(3480700004)(7736002)(2501003)(1730700003)(81156014)(486006)(476003)(81166006)(33656002)(26005)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR06MB4109;H:SN6PR06MB3824.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: seeq.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=john.sullivan@seeq.com; 
x-microsoft-antispam-message-info: DDEozAavQHmhwjPdSxM83x1lKebf/11OkYvwBRwgg62AZKIdRku/h3xnCxKlFDZAysPtpJ5/gOITyXXOvzZnCps9neRTWo1HIyyWZdq1lzo60mo3E/lr2t4Q5eSX7RSUvEgOXFzLRUn0ouuvrLNnHB4XhmlmD0tOkPfpbBAgVO8wT+n/OrsA6BdcHsPRlZT+I6FWhnj+3SO3CcYbh2pujrm+YrxSKEe4Ci/IUb+yG6OCJhJr71/MKhl+TRfkfmvBU0EFMJQlgEFDw7+V8Fw/LMcZp7fICZkMjVm7DDLBNSv3KVinRb+GL/EAikWutO0d7/MJiz9WftZX/JMG91PscDIGaM6jiKKXJIQIokHaVhF5MVDJME9X68FwnTr3/8qqmS82L9KSxqILniPoeQsoHsGTgP/muKFrqJKfkEjsGvI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 23bb36ba-cbe5-4078-bba4-08d59f49e29f
X-OriginatorOrg: seeq.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bb36ba-cbe5-4078-bba4-08d59f49e29f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 01:16:42.5247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 59c34274-1c79-484b-8ed6-71174050b6d6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR06MB4109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello - I've seen instructions that say after installing git to also instal=
l git-lfs.
But today when installing git I noticed that in the install options there w=
as a default selected options stating "Git LFS (Large File Support)".

Does this mean git is automatically adding git-LFS or just adding support f=
or it and I'll still need to install git-lfs afterwards?

Thanks,
John

