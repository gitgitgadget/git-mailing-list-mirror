Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49B391F407
	for <e@80x24.org>; Fri, 15 Dec 2017 14:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932313AbdLOOLm (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 09:11:42 -0500
Received: from mx0a-00099f01.pphosted.com ([67.231.149.228]:34006 "EHLO
        mx0b-00099f01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932175AbdLOOLf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2017 09:11:35 -0500
Received: from pps.filterd (m0074057.ppops.net [127.0.0.1])
        by mx0a-00099f01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBFEB1we018655
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 08:11:34 -0600
Received: from crexpp04.us.aegon.com (email2.aegonusa.com [162.123.17.223])
        by mx0a-00099f01.pphosted.com with ESMTP id 2eutubctm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 08:11:34 -0600
Received: from pps.filterd (crexpp04.us.aegon.com [127.0.0.1])
        by crexpp04.us.aegon.com (8.16.0.21/8.16.0.21) with SMTP id vBFE2T6G008507
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 08:11:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Aegon.onmicrosoft.com;
 s=selector1-transamerica-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9T14/QzZg9KnriEuiAE6BzVJZxqUSJNykmKyyyGtS94=;
 b=r7dLiOpBl78kRVAKd8nCiDOJA8A4ZCp1dIe3fqMvhOJiGWYiYD3UdYnH3hEO5w6VZ9vyK3zR0bNuH+O3Xq+eXtEJkwz96zzXEpfQe4Xqk25KFhiqOlr74jhtTLz2VbMEahrKbDoTvnEhCV/q4AepC+BL16Gj9UvBQF12le111ck=
From:   "Bennett, Brian" <Brian.Bennett@Transamerica.com>
To:     Todd Zullinger <tmz@pobox.com>
CC:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH] git-svn: convert CRLF to LF in commit message to SVN
Thread-Topic: [PATCH] git-svn: convert CRLF to LF in commit message to SVN
Thread-Index: AQHTdHFuWnnnHps2g06igDYAs65ZuaNDTppggAA08ICAAPB00A==
Date:   Fri, 15 Dec 2017 14:11:25 +0000
Message-ID: <BL2PR05MB2179566C1EAE01C2ED34E7CC850B0@BL2PR05MB2179.namprd05.prod.outlook.com>
References: <BL2PR05MB2179DEBF7123ACD090E60F2685340@BL2PR05MB2179.namprd05.prod.outlook.com>
 <20171214002050.GA32734@whir>
 <BL2PR05MB217980546899C5B8EFDE06FF850A0@BL2PR05MB2179.namprd05.prod.outlook.com>
 <20171214234943.GF3693@zaya.teonanacatl.net>
In-Reply-To: <20171214234943.GF3693@zaya.teonanacatl.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [162.123.17.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL2PR05MB2177;20:kghx1Fxw16kpHXJNB7sCnXQ4EaED3X/3s+eRVf0n+ZT0xe4DgnelwhQKaqXzM9TLW/ddpFiTDc8hT8naPxe9katngWRHppkGsPmWyKwJio+FQh3aKlzOi2vKzxgCf/3RShumJPVwQ1WkCGY17oflfOpMI+Imb2r72EdZT8C/+v/EiOjxh816AodtQNEPFLo4nQGVH18V6/50Ip6RX8J9Pw38Eiq+f9UmiWPC1E3NUlkhKO5rUg3yK7sgjFD0t+YgaWImltpBoHtilKIVRzqksXqLu6H3r5aJgI2aLbFglXMmHJuk1/V+ueBwgSbmEsBwTUMmSedrCQ4gLcm7GHPuF8cPOiZf3KJaZNp5usH3sKVgdV7GnBBTa0aINAuFY17GUHx20fiofavT/vFxpiSDOS/+xl+Z/jjH6S1Qje+KhlWUEu/m/re8KzGXryekP+r7Iz4ZvTM+NMN580Wo6n1YNFE3e8ph21fmUme66vw6D7m8wS7ROFjoZHkVD8BNsAF1
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 0677b61c-8dba-4c1e-3ab0-08d543c5ba94
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603307);SRVR:BL2PR05MB2177;
x-ms-traffictypediagnostic: BL2PR05MB2177:
x-microsoft-antispam-prvs: <BL2PR05MB2177B0CF2F82B9A222A86B0A850B0@BL2PR05MB2177.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(83074219007389)(9452136761055)(116415991822766)(100324003535756)(81227570615382);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231023)(3002001)(10201501046)(6041248)(20161123555025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123558100)(6072148)(201708071742011);SRVR:BL2PR05MB2177;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:BL2PR05MB2177;
x-forefront-prvs: 05220145DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(366004)(24454002)(13464003)(189003)(199004)(55016002)(316002)(76176011)(2950100002)(6916009)(8656006)(7696005)(9686003)(6116002)(5660300001)(3846002)(102836003)(105586002)(106356001)(99286004)(2900100001)(8936002)(229853002)(33656002)(6436002)(5250100002)(93886005)(68736007)(15974865002)(15650500001)(25786009)(72206003)(345774005)(305945005)(4326008)(7736002)(66066001)(478600001)(74316002)(81166006)(81156014)(8676002)(54906003)(45080400002)(3280700002)(2906002)(97736004)(6246003)(86362001)(6506007)(53936002)(53546011)(14454004)(3660700001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR05MB2177;H:BL2PR05MB2179.namprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: Transamerica.com does not
 designate permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0677b61c-8dba-4c1e-3ab0-08d543c5ba94
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2017 14:11:25.8812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46e16835-c804-41de-be3c-55835d14dee4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR05MB2177
X-EXCLAIMER-MD-CONFIG: 7562670a-beab-4c6e-8ed2-ab3b5287c042
X-OriginatorOrg: transamerica.com
x-crexppdlp-TriggeredRule: module.access.rule.forcepoint_dlp_reroute
x-crexppdlp-TriggeredRule: module.access.rule.mcafee_dlp_reroute
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-12-15_06:,,
 signatures=0
X-RCIS-Action: ALLOW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-12-15_06:,,
 signatures=0
X-VPM-HOST: CREXZIX04.INET.NOGEA.LOCAL
X-VPM-GROUP-ID: 7045002e-1104-43b8-8bcd-fd894d0bce43
X-VPM-MSG-ID: 64a9e82d-5cf1-44a6-9ee5-ed2ad6dac187
X-VPM-ENC-REGIME: Plaintext
X-VPM-IS-HYBRID: 0
x-crexpp01-TriggeredRule: module.access.rule.Strip_Receive_HeadersV2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-12-15_06:,,
 signatures=0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-12-15_06:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you all for your guidance,

I have completed my test this morning with the patch and the 'git svn dcomm=
it' is now SUCCESSFUl!

Thank you again for all of your help and I'll await to see when the patch i=
s posted.

Brian Bennett | Supv System Admin & Support, TA TECH Change Mgmt/Production=
 Support
o: 319-355-7602 | c: 319-533-1094
e: brian.bennett@transamerica.com | w: www.transamerica.com

Transamerica
6400 C St. SW, Cedar Rapids, IA 52404 MS-2410
Facebook | LinkedIn


-----Original Message-----
From: Todd Zullinger [mailto:todd.zullinger@gmail.com] On Behalf Of Todd Zu=
llinger
Sent: Thursday, December 14, 2017 5:50 PM
To: Bennett, Brian <Brian.Bennett@Transamerica.com>
Cc: Eric Wong <e@80x24.org>; Junio C Hamano <gitster@pobox.com>; git@vger.k=
ernel.org
Subject: Re: [PATCH] git-svn: convert CRLF to LF in commit message to SVN

Hi Brian,

Bennett, Brian wrote:
> Thank you for your fast response,
>=20
> I haven't done a build of this type before (so I could test the patch=20
> first) so I'm trying to do that and get this far:
...
> I don't want to drag out testing the patch, so if either of you are=20
> able to quickly guide me on what I am doing incorrectly I am willing=20
> to get the build done so I can test it. If not, could one of you build=20
> with the patch and somehow get that to me so I could test?

I don't know about building git for windows, but since the git-svn command =
is a perl script, it might be easier to just patch that file.  I think you =
can find the path where git-svn is installed using: git --exec-path

For this one-liner, I'd just manually apply it.

(If you want to use 'git apply' or the patch command, you'll have to edit t=
he patch to adjust the name of the file, as it's git-svn.perl in the git tr=
ee.  The .perl suffix is dropped in the installed version.)

Hopefully that makes it easier for you to test Eric's patch.

--
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I am in shape.  Round is a shape.


