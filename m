Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DE7E20A25
	for <e@80x24.org>; Thu, 14 Sep 2017 22:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbdINWLG (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 18:11:06 -0400
Received: from mail-pu1apc01on0075.outbound.protection.outlook.com ([104.47.126.75]:10669
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751672AbdINWLE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 18:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NoLimitsConsulting.onmicrosoft.com; s=selector1-nlc-co-nz;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vsHOhPR5u6xf+/6QfrJijvnbarwbxYuuT8NxZW2EaNA=;
 b=VLFnfDo97MqukQVa74CQBvQNj9Kh2dAzLH+HWU7FgY8FmFi5dWIesNZ740/XGFi9/2DoiM1fEm2FgOgVSYBiMCUXNR5ZG57vE1KweOBRHSKBMnNFqzoS2vIB6McWiQCeIZ4gjXifDNnO/1KvftrNys+tmJX87D2ql0JKPF9NxL8=
Received: from PS1PR0601MB1883.apcprd06.prod.outlook.com (10.170.180.21) by
 PS1PR0601MB1481.apcprd06.prod.outlook.com (10.165.211.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.56.11; Thu, 14 Sep 2017 22:11:01 +0000
Received: from PS1PR0601MB1883.apcprd06.prod.outlook.com
 ([fe80::ed29:f8ac:6c75:c6c6]) by PS1PR0601MB1883.apcprd06.prod.outlook.com
 ([fe80::ed29:f8ac:6c75:c6c6%18]) with mapi id 15.20.0056.010; Thu, 14 Sep
 2017 22:11:01 +0000
From:   Gene Thomas <gene@nlc.co.nz>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git diff --name-status for deleted files
Thread-Topic: git diff --name-status for deleted files
Thread-Index: AdMtplB2FFGuO2d0TCCYmH1TzNzo1g==
Date:   Thu, 14 Sep 2017 22:11:01 +0000
Message-ID: <PS1PR0601MB1883177814CA771567A7193B8A6F0@PS1PR0601MB1883.apcprd06.prod.outlook.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=gene@nlc.co.nz; 
x-originating-ip: [222.154.250.75]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PS1PR0601MB1481;6:wKq6JSJCt5VNvdM9tkU5iS88HGPFjq7vlt6+p/78uJqfiSfnHEEk8JfsVUM3VgNFY/nmMdEVB4hAzbvV8yPdOo7wvRGfR84BIKC/omVYXoni9K9S+0hw//GLzAu9SvKilxd0E2YpAkKFoJGZFzJ+fmJv4NjFz0MoYyHGZtiVjZG6GAisNJ37OQ4fXCIyBjzcM7dYlpRK5LGeb6bMMX+jy6M796Zc7OyAYCGJgipXZj5Sqjegnf4d56ec9xOIPtmZiq5RuhbVU6nOV04gb2kwZJm4oxlDLpsciHz/Bnxs0r+dsV3mUt4bv9g/p0/4bC4q6yo95GHrrU3l+GiOOOnXrw==;5:HabVN6yWWqIh3wCGbjm02kdp/sRK+lRXVz0l1ZcrykNha1Fz5TKMOSwJyRT7WEmwCJWDTTVr4WWbF9SUEjm0NvIJ4sbV6FeH5xiKQWbDJRG0YRmjRRDZ2Jv5dJyGXeli166Yc/9qIozvAh+PQ52b3vExzMJ6d8L+rGSnMfNJHBg=;24:/8GTKMmzA/cWkzzVsl5hcH1sH9GF99LlfUb0lp+Ox9lb8g/KHMdh8XY4E6Tl4s40Yq7g4uAWEvoD8/eJhP0EiQzfp02BIIccy+pYYPD25gc=;7:YQdWD8XvCbCpvmQpajkKRhED1yXbJWQTCYLAkXT8fzADw/wIalivoIeGGdJGaUfVu+1i0VNrjMk9dIEJ7Ao1B03q5xf2i9v72gwDebu41psJjvHYWB83Ts1BWH9xWwWEe5vEsDN73PY1UZ2QxMgmmKNL9YKjbfCp7OHbynhAwO+ai1OqfzlF6ZlAZuH1MCJ90Nc59kdx/rL2jeGRxgUfzqIppAIb/BxefnsyV/eUepQ=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: c04c45d9-7dea-4f6a-8304-08d4fbbd7c5e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(2017082002075)(300000503095)(300135400095)(2017052603199)(201703131423075)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:PS1PR0601MB1481;
x-ms-traffictypediagnostic: PS1PR0601MB1481:
x-exchange-antispam-report-test: UriScan:;
x-microsoft-antispam-prvs: <PS1PR0601MB1481EA65CB4A8F544D69EFBD8A6F0@PS1PR0601MB1481.apcprd06.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(3002001)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(6041248)(20161123564025)(20161123558100)(2016111802025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123562025)(20161123555025)(6072148)(6043046)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:PS1PR0601MB1481;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:PS1PR0601MB1481;
x-forefront-prvs: 0430FA5CB7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(6009001)(39830400002)(376002)(346002)(189002)(199003)(558084003)(9686003)(105586002)(106356001)(6436002)(55016002)(99286003)(110136004)(74482002)(5250100002)(101416001)(68736007)(2501003)(316002)(33656002)(14454004)(6506006)(2906002)(54356999)(189998001)(50986999)(2900100001)(7696004)(3660700001)(66066001)(7736002)(6916009)(42882006)(5640700003)(3846002)(102836003)(305945005)(6116002)(25786009)(74316002)(53936002)(8936002)(81166006)(2351001)(3280700002)(5660300001)(97736004)(86362001)(81156014)(1730700003)(478600001)(8676002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:PS1PR0601MB1481;H:PS1PR0601MB1883.apcprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: nlc.co.nz does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nlc.co.nz
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2017 22:11:01.8635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dcf97d24-0da4-497e-88f4-de71fd6a3c56
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR0601MB1481
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
          "git diff -name-status" is useful to list the files one has chang=
ed but it does not list file that one has deleted with "git rm". It would b=
e really handy if it did. I am using git 2.9.3 on Ubuntu Linux 16.10.

Yours Sincerely,

Gene Thomas.
