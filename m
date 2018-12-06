Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75555211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 22:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbeLFW7k (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 17:59:40 -0500
Received: from mail-eopbgr720072.outbound.protection.outlook.com ([40.107.72.72]:9696
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbeLFW7j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 17:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXYB/8a1X224uKAQLVmnOU1nac1hIoeiWMNguc8ZL6I=;
 b=5Qpf+lJ++0QGOqbdUjOHKdk1nqRoUUlBMFoNT3W/kfGSNSpiWIIp34/cY0PJzVEN+lRj9jW1hR2zusx4k1BYieQny0yRGUNHx7s7V94icUpSj5Jnyy5IgDJRYcz8FXa9fE5gYDpQr3o2Fh37PGXhLxAfRtlZuN5sonYvSP1BqNc=
Received: from BLUPR12MB0609.namprd12.prod.outlook.com (10.163.217.158) by
 BLUPR12MB0436.namprd12.prod.outlook.com (10.162.92.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Thu, 6 Dec 2018 22:59:36 +0000
Received: from BLUPR12MB0609.namprd12.prod.outlook.com
 ([fe80::44f5:c0e3:aa8d:cdc]) by BLUPR12MB0609.namprd12.prod.outlook.com
 ([fe80::44f5:c0e3:aa8d:cdc%2]) with mapi id 15.20.1404.021; Thu, 6 Dec 2018
 22:59:36 +0000
From:   "Coiner, John" <John.Coiner@amd.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git, monorepos, and access control
Thread-Topic: git, monorepos, and access control
Thread-Index: AQHUjNb17VOhv0VzH0eWemPQb0yQOKVwoZeAgAGDtoCAAC+4AA==
Date:   Thu, 6 Dec 2018 22:59:36 +0000
Message-ID: <5cfefe1f-08b9-60ac-1c7f-5f690d6b4208@amd.com>
References: <939efd87-b2af-29d7-efdd-9cf8f6de9d10@amd.com>
 <20181205210104.GC19936@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1812062100020.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1812062100020.41@tvgsbejvaqbjf.bet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:404:10b::21) To BLUPR12MB0609.namprd12.prod.outlook.com
 (2a01:111:e400:594f::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Coiner@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.10.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR12MB0436;20:TAiCU8Gzc1u38+7mRC1FJcF76OcbNdoLW5cyCJkIgVsqSs5fxBwHiPlrj5dHSACUcGryJ1EBOJW1hK/BdRqyiaSsPQUM/1tB/IrWd4JV98iMoszNFsgRmf9UmHE4QBdIHgwu30vFIISPJ3c0VJZ/K4rd7aAAKUIuykR8V/Q6V6NZbPXsVhw9ZSxQz0WV7PPwFvbBw4Qs88cv+/FPtGnLANjfiKRFw57h3bYYgEunWXwlEBoq0zpvyzsx+VmDyx1f
x-ms-office365-filtering-correlation-id: 20b47f86-715e-49d9-4562-08d65bce7e49
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BLUPR12MB0436;
x-ms-traffictypediagnostic: BLUPR12MB0436:
x-microsoft-antispam-prvs: <BLUPR12MB04360CA3757C9F16F7F4F1DCECA90@BLUPR12MB0436.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BLUPR12MB0436;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0436;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(366004)(199004)(189003)(71190400001)(6436002)(316002)(186003)(26005)(5660300001)(6512007)(8936002)(86362001)(6486002)(66066001)(106356001)(3846002)(6506007)(102836004)(386003)(6116002)(486006)(2616005)(110136005)(31696002)(25786009)(53546011)(53936002)(305945005)(476003)(7736002)(478600001)(31686004)(8676002)(11346002)(72206003)(36756003)(446003)(229853002)(76176011)(97736004)(4326008)(14454004)(71200400001)(52116002)(68736007)(256004)(14444005)(99286004)(6246003)(81166006)(81156014)(105586002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0436;H:BLUPR12MB0609.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LEM38fCdYGFZezDTJkzDVmozDvwXboWivFoV3CbWNvoBkjgnmtI+LqNsPvm4tosbPsBgHJWrQM8Vo4FKGMaYB9EIRm8lkos2V7KVENCcWf9ardQqtbWd4sG5rCafbRXhBa51gWmxpC/KD+1Xg4TeeEqxUdBrPUx0YGmOTLKFSv4mGZ3oGghTbYpPx7MDfTvo5o8fJ/kgYrcZ8j2+m9vm+gfcUFAZ3dTMxF0pAsdUgxujDgIlSI2ubc+DfNbLkITq4myZ21umvmZm832VZhQ+m6MKenwvcazkcGwFNkhabzB+MVA3GiRSo1tTQb68Hje4M50xCAG5vGkyP+l0mxzVyuWkFvBzM9+BrUV8PvbEXVw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <C867EDAE31310E4EAD4F17C3F5403939@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b47f86-715e-49d9-4562-08d65bce7e49
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 22:59:36.3678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0436
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes,

Thanks for your feedback.

I'm not looking closely at submodules, as it's my understanding that=20
VFSForGit does not support them. A VFS would be a killer feature for us.=20
If VFSForGit were to support submodules, we'd look at them. They would=20
provide access control in a way that's clearly nonabusive. I hear you on=20
the drawbacks.

AMD today looks more like the 100 independent repos you describe, except=20
we don't have automation at the delivery arcs. Integrations are manual=20
and thus not particularly frequent.

I'm probably biased toward favoring a monorepo, which I've seen applied=20
at a former employer, versus continuous delivery. That's due to lack of=20
personal familiarity with CD -- not any real objections.

Thanks,

John

On 12/06/2018 03:08 PM, Johannes Schindelin wrote:
> Hi,
>
> On Wed, 5 Dec 2018, Jeff King wrote:
>
>> The model that fits more naturally with how Git is implemented would be
>> to use submodules. There you leak the hash of the commit from the
>> private submodule, but that's probably obscure enough (and if you're
>> really worried, you can add a random nonce to the commit messages in the
>> submodule to make their hashes unguessable).
> I hear myself frequently saying: "Friends don't let friends use
> submodules". It's almost like: "Some people think their problem is solved
> by using submodules. Only now they have two problems."
>
> There are big reasons, after all, why some companies go for monorepos: it
> is not for lack of trying to go with submodules, it is the problems that
> were incurred by trying to treat entire repositories the same as single
> files (or even trees): they are just too different.
>
> In a previous life, I also tried to go for submodules, was burned, and ha=
d
> to restart the whole thing. We ended up with something that might work in
> this instance, too, although our use case was not need-to-know type of
> encapsulation. What we went for was straight up modularization.
>
> What I mean is that we split the project up into over 100 individual
> projects that are now all maintained in individual repositories, and they
> are connected completely outside of Git, via a dependency management
> system (in this case, Maven, although that is probably too Java-centric
> for AMD's needs).
>
> I just wanted to throw that out here: if you can split up your project
> into individual projects, it might make sense not to maintain them as
> submodules but instead as individual repositories whose artifacts are
> uploaded into a central, versioned artifact store (Maven, NuGet, etc). An=
d
> those artifacts would then be retrieved by the projects that need them.
>
> I figure that that scheme might work for you better than submodules: I
> could imagine that you need to make the build artifacts available even to
> people who are not permitted to look at the corresponding source code,
> anyway.
>
> Ciao,
> Johannes

