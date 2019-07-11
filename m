Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55D991F461
	for <e@80x24.org>; Thu, 11 Jul 2019 15:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfGKP2b (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 11:28:31 -0400
Received: from mail-eopbgr730088.outbound.protection.outlook.com ([40.107.73.88]:55528
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728102AbfGKP2b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 11:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ra.rockwell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeQwwxK9Xm5i+olwQoh/No//I6SGDR3NZS9PyUT5HwU=;
 b=l8llVpQSJaeMBMcYs1paN7lcZlvA1up5h8d7hgmYV0xvqB3W9eJHbtfzPc7eQBpN52pSu2J4XhGOyHh4UtLHCONoiKVTuhjQnAk40BT9bATdd2Fa3L9IdjsBfRF9KmSYrhtGn1tOu6VrxOciUPEjexomUV9BGAayArmuVpgoleo=
Received: from CY4PR2201MB1559.namprd22.prod.outlook.com (10.171.214.147) by
 CY4PR2201MB1640.namprd22.prod.outlook.com (10.171.241.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Thu, 11 Jul 2019 15:28:28 +0000
Received: from CY4PR2201MB1559.namprd22.prod.outlook.com
 ([fe80::a492:8110:c29:3f13]) by CY4PR2201MB1559.namprd22.prod.outlook.com
 ([fe80::a492:8110:c29:3f13%2]) with mapi id 15.20.2052.019; Thu, 11 Jul 2019
 15:28:28 +0000
From:   "Mark T. Ortell" <mtortell@ra.rockwell.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: List of Known Issues for a particular release
Thread-Topic: List of Known Issues for a particular release
Thread-Index: AdU3/UEayPYJJwlLQxGa0N35DX3aTQ==
Date:   Thu, 11 Jul 2019 15:28:27 +0000
Message-ID: <CY4PR2201MB1559C26C1D75B4F649AD38049AF30@CY4PR2201MB1559.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mtortell@ra.rockwell.com; 
x-originating-ip: [205.175.240.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 933eb845-ea6f-4bbf-00de-08d706146c2b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY4PR2201MB1640;
x-ms-traffictypediagnostic: CY4PR2201MB1640:
x-microsoft-antispam-prvs: <CY4PR2201MB164049CDFF6CD7545B122E709AF30@CY4PR2201MB1640.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(189003)(199004)(74316002)(68736007)(102836004)(256004)(33656002)(6916009)(2906002)(316002)(186003)(14454004)(8676002)(3846002)(476003)(71200400001)(71190400001)(8936002)(2351001)(1730700003)(81156014)(81166006)(6116002)(7736002)(305945005)(53936002)(86362001)(486006)(26005)(5660300002)(25786009)(478600001)(6436002)(55016002)(52536014)(9686003)(5640700003)(66066001)(76116006)(66946007)(6506007)(2501003)(66446008)(7696005)(66556008)(64756008)(66476007)(99286004)(340984004)(554374003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR2201MB1640;H:CY4PR2201MB1559.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ra.rockwell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FIr7HcCcMEaD84iDqsWuVr3u1WeTwHgJp3VoxRQymXe8P3fKs0NWB6QRlULC5mqM3Ut6A07E+8lpXFmWEmXCdFTB5LT7YAi97E9pzCC9ZE88otoVaLNExDGkB/NX0loqQQz0lKpzIvSry1wDnh6H1vCLXtWxW946fOu7GhRq7JH+njLONs6oXxdpxlKDZDoPQfJsJTfgw5QKIs+2j2Y59ykxcYfKjixAl8a/v6r0wG5xblJMAANsMCd3GjuVZ9fs67EjilmVtd1W3oveDItqgKLRvgLIm0Tn2KvLyqAu2E+eqGtxVS3UQs+w1BJCC9BUskg5uBtPcycYnlOMf1+k+ongfwSK7+zxkxavEO8NKQrAzOt6IfZe/xdqGDCL8ePXddBEtd9zwabLYuXej/HuROgSqy8rjb+eytrWZzEi0Fw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ra.rockwell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933eb845-ea6f-4bbf-00de-08d706146c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 15:28:27.9354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 855b093e-7340-45c7-9f0c-96150415893e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtortell@rockwellautomation.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1640
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am doing a software tool assessment for functional safety and I am review=
ing the use of Git as the SCM. One thing that I need to do is review the li=
st of "known issues" with the Git release being used. I have gone through t=
he release notes and found that it only contains the fixes and enhancements=
 in a particular release of Git, it does not contain a list of known issues=
/errata in a particular release. The github project also does not include t=
he bug tracking list, so I am not able to figure out a way to review the kn=
own issues for a particular release. I considered reviewing the fixes in re=
leases beyond the release used, but that has 2 problems. One, it doesn't co=
ntain any issues that are yet to be fixed. Two, only the fixes in the "next=
" release are truly relevant because fixes after that could have been intro=
duced in a release after the release being used. An additional note is that=
 the Git for Windows project does provide a list of known issues in the ins=
tall=20

Could someone in this mailing list assist me in finding the known issues fo=
r a particular version?=20

Best Regards,
Mark Ortell

