Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 095C61F790
	for <e@80x24.org>; Tue,  2 May 2017 19:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbdEBTtM (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 15:49:12 -0400
Received: from us-smtp-delivery-131.mimecast.com ([63.128.21.131]:59374 "EHLO
        us-smtp-delivery-131.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750825AbdEBTtL (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 2 May 2017 15:49:11 -0400
X-Greylist: delayed 921 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 May 2017 15:49:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=StratusTechnologies.onmicrosoft.com; s=selector1-stratus-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dVAtTGHkm6S68DuiM9WgawAjpOF5Cihla6HLfI3oz20=;
 b=JwdK3iAh7lu//VHMmiX1s1Ia+YWnSDUjphHrDfJzhUZbO/kVmGAGra/lcbi5boQ8a9HxTWHf6RG/Gm1/Z4DJiAnnLMQuUb+0WmLpS1bejHBOAPDwySdfqog8Ol+wyuQvqYtXpknRob0WyBaGIlBZH/Ii4YmCb5d1+oF8CfUDUv0=
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02lp0054.outbound.protection.outlook.com [207.46.163.54])
 (Using TLS) by us-smtp-1.mimecast.com with ESMTP id
 us-mta-84-8yKIv5GGPySQV77g4FzASg-1; Tue, 02 May 2017 15:33:46 -0400
Received: from SN2PR0801MB575.namprd08.prod.outlook.com (10.160.15.152) by
 SN2PR0801MB574.namprd08.prod.outlook.com (10.160.15.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1047.13; Tue, 2 May 2017 19:33:44 +0000
Received: from SN2PR0801MB575.namprd08.prod.outlook.com ([10.160.15.152]) by
 SN2PR0801MB575.namprd08.prod.outlook.com ([10.160.15.152]) with mapi id
 15.01.1047.023; Tue, 2 May 2017 19:33:45 +0000
From:   "Desjardin, Donald" <Donald.Desjardin@stratus.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Reference help
Thread-Topic: Reference help
Thread-Index: AdLDcvC9JHqcF7mkSFuGCB5GRj+s0w==
Date:   Tue, 2 May 2017 19:33:45 +0000
Message-ID: <SN2PR0801MB575DC31D49660CF33DFFE2599170@SN2PR0801MB575.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.97.42.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR0801MB574;7:seT4vhIg6RAnXlWwm5fmXfYVS1RgHXSv6XQPgPvFcDTqPLow9YIOrP2qfH45FJ0xk8ejNoeywivx6I7WWMGq4ZqyRHrqypC3AyaBkRtjsbXXBWhhTVSGY8EhNM1RFk7L8T4iR/PxVBXgNAI6tEp3V7dnyAGtjgfvFk5OQIV/ERMgFY9DH2HrNmVigvJtaFymFgb2u4A0J52pH5c7MQ0tfgXwknO45+c/5ZrxRjH4oTiAIcALNFu6/3jCt3s8hohgf1yzP7eoF+jEYpVpGwQi011GP+Q1lKMxkZ1oqUtDprB5Idj5YI2jczxqylHdKiUdacN9OW6CY7sXZzYTTHiPKQ==;20:VbJSSioK90znyPyLGZjeH0rbMad1z7qNwAiD0hNjfqwV8O6FJ5rEc1fbaiTAVn9ZcoR6/1vgII45xyW9XgXBA6hNiUpzkNdPHKMvStVPzmdfJkTD2m69dtbvmr966Y1Oh87KtHwGin7CtHgIiQgXiskQzZAP725eg1Qw2tDOwmg=
x-ms-office365-filtering-correlation-id: 2d567e93-b4e0-4a06-c1ed-08d4919225f0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254075)(201703131423075)(201703031133081);SRVR:SN2PR0801MB574;
x-microsoft-antispam-prvs: <SN2PR0801MB574C8B0956F8BE4F57B50AB99170@SN2PR0801MB574.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(6041248)(20161123562025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(20161123560025)(20161123564025)(6072148);SRVR:SN2PR0801MB574;BCL:0;PCL:0;RULEID:;SRVR:SN2PR0801MB574;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39400400002)(39840400002)(39410400002)(6916009)(25786009)(6116002)(7696004)(110136004)(8676002)(221733001)(9686003)(54356999)(50986999)(1730700003)(77096006)(6506006)(3280700002)(53936002)(38730400002)(2906002)(99286003)(6436002)(5640700003)(2900100001)(33656002)(3660700001)(81166006)(7736002)(66066001)(5660300001)(305945005)(2501003)(3480700004)(7116003)(189998001)(3846002)(102836003)(8936002)(122556002)(2351001)(74316002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR0801MB574;H:SN2PR0801MB575.namprd08.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: stratus.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2017 19:33:45.2679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: de36b473-b8ad-46ff-837f-9da16b8d1b77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR0801MB574
X-MC-Unique: 8yKIv5GGPySQV77g4FzASg-1
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry if this is not the place for this.

I'm looking for any reference to potential problems when updating a git cli=
ent (say from 1.7.N to 1.8.N) with old workspaces.

The scenario is this:
=09Lots of developers use a single machine for work
=09They have lots of workspaces created using the old client
=09We want to upgrade to the new client

Are there any potential problems just upgrading the client and NOT re-cloni=
ng their workspaces (or stashing or committing or pushing)?

Subversion had/has some feature that could tell that the workspace was crea=
ted using an older client and you could magically run something to update t=
he workspace.

I'm not above telling all my developers to commit/push to a feature branch,=
 remove the workspaces and re-clone as needed on a flag-day, but I'd like t=
o know if I have to.

If there is any documentation that talks about this (I know 1.7 is old).

Thanks,

Don Desjardin

