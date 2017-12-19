Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04D261F404
	for <e@80x24.org>; Tue, 19 Dec 2017 08:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934811AbdLSInK (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 03:43:10 -0500
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:45028
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934308AbdLSInF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 03:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arris.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6VTrYgNi7CXwVT8kXlK+fjP2o0DWEu+v5kJlvjYkZws=;
 b=AjFcm9rafbgdKy4dxZ6HTm8U77M/3QOhG9EIza1uF9F1eFsCsHY05HyQKwaIUxVERBGNemo/ONNKkIR9APMhfkU+/8ftmIN/KMWnmPs/ooIL8BnWfaRwM2bvFw49ZDk4KmzAlD4VTYXQ/lM1YQgjF77P+NxNlCEFgT21IChpm64=
Received: from BLUPR0101CA0036.prod.exchangelabs.com (10.163.116.174) by
 DM5PR01MB2682.prod.exchangelabs.com (10.172.185.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.323.15; Tue, 19 Dec 2017 08:43:04 +0000
Received: from BY2NAM01FT043.eop-nam01.prod.protection.outlook.com
 (2a01:111:f400:7e42::203) by BLUPR0101CA0036.outlook.office365.com
 (2a01:111:e400:52e8::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.323.15 via Frontend
 Transport; Tue, 19 Dec 2017 08:43:03 +0000
Authentication-Results: spf=pass (sender IP is 216.234.144.41)
 smtp.mailfrom=arris.com; pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=bestguesspass action=none
 header.from=arris.com;
Received-SPF: Pass (protection.outlook.com: domain of arris.com designates
 216.234.144.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.234.144.41; helo=webmail.arris.com;
Received: from webmail.arris.com (216.234.144.41) by
 BY2NAM01FT043.mail.protection.outlook.com (10.152.68.194) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.20.302.6 via Frontend Transport; Tue, 19 Dec 2017 08:43:03 +0000
Received: from ATLEXCH3.ARRS.ARRISI.COM (10.2.195.17) by
 ATLOWA2.ARRS.ARRISI.com (10.2.131.253) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 19 Dec 2017 03:41:57 -0500
Received: from ATLEXCH5.ARRS.ARRISI.com (10.2.131.23) by
 ATLEXCH3.ARRS.ARRISI.com (10.2.195.17) with Microsoft SMTP Server (TLS) id
 15.0.1178.4; Tue, 19 Dec 2017 03:41:56 -0500
Received: from ATLEXCH5.ARRS.ARRISI.com ([fe80::304f:2ad9:b296:d722]) by
 ATLEXCH5.ARRS.ARRISI.com ([fe80::304f:2ad9:b296:d722%24]) with mapi id
 15.00.1178.000; Tue, 19 Dec 2017 03:41:56 -0500
From:   "Carlsson, Magnus" <Magnus.Carlsson@arris.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Fetching commit instead of ref
Thread-Topic: Fetching commit instead of ref
Thread-Index: AQHTd/n5P2PiK0t7E0q8cmWqHBiCcqNJcHi+gADdIJ4=
Date:   Tue, 19 Dec 2017 08:41:56 +0000
Message-ID: <1513672915856.50628@arris.com>
References: <1513600223353.28799@arris.com>,<xmqqh8snyiz0.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqh8snyiz0.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.2.159.2]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:216.234.144.41;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(2980300002)(438002)(505004003)(189003)(199004)(374574003)(8676002)(69596002)(47776003)(81166006)(478600001)(86362001)(97876018)(81156014)(5250100002)(72206003)(2900100001)(14454004)(106466001)(5890100001)(36756003)(2906002)(117636001)(15974865002)(23756003)(4326008)(551944002)(6246003)(229853002)(53936002)(102836003)(3846002)(6116002)(50466002)(97736004)(5660300001)(356003)(305945005)(8746002)(8936002)(76176011)(8656006)(53546011)(316002)(2950100002)(6916009)(106002)(68736007)(59450400001)(7736002)(19627235001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR01MB2682;H:webmail.arris.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM01FT043;1:hmI3FOdgWkQk/NsZWcmgHqhQgBOlZD5pNjPDnJuR+yqPc4EMn//80RC+vOgbO7KGWLYwUttX30c1BKG/NtOiEAmUGEhsi8XeD5GFOGxqw45juS4re+UKNItMDK4ZQ8/Q
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03af50c3-ee45-422e-5eab-08d546bc8490
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4608076)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603307);SRVR:DM5PR01MB2682;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR01MB2682;3:fUYfqOld0wfYhmYj4KwXZJmHdmZb0oxCS2C3bpkWlIQCcMLw4wVl0ZHzYDOUz72u9cZ4lztKWKWb5Yn3dEl74aFWxDb5XCsYa3rI0GWejCtRv247MxgksH5nEvZV9GqPfi0dm2ePpRMjxj5SwYg124N1/DPsUdHa5FEUk/bH6WstOMFskR4BMJR073KzzRLSmT+BxstW0XfAy1Uy9NJBeZ+SuK+nqHvDI98t2E4K1eBIQWcTb8aO8uCDP3oAI0IgmVgYM6Hxn6ufP/cekt6eYWJwpjiQXsiNFUWr8ZsuAgQKVqgKN98l2dtXi027ZSwtZcQDdh0moi+zq1O977VteXBJ9TFARoHco1ozWl3sI9I=;25:qflEhiQLv4OqbKB6PH3R4dq0zeXYZbghnmF89BvB/Xr6XEHL6jGcm/OOcOrlmbIwlFzZsJKYmmcW9ndTuQm9qjrhOJ/bQYSkzsQbFthG/hY7glk7JUhGU1hlY7iTz9Z6Dh+9KB3R1UsekaaTkcROEKEZh97ZL0eze9MS2q//WnZfX+eBOpbUPFrKPDxXzz5IHzTxBUuSFlQptF9PbMFJCkC6qluRkN7WUwmERZ+0ZfuDUiVQCpoTYqZb3O7VU7O0KXgsq7dXW3PsEJ+t0TEoTYtzievg7yp4lIligQbHeYGPZTW9VKAv+7Jz7XTNSEsILGtShmwLp3WZ6iZ3DE5txw==
X-MS-TrafficTypeDiagnostic: DM5PR01MB2682:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR01MB2682;31:4v8ONEgXZg3pV52/2WH5u3ajZ2D5EjhmirW/gsb43TiYe+ts44jXcFNFjUacB8/1a807h7KITFDXdI1tWQtYz0Tbt8qzJf2tM2ibc3pdEUVm2EBfahP04y1B4tTNV45gZv7Y172I/pbi1XtuA/LaZenVKMe4d+VgT+K1XykeUsBy4BohK8FU1blS86dubHoqaooFIXP2ILuXkCg5sab1E3KZ8xVSdl8W546DUCRf13k=;20:6g3hHvw5xc6Oa6NFYDJQ8A6b6sUwj9cyVotDgnuuXcnvH6/FHaQSE8MgFchX7nXl0d8urrkAndYdVzMFEwe7hAKg5eByvZRpFZq+y97CMyHrYwMsyZrWIZnqmqnWSGDI39tRAoGWDElaQ+Y7nYvY4T0wK9tsImhplduSiW4hdaN3BelrTJvFs2p4FKfTZGaPp9td4oQ50wLFvrK9bhoH4buX8N3sRwQ4sKkhCOKVC8nN/GP4UdzF4jpd9FqJ/zOr80xAYDw7NzPDmiEgWNxizWxO6V7kHMr0zYc19wFJ45Bk4yncLcnRHlGRRKhNddKTs6XvWna4X/eM63SLYBbaqh8348RZi1YP12z8H19prYFH/0U5VuIjC2r91Qjyxh2qTXsnt9fNw0oY7lHTBMjfirgkDnf/YGiK1FKIX/XxX49Md+UaC30nWN6v4vp7iA4GJur7PuiGyslJGw4u/cDY+ND3n4q/NEA7TWe5cgkgsdKed1uZvefs4I3DAi/Ga49R
X-Microsoft-Antispam-PRVS: <DM5PR01MB2682618825BB02947DBFFF4EFE0F0@DM5PR01MB2682.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863)(104657075078662)(9452136761055)(100324003535756);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231023)(6055026)(6041248)(20161123555025)(20161123562025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123560025)(6072148)(201708071742011);SRVR:DM5PR01MB2682;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:DM5PR01MB2682;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR01MB2682;4:od3y3kxDln6fvYK46Dw2wpvFdqo2GQSVrgTtFzxMuRQvin15Fq6nDXA/WUSiylIs+3tLEmqAWh3lyHIa1lWhaH7+8sF106fIB86V6oLe3NibRP1TPMozmokESddnaT9qQJKw2KhL4Ki0O5Ef5eQz5Ihd6nl/wHUGqZhH9hvUR9/C96dBpy2ADjsrcAh9rVf3LLhxY8siWKYkfHeW4xgl+OvxMICBsyXlZUo/KFeHCuJ7k7xDZveW8NzEwXHSL2iwwz4iojGErGkzyuX78YsTkI213KCtW24GKr01pwv97zM2P28pp5uHm475+dA+Q+P42IZhQqoZSJdnnwWgaufaWMMCFcAYwPKWJ703sxEtwB6sOB3d2TCItN+tvVmanz4AnssJqQt5dv6SsU9FaqtbTOz/Lj4UNcHR1jDYuAOZxDA=
X-Forefront-PRVS: 052670E5A4
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;DM5PR01MB2682;23:lFRhHkr3L0A6X8n2THJQoTsZXgCQFR5SAkIZXtk?=
 =?iso-8859-1?Q?7n2v/EHqKEf2/ldsx+1PrV6to/G9aCECs18tmrjKs3m0t5HyGY5aievBVf?=
 =?iso-8859-1?Q?5s1PVqndsFF4dgBpnE3CWw14NgMbt4Uw75dB4nj1Ld2NVmoSwCYlaC93Tg?=
 =?iso-8859-1?Q?/prFcS5/gWyprxDm3HdKm3L4E05QP4JyldIHSpKU1RiWxL+mSVO+6Wkdqi?=
 =?iso-8859-1?Q?Bk9eTKdC6840TqR0Knsye0oMvMRytTUFuA6N7b/S8P5/YZlhWiblquAzWV?=
 =?iso-8859-1?Q?UIbcC0/QiLsLlhVFP++XYFXAuhEu1BqJYHYsUOP3CY/8L1RWeruihbcPAb?=
 =?iso-8859-1?Q?bkY8Nv+o61N5vbYsx0eg/lGg51Uc84MR0+PAhlVjm3IrqQonMVz5YYIKWo?=
 =?iso-8859-1?Q?E4uveRbblXcuxWJgeL3oNhK7jUiqxHyduIA+obiad9sU/rUsmVVZESbQWE?=
 =?iso-8859-1?Q?kaIpYkOA19pzSRGKnbE8ROIDrzAy2s7QcOiFwkQpCkg0Yb5Ede0PRHc0sp?=
 =?iso-8859-1?Q?utYFFEOeoHHjk8FM/iGUZ44v9Ec3ZIxwR2PD2EN/wk/f8wIAlbcaBHX2MQ?=
 =?iso-8859-1?Q?ZJisw92JX43OX/X++VXmx1ghvH+TaR1wPjM8ZcA6tp5ew0mW7QDbaUsMOI?=
 =?iso-8859-1?Q?4JRJ0X5FIf1ZtyAfMQ0vj2REBnnBT/5DoUtu/vQkRBjuShW1SKGXGt0rNI?=
 =?iso-8859-1?Q?Tdb+jn9yO4lR+DKEEGnZpKjt++bTYGskflAd4pIDq+XHkFg7UO7nueIBO3?=
 =?iso-8859-1?Q?x7ITSgfYEvcwxZAf1LmpFi8V1Irz4XhdPSXyMZvrYspeJvtrtCGdmeLhal?=
 =?iso-8859-1?Q?ZmwEE0TQHbGKTJhT7WbQ6nsE3NSbhC83FdGf783bVAfq4dt3G1aB4MjUPb?=
 =?iso-8859-1?Q?yWRXyYx1mD7dGTbGhq064aNYHDvityto4jkHWVo6C7GUjjERwdlKaRNVgF?=
 =?iso-8859-1?Q?+b7wlESVNVgp5Pd6wOMqg2w/ERlxvOuMNV7WK10biDAXbC9FXbKUVHGeRH?=
 =?iso-8859-1?Q?vD5ZUuzfwbcX4j4XKwMAnVAKqlCFC9aYs6J5XuWUknbxuCRq4R8f3dNCjf?=
 =?iso-8859-1?Q?nWlaQsictrxSDKt8m95n5XpB3BB1fnpJ/x3ch1w9TSy0KEtSKpsFto9+dy?=
 =?iso-8859-1?Q?1sh04D3iAtkAcnkLC8Gxy518c2M78aIif3HK3xXftu7qQiL4extDOdYxXh?=
 =?iso-8859-1?Q?Y4Jmv0yVpeeSXcKIu8HHwbmuk0ZFso5VhNn5b6uUgHNyTuPrw0ndQnhJ/I?=
 =?iso-8859-1?Q?xK8LOEtkEmCwWqMuy/+XClKUP+ECeu67Y1rn8WlRjc/K5Qull71stj5hh/?=
 =?iso-8859-1?Q?/SSrote3f1vBj6CxqVts+rWaNxy9wpEdUGAWrj7RCPFhw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR01MB2682;6:MLD8jr1RBLSwlfKzNI11mHKwiDs8ajBOeBhamyxW3OHs8EcgVYlkwQCNEnaOBUdq6P93y71zh3to+J7PPGM4VuP8Bnfm+xj2WrV+4DT7oABj+895tP7s0ZUm+rq3UpRUWfVijcosgGlGXk6FIq4r3HnwuNIYgaGjR5DGiV1O+ivOpqF7kRqXNhBW1PKAKRC6gSw014QotvZ+FdFdc4rCuVcAum3+sAY4dlvQybu6RoquEKdtYwq8FeDOhkOyCjcmWwdXvpXZ1i54T4npqnvM4CygHfQUsoulMeAnH0awbM3pagvRPAKYPxCeHfOKIZx1xRVZHl/ctxvvFc3z7ghIg8/8LS1LBbDbUQ0sESvzf5g=;5:9DRIvWfYbz3cqzkzIwiGNFIVvu0KyxOke/sGnfOXltthABYbht9GdfDkmaAHA0jG2J3mPkttXMAtUXz5D8efjsgItC0+N/0f8E2kBtNc++yJ+yDmEU7aMejBmXkkgv6bZVgGM3qQrAHMb5lIuMFlxcuMGFM9kUNtZF3/lhu7p98=;24:3U06t53/P7hlaWOs3NUPpAkMBwk6hIiL/pct4jJsr8ZLKcm4ed1mFnKlyRTJiu9wBe3os+urB2Oe4h0tkTRLfCJY/4cnm5G1ceVsh7YLTvo=;7:5+IHBJbwqEROgZrlo4wJ16gesHzak8J78cjGFtqD9tGDRnwG0l8CdZS55kOsN5xKZVC5I2rVqNWgx/1KMsAIUj8AjxDI+lB05IAz/nXDvDB/LUvR+dja9ApD+ZADkHTKnypSm+m137VCitPD3PH1OoZFTs55iaynRXrQfxPGdcqNe7Wd4o8L3pgM8XRJhY+EBbHCNht7cNgY6Q5ei6xmoWy2vCKLWhmU7XPx3gzEtsczPVxXTKuDSjTaMeyO2U7M
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arris.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2017 08:43:03.1361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03af50c3-ee45-422e-5eab-08d546bc8490
X-MS-Exchange-CrossTenant-Id: f27929ad-e554-4d55-837a-c561519c3091
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f27929ad-e554-4d55-837a-c561519c3091;Ip=[216.234.144.41];Helo=[webmail.arris.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR01MB2682
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First: Thanks everyone for your answers.=0A=
=0A=
I understand that there is a fetch pack, problem is that I can't force ever=
y git server provider to turn it on... Tested with github and they don't se=
em to have it on by default.=0A=
=0A=
I understand that you don't want to allow people fetching single commits al=
l the time, but is there a reason that you don't allow SHA instead of refer=
ences when you fetch an entire tree?=0A=
=0A=
Is there a workaround? Can I somehow ask a remote on a valid reference that=
 includes a SHA? So I can later fetch that reference. In my case I would li=
ke to avoid to fetch more then necessary as it pollutes the main repository=
.=0A=
=0A=
-- Magnus=0A=
=0A=
MAGNUS CARLSSON=0A=
Staff Software Engineer=0A=
ARRIS=0A=
=0A=
o: +46 13 36 75 92=0A=
e: magnus.carlsson@arris.com=0A=
w: www.arris.com=0A=
=0A=
ARRIS:  Legal entity: Arris Sweden AB - Registered Office: Teknikringen 2, =
583 30 Linkoping, Sweden - Reg No:556518-5831 - VAT No:SE 556518-583=0A=
=0A=
This electronic transmission (and any attached document) is for the sole us=
e of the individual or entity to whom it is addressed.  It is confidential =
and may be attorney-client privileged.  In any event the Sender reserves, t=
o the fullest extent, any "legal advice privilege".  Any further distributi=
on or copying of this message is strictly prohibited.  If you received this=
 message in error, please notify the Sender immediately and destroy the att=
ached message (and all attached documents).=0A=
=0A=
________________________________________=0A=
From: Junio C Hamano <gitster@pobox.com>=0A=
Sent: Monday, December 18, 2017 19:44=0A=
To: Carlsson, Magnus=0A=
Cc: git@vger.kernel.org=0A=
Subject: Re: Fetching commit instead of ref=0A=
=0A=
"Carlsson, Magnus" <Magnus.Carlsson@arris.com> writes:=0A=
=0A=
> ----> So far so good, but then an error message appear:=0A=
> error: Server does not allow request for unadvertised object 50f730db793e=
0733b159326c5a3e78fd48cedfec=0A=
> ----> And nothing seems to be fetched.=0A=
=0A=
Yes, that is what the error message is telling you.=0A=
=0A=
You'd need to coordinate with the server operator so that the server=0A=
allows such an request; uploadpack.allowAnySHA1InWant may help.=0A=
