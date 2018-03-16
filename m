Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38FEF1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 21:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751437AbeCPVBV (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 17:01:21 -0400
Received: from mail-by2nam01on0050.outbound.protection.outlook.com ([104.47.34.50]:45712
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750921AbeCPVBU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 17:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aei.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6VlJvGiCIZnGi9f0XdjqSzh5Ha2OM/g3l5oZAf8RXa8=;
 b=m5TMW7DKFbdg9cV5GrImU8DD2D/ni1QL3ytbi9xRo+Uslmy14z2Mbg6gu8io5ARebff/uImW2wm2j18G1C/edEKhBuDaIgBQNkjVeW4Qj43YqG7Bd20M7okyzHkcE8H04k7HwxKfUJFFddKthBnbbpWeXjJyqlGRk2VHj+MhW6k=
Received: from CY4PR02MB2262.namprd02.prod.outlook.com (10.169.181.15) by
 CY4PR02MB3157.namprd02.prod.outlook.com (10.165.88.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.588.14; Fri, 16 Mar 2018 21:01:17 +0000
Received: from CY4PR02MB2262.namprd02.prod.outlook.com
 ([fe80::68ff:36cb:be97:49ee]) by CY4PR02MB2262.namprd02.prod.outlook.com
 ([fe80::68ff:36cb:be97:49ee%17]) with mapi id 15.20.0567.019; Fri, 16 Mar
 2018 21:01:17 +0000
From:   "Briggs, John" <JOHN.BRIGGS@aei.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "git-for-windows@googlegroups.com" <git-for-windows@googlegroups.com>
Subject: RE: getting fatal error trying to open git gui
Thread-Topic: getting fatal error trying to open git gui
Thread-Index: AdO9WOQXVglR2Ht0QsiCtxNKgnqGlAACC9gAAADf8BAAAQndgAAAEKvQ
Date:   Fri, 16 Mar 2018 21:01:17 +0000
Message-ID: <CY4PR02MB2262A382E033B50B3800A69CFFD70@CY4PR02MB2262.namprd02.prod.outlook.com>
References: <CY4PR02MB22621DE7751427686029C1B3FFD70@CY4PR02MB2262.namprd02.prod.outlook.com>
 <20180316195756.GA151588@aiede.svl.corp.google.com>
 <CY4PR02MB2262A567EE2D2A54316BFE3FFFD70@CY4PR02MB2262.namprd02.prod.outlook.com>
 <20180316205243.GB151588@aiede.svl.corp.google.com>
In-Reply-To: <20180316205243.GB151588@aiede.svl.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcamJyaWdnc1xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTI5ZDAyOGM3LTI5NWQtMTFlOC1hOTA3LWQ0ODFkN2E2MmViNlxhbWUtdGVzdFwyOWQwMjhjOS0yOTVkLTExZTgtYTkwNy1kNDgxZDdhNjJlYjZib2R5LnR4dCIgc3o9IjE1ODgiIHQ9IjEzMTY1NzA3Njc1NTEzNTYwNSIgaD0iNG5NMkRVL21RNHpqQThlM1o4V0hrVkRwd2VRPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOHN.BRIGGS@aei.com; 
x-originating-ip: [8.39.233.75]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR02MB3157;7:C1lEqvClCj7SmooHwdvFVDkNgu7qQ7gWHdpIVqgpRi4GXE9fHQu9HFBP7+w5pzGulh01wLtX7vYNQXXByM8LcPM+badqxuh91TITJYmuOjQXtiHoYj5Xf3bO85POVfTf6+9YhFbECsyggRhrXkwA+H6CU8ETIjNEkv0MVpVK3BWNcVTd8UUc1+BhaYn6pBY7wwbo1MMZy3gPk6JfbJtCTDI3nPjJ8mKtoMESuM6eLYFxJrvsmByvtgZzlmfKiTNP;20:xjQm5uVFIer4MLCwxMhBUBaUoQX7ip1wCCwzx4xqSjsP6ieu+RKZp69g/dyOWEbY7YsF18042nXh9/ga3SsICNns7HBsZpr0kHQRYDOV1FhJNs7tNryW0pySPGgd+jklpaeufS5gYwnU1GZVKKUTji6KwSxhQ2NeW1/VBD03X8c=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 1ce40420-b03d-4b0b-8867-08d58b810ff1
x-microsoft-antispam: UriScan:(215639381216008)(28748798796193);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:CY4PR02MB3157;
x-ms-traffictypediagnostic: CY4PR02MB3157:
x-ms-exchange-orgnaization-bypassclutter: true
x-microsoft-antispam-prvs: <CY4PR02MB3157B2433B5EA75BA6DDD746FFD70@CY4PR02MB3157.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(215639381216008)(9452136761055)(85827821059158)(28748798796193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR02MB3157;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB3157;
x-forefront-prvs: 0613912E23
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(346002)(366004)(39850400004)(396003)(13464003)(199004)(189003)(377424004)(14454004)(106356001)(33656002)(99286004)(93886005)(26005)(72206003)(105586002)(54906003)(76176011)(2906002)(2950100002)(6506007)(6916009)(102836004)(316002)(97736004)(68736007)(7696005)(66066001)(478600001)(6116002)(3280700002)(186003)(3846002)(3660700001)(8676002)(5250100002)(39060400002)(7736002)(74316002)(2900100001)(6436002)(6246003)(229853002)(81156014)(81166006)(53546011)(8936002)(86362001)(1411001)(5660300001)(305945005)(55016002)(25786009)(53936002)(9686003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB3157;H:CY4PR02MB2262.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: aei.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZiHP//TOKnVj5qHnMLnW+yLJnb+HP8PirsXyFlkG/f+RJHFCXRQEXtTuzM4/GsaQJTXmrADTRMWnPohA0SKRJ/aUQuOI6WRI7qz+ZCETT+XrtI0zlBX13LZUN/EPlrzXLi7RCS9a7LeZfNWsAZg09WKdn7yXgzH3b4mRMFejZyk8R4nB+UuQw9uTvjKhEHUvTdCCYm6NXV9qKbVTo0sfEaccxKSlBGwU3T5St5aHpIAPmI8TYku0titorNi93Ly/opDAwUeqYOigd1iEjqctQGG8SS3gsgwpjDcjpGDXGAuYhXexYksB9kKG32rwHzXBQ6SAgQfo+DAzfLEh+Rzn7A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aei.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce40420-b03d-4b0b-8867-08d58b810ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2018 21:01:17.6385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cfa7d515-0462-4766-8d7f-867b7825994a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No, it was a fresh install.  Plus file search reveals only one copy of the =
file.

I also noticed that I cannot use the file properties to run as administrato=
r. I must right-click on Git GUI and select "More >> Run as administrator" =
in the start menu. Even though I have "run as administrator" checked on bot=
h shortcut and the program (or any combo of).

John

-----Original Message-----
From: Jonathan Nieder <jrnieder@gmail.com>=20
Sent: Friday, March 16, 2018 2:53 PM
To: Briggs, John <JOHN.BRIGGS@aei.com>
Cc: git@vger.kernel.org; git-for-windows@googlegroups.com
Subject: Re: getting fatal error trying to open git gui

Briggs, John wrote:
> Jonathan Nieder wrote:
>> Briggs, John wrote:

>>> I just installed git for windows 10 and am getting "git-gui: fatal=20
>>> error" "Cannot parse Git version string.
>>>
>>> When I execute "git version" in the command prompt I get Git version
>>> 2.16.2.windows.1
>>>
>>> Everything else seems to be working. How can I get the gui to work?
>>
>> That's strange indeed.  Why is Git capitalized when you run "git version=
"?
>
> Got it figured out. Git gui must be ran as administrator.

Hm, that leaves me even more mystified.

Before v1.7.4-rc0~155^2~4 (git-gui: generic version trimming, 2010-10-07), =
git-gui was not able to handle "git version" output like "git version 2.16.=
2.windows.1", but since then, it should have been able to cope fine with it=
.

I wonder: do you have multiple versions of git gui installed?

Thanks,
Jonathan
