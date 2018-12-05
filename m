Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FFB0211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 23:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbeLEXmO (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 18:42:14 -0500
Received: from mail-eopbgr740059.outbound.protection.outlook.com ([40.107.74.59]:51440
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727630AbeLEXmO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 18:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEKocVBzxpehzwMIkfWHZGiIG+qafiQK7Z7YNe/f31Y=;
 b=CVRt1ysDBTkWLhMWPuyCnnKNjg8+zVnka/jVyKio8leWrEEnq3KMP/ivYvlkzL+itWyy7H07/baQrX8a+ot8NHc0MAmQa27CSu5nXdNWhUgLxu+hDf/StG6c9jDgo0MifY190muGXMynxM/P146PdYqyS+PJ1LXf12pgays4plw=
Received: from BLUPR12MB0609.namprd12.prod.outlook.com (10.163.217.158) by
 BLUPR12MB0449.namprd12.prod.outlook.com (10.162.92.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.18; Wed, 5 Dec 2018 23:42:10 +0000
Received: from BLUPR12MB0609.namprd12.prod.outlook.com
 ([fe80::44f5:c0e3:aa8d:cdc]) by BLUPR12MB0609.namprd12.prod.outlook.com
 ([fe80::44f5:c0e3:aa8d:cdc%2]) with mapi id 15.20.1404.019; Wed, 5 Dec 2018
 23:42:10 +0000
From:   "Coiner, John" <John.Coiner@amd.com>
To:     =?Windows-1252?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
CC:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>
Subject: Re: git, monorepos, and access control
Thread-Topic: git, monorepos, and access control
Thread-Index: AQHUjNb17VOhv0VzH0eWemPQb0yQOKVwmkaAgAACfICAAAQSgIAABBUAgAAprIA=
Date:   Wed, 5 Dec 2018 23:42:09 +0000
Message-ID: <cdeb9dc9-ac25-23c8-f3b9-9a7987be7df0@amd.com>
References: <939efd87-b2af-29d7-efdd-9cf8f6de9d10@amd.com>
 <878t13zp8y.fsf@evledraar.gmail.com>
 <a5a3009e-346e-2b63-5b7c-3e9daf0c7de2@gmail.com>
 <CACsJy8AzMvG3U5GnVkn0Ax3XP3NnPCwwc1AzdVV9JkePfMjwWg@mail.gmail.com>
 <877egnznhh.fsf@evledraar.gmail.com>
In-Reply-To: <877egnznhh.fsf@evledraar.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR1201CA0001.namprd12.prod.outlook.com
 (2603:10b6:405:4c::11) To BLUPR12MB0609.namprd12.prod.outlook.com
 (2a01:111:e400:594f::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Coiner@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.10.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR12MB0449;20:aypHvjcl2EHzerEU2XWx/lhNRxzKg7ZTYfExyXuPsJtqGNbut7o7WcF7+z3BgY1fV0uQFgeY+34yVGMVWg7s197jUZUfCGHxCbVSs27gKByWre8Ggq8qrck9hR3fSTF+RWWi0IHMmaiKTMgWANE+k4fK46MFai7RYrevXuDbyedXM07Z08kvl07GUl8mrLqpUHHL/9R8DuXQJfFxj2vSoeGQpvWQDv3nU0LRDOTVN5pq6oA7W397IQnw68UWDQCe
x-ms-office365-filtering-correlation-id: 13c5e0ff-dbc4-42e2-7f6a-08d65b0b45e3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BLUPR12MB0449;
x-ms-traffictypediagnostic: BLUPR12MB0449:
x-microsoft-antispam-prvs: <BLUPR12MB04490D42BCB2658BD9BEEA36ECA80@BLUPR12MB0449.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BLUPR12MB0449;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0449;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(136003)(39860400002)(189003)(199004)(229853002)(7736002)(25786009)(97736004)(446003)(14454004)(6116002)(476003)(8936002)(3846002)(6486002)(106356001)(66066001)(68736007)(26005)(53546011)(186003)(76176011)(256004)(11346002)(14444005)(39060400002)(102836004)(52116002)(6506007)(4326008)(478600001)(72206003)(386003)(71190400001)(2616005)(66574009)(305945005)(5660300001)(71200400001)(54906003)(110136005)(53936002)(93886005)(486006)(86362001)(316002)(6436002)(105586002)(6512007)(81156014)(81166006)(8676002)(31696002)(2906002)(6246003)(99286004)(36756003)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0449;H:BLUPR12MB0609.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lX9GXcnu1RQktxS2VIreIkja8dfBMg4LkNsYLXCCMFvSl1Sf+vXTL4dN0LbNq39FnSfKDqncSVGZHX94YxaQiCMUPwrfEeM3uCkCFUra1CGu4UlEVAaxes/XXKjFsnq0QFgEFrWJK9uWsaMfiqp/t3h5E8tUfoGTRZ/89r1rv1rT6Ul+2ugyQCWglgAWjByQpnx1w5fMArluNYSFFTrHzJbcKq/Ydq2v40hjiGB5OJlX2AV5VxEOMm66h568QC9zmr1hfQUtY9/4Lu9uj66ATh+51mEZjMAYUs2tasp2UlqiRmB0nVAH1vPrfFrURJlmlqTDi70SUVO/2h7TQ6HMbIYHSrFAb43mJk6JBzxzc4I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <6F1E035BF1AC074AB3A62FCE1D033B04@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c5e0ff-dbc4-42e2-7f6a-08d65b0b45e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 23:42:09.9112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0449
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

inline...

On 12/05/2018 04:12 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Wed, Dec 05 2018, Duy Nguyen wrote:
>
>>
>> Another option is builtin per-blob encryption (maybe with just
>> clean/smudge filter), then access control will be about obtaining the
>> decryption key (*) and we don't break object storage and
>> communication. Of course pack delta compression becomes absolutely
>> useless. But that is perhaps an acceptable trade off.
> Right, this is another option, but from what John described wouldn't
> work in this case. "Any hypothetical AMD monorepo should be able to
> securely deny read access in certain subtrees to users without required
> permissions".
>
> I.e. in this case there will be a
> secret-stuff-here/ryzen-microcode.code.encrypted or whatever,
> unauthorized users can't see the content, but they can see from the
> filename that it exists, and from "git log" who works on it.

Ah, clean/smudge has potential. It locates the security boundary=20
entirely outside the git service and outside the repo. No big software=20
engineering project is needed. It should work in VFSForGit just as it=20
does in plain old git. Beautiful!

For our use case, it might be OK for commit logs, branch names, and=20
filenames to be world-readable. Commit logs are probably the greatest=20
concern; and perhaps we could address that through other means.

Maybe it's possible to design a text-to-text cipher that still permits=20
git to store compact diffs of ciphered text, with only modest impact on=20
security?

Thank you all for your thoughtful replies.

>
> This is a thing I know *way* less about so maybe I'm completely wrong,
> but even if we have all the rest of the things outlined in your post to
> support this, isn't this part going to be susceptible to timing attacks?

That's a good point. It's not easy to estimate exposure to something=20
like this.

> For instance, Git is very eager to try to find delta-compression
> opportunities between objects, even if they don't have any relationship
> within the tree structure. So imagine I want to know the contents of
> tree X. I push up a tree Y similar to X, then fetch it back, falsely
> claiming to have X but not Y. If the server generates a delta, that may
> reveal information about X (which you can then iterate to send Y', and
> so on, treating the server as an oracle until you've guessed the content
> of X).
Another good point. I wouldn't have thought of either of these attacks.=20
You're scaring me (appropriately) about the risks of adding security to=20
a previously-unsecured interface. Let me push on the smudge/clean=20
approach and maybe that will bear fruit.

Thanks again.

- John

