Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43BD61F424
	for <e@80x24.org>; Mon, 23 Apr 2018 14:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755531AbeDWOt2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 10:49:28 -0400
Received: from mail-hk2apc01on0056.outbound.protection.outlook.com ([104.47.124.56]:36480
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755485AbeDWOt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 10:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bwigroup.onmicrosoft.com; s=selector1-bwigroup-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Gy41L23LBab5tP7eBsbr2fQ+cJcFJViSB2n3UEX9EF0=;
 b=P+9kcEIMqOL68rnnyblTiFmHeJC5Qp+xAamqiCymZ6tIiETRK/3D/kaluo2x1TId2Kyax9dGvTPj9HrH/L7TYQpOvwNKyG4gLKurbMaBdsWUPGAsJAs+Qw26c69nf51PSEykUBPoMmbd8scE4xVflgXmiQkH8saILmNyScksCTA=
Received: from HK2PR0601MB1842.apcprd06.prod.outlook.com (10.170.148.149) by
 HK2PR0601MB1297.apcprd06.prod.outlook.com (10.165.181.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.13; Mon, 23 Apr 2018 14:49:23 +0000
Received: from HK2PR0601MB1842.apcprd06.prod.outlook.com
 ([fe80::1091:b802:7b86:b09f]) by HK2PR0601MB1842.apcprd06.prod.outlook.com
 ([fe80::1091:b802:7b86:b09f%4]) with mapi id 15.20.0696.016; Mon, 23 Apr 2018
 14:49:23 +0000
From:   Oshaben Nicholas <nicholas.oshaben@bwigroup.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Feature Request: option for git difftool to show changes in submodule
 contents
Thread-Topic: Feature Request: option for git difftool to show changes in
 submodule contents
Thread-Index: AdPbEjtmiG8RAYF3SM+5niJlnJuVdQ==
Date:   Mon, 23 Apr 2018 14:49:23 +0000
Message-ID: <HK2PR0601MB184272A36E86014BDD988DB5F9890@HK2PR0601MB1842.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=bwigroup.com;
x-originating-ip: [12.37.228.153]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR0601MB1297;7:OrLMlqfcA80n03XmVziMYnFV6KoKatl/rsuc9PGlbfzgQBQG3Ks8DR/bc+oEbZLC0LcQ/e8v6aHt3WKvxQHCEKRtDGbqak4CesMhuh3KEHAr8at/8Fn1TziMIl8je9u/JPEPRjgE7b6mHDjFFFuhSi7m2gsHEaQJ5BJEWVKoZDIIzZTwypvQ0btHjl8PzlDYFn9zqzbmTcq4NB3FbbnVzDXvNqS4f9P+IkDlxMTrFGPWdqzo2m6/Vb0SsJGT/be4
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR0601MB1297;
x-ms-traffictypediagnostic: HK2PR0601MB1297:
x-microsoft-antispam-prvs: <HK2PR0601MB129702A962FC120AE1FD12A2F9890@HK2PR0601MB1297.apcprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:HK2PR0601MB1297;BCL:0;PCL:0;RULEID:;SRVR:HK2PR0601MB1297;
x-forefront-prvs: 06515DA04B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(376002)(366004)(39380400002)(346002)(7736002)(3280700002)(478600001)(3660700001)(5660300001)(66066001)(2906002)(305945005)(25786009)(2501003)(74316002)(316002)(3846002)(7696005)(476003)(102836004)(186003)(26005)(6506007)(55016002)(6116002)(86362001)(6436002)(8936002)(53936002)(5250100002)(2351001)(33656002)(2900100001)(8676002)(6916009)(81166006)(1730700003)(9686003)(5640700003);DIR:OUT;SFP:1101;SCL:1;SRVR:HK2PR0601MB1297;H:HK2PR0601MB1842.apcprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: E/EkvMZF/x1d/tOsLII5VG80TynV9lCqsaNfrH30CsOfE+aCiLuM9dRkUJPCrWP7kz3Ig+wxFDJsOf+50XjRZ3xJgZ8+Z1uqJlacSsOSV0mmPoC7aczTI4sNoPwhMjcj0KeIMpIDU/zBBNCWNBWusnOvDe6rbZJPc2byzml6m1kHBi3Z81+TI3J3rrPkY4i6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 739d91bf-95d8-42bc-5db3-08d5a929677b
X-OriginatorOrg: bwigroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739d91bf-95d8-42bc-5db3-08d5a929677b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2018 14:49:23.6203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 063e3c8d-1b8f-4752-930a-430a4c585b21
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0601MB1297
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,=20

A coworker of mine was trying to use git difftool in a repository with subm=
odules and we found that it only shows the change in the subproject commit =
hash. The option to show the changes in the contents of the submodules exis=
ts for git diff. Can this be added to difftool as well?

Thank you,

Nicholas Oshaben
nicholas.oshaben@bwigroup.com

