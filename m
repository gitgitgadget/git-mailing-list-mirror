Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E1051F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeCPUYE (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:24:04 -0400
Received: from mail-by2nam01on0072.outbound.protection.outlook.com ([104.47.34.72]:28800
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751672AbeCPUYD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aei.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=maXOThHvG4mvio1qXL92eVXBEcecu2CXM9nMW0si1oc=;
 b=lCOdSsP/S+k3h0rTK951XTWjcLra6SQ7OO8CN+jIRPYDW/BxNqBGTBaZkiYuaiKYIV1QEyyN2soRXn1MsF+s+hu7fpfiV6s8rVIi9usrYvRd1HhkWd1BR9Q3Vur1R73cpLnDgNT7gRSEKLogGrh4YCk+waNsTX/8fo938PX+PkY=
Received: from CY4PR02MB2262.namprd02.prod.outlook.com (10.169.181.15) by
 CY4PR02MB2245.namprd02.prod.outlook.com (10.169.181.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.567.14; Fri, 16 Mar 2018 20:24:01 +0000
Received: from CY4PR02MB2262.namprd02.prod.outlook.com
 ([fe80::68ff:36cb:be97:49ee]) by CY4PR02MB2262.namprd02.prod.outlook.com
 ([fe80::68ff:36cb:be97:49ee%17]) with mapi id 15.20.0567.019; Fri, 16 Mar
 2018 20:24:01 +0000
From:   "Briggs, John" <JOHN.BRIGGS@aei.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "git-for-windows@googlegroups.com" <git-for-windows@googlegroups.com>
Subject: RE: getting fatal error trying to open git gui
Thread-Topic: getting fatal error trying to open git gui
Thread-Index: AdO9WOQXVglR2Ht0QsiCtxNKgnqGlAACC9gAAADf8BA=
Date:   Fri, 16 Mar 2018 20:24:01 +0000
Message-ID: <CY4PR02MB2262A567EE2D2A54316BFE3FFFD70@CY4PR02MB2262.namprd02.prod.outlook.com>
References: <CY4PR02MB22621DE7751427686029C1B3FFD70@CY4PR02MB2262.namprd02.prod.outlook.com>
 <20180316195756.GA151588@aiede.svl.corp.google.com>
In-Reply-To: <20180316195756.GA151588@aiede.svl.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcamJyaWdnc1xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWY0ZjNmZDcxLTI5NTctMTFlOC1hOTA3LWQ0ODFkN2E2MmViNlxhbWUtdGVzdFxmNGYzZmQ3My0yOTU3LTExZTgtYTkwNy1kNDgxZDdhNjJlYjZib2R5LnR4dCIgc3o9IjgyNCIgdD0iMTMxNjU3MDU0MzkzNDE0Nzk3IiBoPSIxUVZHTE5jcjNLdDdQelNGVk1hOXY1RW84OXc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-originating-ip: [8.39.233.75]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR02MB2245;20:J5OT6hY7Z5LtDkr5z913Ndi6OdRLTXR1yeRVUu1k3Axwpitt5N059b4ixrSHxJHRlcxA3MguL92qr2goL6u78iUiA7frxPlnW2N6VH8lQyMcP/yaZN/0Y6ymuzp4Vp1tkKV/BebrdJWeGMtPdWpYQo76sRa8HhJU9o4/PehFPTQ=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 9f925892-0ae7-4aac-16f3-08d58b7bdb09
x-microsoft-antispam: UriScan:(215639381216008)(28748798796193);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:CY4PR02MB2245;
x-ms-traffictypediagnostic: CY4PR02MB2245:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOHN.BRIGGS@aei.com; 
x-ms-exchange-orgnaization-bypassclutter: true
x-microsoft-antispam-prvs: <CY4PR02MB2245212AC1C45E4E1BEDCD32FFD70@CY4PR02MB2245.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(215639381216008)(9452136761055)(85827821059158)(28748798796193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501284)(52105095)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR02MB2245;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB2245;
x-forefront-prvs: 0613912E23
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(346002)(39830400003)(39380400002)(396003)(366004)(199004)(189003)(13464003)(3846002)(6116002)(2906002)(102836004)(6506007)(478600001)(1411001)(53546011)(186003)(3280700002)(26005)(106356001)(5660300001)(316002)(33656002)(2900100001)(3660700001)(5250100002)(105586002)(66066001)(76176011)(6916009)(7696005)(9686003)(229853002)(55016002)(2950100002)(7736002)(53936002)(81166006)(8676002)(4326008)(6436002)(8936002)(25786009)(81156014)(54906003)(97736004)(39060400002)(68736007)(72206003)(6246003)(305945005)(14454004)(99286004)(74316002)(86362001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2245;H:CY4PR02MB2262.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: aei.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: V+Tsf57GfPczzrWYM0Jaj6S0XWFRmRYVHyzh8vqtKEaROI754++yfWY/Ou1pzX2d4PpHZL88/UVKYz6Wwk47X0IpkyajOo8x3yof0JUc6HzIBuDlIw/xT1oyjbE8zjibtvEGUKBSN/P3v/BB9zMWNeGsXWMTrUToklQEgCanB5cMj2zK3v6PJEKKYeEUTee9qCYpA62S+Y32PHg/XbfVZpc3sL9SezBwupjtkw+BYJjSvEiCMCBWmX/9M9UXpO5mQO1EVn57kxRzffYGC6BFYVFE51tG875zXsSce5s63/PTEKpgzI3FmxpUx5AFtH1iIyJlun0jb3Ld9K0gu36v+w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aei.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f925892-0ae7-4aac-16f3-08d58b7bdb09
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2018 20:24:01.3743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cfa7d515-0462-4766-8d7f-867b7825994a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2245
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Got it figured out. Git gui must be ran as administrator.

John

-----Original Message-----
From: Jonathan Nieder <jrnieder@gmail.com>=20
Sent: Friday, March 16, 2018 1:58 PM
To: Briggs, John <JOHN.BRIGGS@aei.com>
Cc: git@vger.kernel.org; git-for-windows@googlegroups.com
Subject: Re: getting fatal error trying to open git gui

Hi,

Briggs, John wrote:

> I just installed git for windows 10 and am getting "git-gui: fatal error"=
 "Cannot parse Git version string.
>
> When I execute "git version" in the command prompt I get Git version=20
> 2.16.2.windows.1
>
> Everything else seems to be working. How can I get the gui to work?

That's strange indeed.  Why is Git capitalized when you run "git version"?

Thanks,
Jonathan
