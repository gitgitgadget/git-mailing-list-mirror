Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 143A4208CD
	for <e@80x24.org>; Thu, 17 Aug 2017 11:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751843AbdHQL3z (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 07:29:55 -0400
Received: from mail-bl2nam02on0120.outbound.protection.outlook.com ([104.47.38.120]:26579
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751641AbdHQL3y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 07:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arris.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=2Kg8Tsp2cTZKKqn8FZR2/1VO2rrdRkU5oZz6g+zJWww=;
 b=luKK8MdQpJIf5/qFAG6TYusIIQ8zz2GD8e6mDirYiPgOJJog+CRWODoK0nhE7Bx3TGFFsj2Vm99E4/P+sEvU5k6R9fIi0AjIVHZcRNivxAZWEy9avthd+b+b07zpFTNpSHSTQKccXyBrz1KdRjTaavAxmZzMz6hr+aV3ZqWDlCU=
Received: from BN6PR0101CA0023.prod.exchangelabs.com (2603:10b6:405:2a::36) by
 BL2PR01MB545.prod.exchangelabs.com (2a01:111:e400:c2e::18) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1362.18; Thu, 17
 Aug 2017 11:29:52 +0000
Received: from BN3NAM01FT025.eop-nam01.prod.protection.outlook.com
 (2a01:111:f400:7e41::200) by BN6PR0101CA0023.outlook.office365.com
 (2603:10b6:405:2a::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1362.18 via
 Frontend Transport; Thu, 17 Aug 2017 11:29:52 +0000
Authentication-Results: spf=pass (sender IP is 216.234.144.41)
 smtp.mailfrom=arris.com; peff.net; dkim=none (message not signed)
 header.d=none;peff.net; dmarc=bestguesspass action=none
 header.from=arris.com;
Received-SPF: Pass (protection.outlook.com: domain of arris.com designates
 216.234.144.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.234.144.41; helo=webmail.arris.com;
Received: from webmail.arris.com (216.234.144.41) by
 BN3NAM01FT025.mail.protection.outlook.com (10.152.67.179) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.1304.16 via Frontend Transport; Thu, 17 Aug 2017 11:29:51 +0000
Received: from ATLEXCH4.ARRS.ARRISI.COM (10.2.195.18) by
 ATLOWA1.ARRS.ARRISI.com (10.2.131.252) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 17 Aug 2017 07:29:49 -0400
Received: from ATLEXCH1.ARRS.ARRISI.COM (10.2.195.15) by
 ATLEXCH4.ARRS.ARRISI.com (10.2.195.18) with Microsoft SMTP Server (TLS) id
 15.0.1178.4; Thu, 17 Aug 2017 07:29:48 -0400
Received: from ATLEXCH1.ARRS.ARRISI.COM ([10.2.139.158]) by
 ATLEXCH1.ARRS.ARRISI.com ([10.2.139.158]) with mapi id 15.00.1178.000; Thu,
 17 Aug 2017 07:29:48 -0400
From:   "Carlsson, Magnus" <Magnus.Carlsson@arris.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git fetch with refspec does not include tags?
Thread-Topic: git fetch with refspec does not include tags?
Thread-Index: AQHTFzWFIxXrmJiyxE6IHqi+SjfzH6KIQHfKgABKqAD//9wtqA==
Date:   Thu, 17 Aug 2017 11:29:48 +0000
Message-ID: <1502969387926.66865@arris.com>
References: <1502960406180.9006@arris.com>
 <1502960572292.1402@arris.com>,<20170817092853.hteuzni5lxia4ejf@sigill.intra.peff.net>
In-Reply-To: <20170817092853.hteuzni5lxia4ejf@sigill.intra.peff.net>
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
X-Forefront-Antispam-Report: CIP:216.234.144.41;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(2980300002)(438002)(199003)(24454002)(505004003)(189002)(374574003)(51444003)(246002)(14454004)(8676002)(23756003)(2900100001)(97876018)(305945005)(356003)(86362001)(53546010)(7736002)(54356999)(76176999)(50986999)(117636001)(106466001)(36756003)(626005)(4326008)(478600001)(551944002)(72206003)(2906002)(189998001)(102836003)(5660300001)(3846002)(6116002)(15974865002)(47776003)(110136004)(6246003)(2950100002)(6916009)(5890100001)(77096006)(229853002)(8746002)(8936002)(50466002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR01MB545;H:webmail.arris.com;FPR:;SPF:Pass;PTR:vpn.arrisi.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN3NAM01FT025;1:hdgOSIXE/Wr+ha0KrH3HneCCzOi8L2CRCdO0aELVNqNTNiJAlReuFApCYtfWKDnmFOyTeNPGFvOIgwQxoo+4GuRTkUeyW+0fG5a8+5QHZgE84xLBsDQVWLP6B9anF2T4LwNWIrry9zurjW0pYaY+VqAC0XH+mL4b/ZHUw/7WY5G8AccdP4PA1CjaFb68xY8aArcS91RF9/Ro0Ah58RJqjRTb1tw+5zEfFNMPERi0kNE/iL/IZpAlKbnYRuQR7V/PiQsWdTPz/GKM5ZELpRF59wCKi4nKwp1A63L/9oih0oZFEM/SlTRo0wcn4GNch/tz251c8ebYDJTX/WOJukOtyyDce0M4kcXrmq85mjGJ6Y952lixaAt80898o9fa6baiCkfqRSn1QAxOn0SaQpQIvyREHi/QAr8f0cBi4xIsjV/cJNYzm+rXIIBPyn9l7sPMPxxclYQ0xMTvfg8F30fu31inOoiwW5Z9rNysCwkEIrmpvqARU/gmPyTn4tSof0xEqgVOogUBR0LY3DMePX7Xb327UdvGUgrKXv9ll29E4VAZn+9UqlJpBmb03JO1QjR6SiRZfJ/tOltWE/P3MDEhCp1oxOxJAWCqtLwsrFIsKDWNUxVbEzUUUdPZ4+lDsWIxb2FyMReGIPk1Dgdh3sEIfC6LcLBbhUrNUTuiNsgQGjWQzVpYDM4zWoBkmHemtHIQ/bk8YA02PHfDgxNpWR0ZJ01U8zo5NaZ9UMsmUscgrlz5mdr6HyuoQ5d7hl+V03sDM9lxAujY2Ejwg/QS6+pThFNBB7VA5ShauLwrMJ7KOJUgmXhRreEjYt9hT7I1yFxI1QxLEdZxvdfFzt09yEklgw==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db1821b0-4476-4251-5caa-08d4e56346dc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(8251501002)(300000503095)(300135400095)(2017052603031)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BL2PR01MB545;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR01MB545;3:k0jxk2DXbLCiCaSQzrOhJNUU24XF615YvdG9JIqGH2G7t0WjwCUBw5keDRw0Fnayrw8A7/MsxJvMbIv9q43TNxkt9i5QW5o4Dwtx/4S7NIZm4NgrPunZrTc361aH1F+31hq42OR8mb+USyOu1WrgKvepv0OWZv+DcV9Q+vLRIxTEwxhxzYilbvDCP8RR3saKFhFeSmZQk4KNLwVRj7rOHtz/XLLt3d3Ef8lQRViK9KDfuPtHr/hhwUDUseyHfrDPCw/KSaopsMFTEEk+z/R6IRI3jQ//d1yFz5Tq+RZoNs63u9qLGEQYdvsOz4XrVJ8ZWCVPjlu87h8mbuc8/koBPdxj7q6uCujqHzKWG5DgqAk=;25:zcD0gkk9Vj5NfsnLar708NXr07G0Xo4qgMOT/IlwjvfnQ5z9nr0qgNsiJ0cYCk2TuZsJmR+PaIK+WWsMZ86XJ641jM2oSyijR3K4jwDXMQrZFHXHBsEkJVXhWJP9q+NSElJCPJANOMckqhOtcvbjvG6Yg5uRMhrfQzXUHdcX44NXzdo4APFrLfTppGeu2ew64tWaiH+FR5XlD8ml8S/hmqkl51YWu9tLSHDZFsi3OrmT1AKH0+qXerBOGXXjuxWVHY2ufH5Ewd9DQHi5lLzcFQVPHimfimBaz5cGkDl7SlTtLuDo9xLKoeeRRTqAysBrXByRrpWJujc0QOZi7El/a4NXQbVbMds5Co0FItcOMjc=
X-MS-TrafficTypeDiagnostic: BL2PR01MB545:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR01MB545;31:TXflq8MJdEXskyc513Qhz5rDh61dUktjpzc09L+KWnyFkCkp+1GnhX9r+8DjvzRO7IqERe2lmjWa7nA5gHC9TUqafcfY5ZmTwxdvx+z94hLUCVsR+AdNYiCDwQst0f+WCyEZ2zd+BxJkDJ9IR5GxiFDMQNP786a/Wqcv1zg4keDD9NXi3Z9QJtegA1XNGv6u0mE5JEq7K6Y04ObEzAC8IQjnbV8O4z9zfa00rCF5jBs=;20:vojUm/fe05z5XZspTnFBRiUo/vM9VgaVPv0xwT8zO4b1xwckMZnHzFvAXVjtC26IP5J+wn3p+YqVXgnPndv4pP1GZqx6g80D2CGC0x0dXbTrJ5dUrUsqpQ4YTj3tmecGzuPEfZhNJxkRH1nmGLUlPznjw0Jgjwg/NQJ0i/spVuh1NeblleuAt09dNPAUU+z920lfGV4L8Gv9uL7n4Gmv8Ler6UxAHPrFNFMtGblhEQk1Jz08rIThInmLr++XFK77vx5kVEmplZ3rqugZX6v0kyHs02Er1c/wY/DwmodS+Bqq2WVA3ffOl2s+XYxYU5av2RTpYW7SD1V/LY/hNyZ8rAE5Q5a2ZKTTMLcRDP+b1sq3vn5kXFe3u/Rs6pNufSqyVLNSg4fF7k5tl/6arkw/lLh3tS2g5PbZJDU4oQswNx1CIJEP1JJWiW4UUDjl7EgtIhCGV3rDEQLRkpNAbr/9VAK8O890B+fh5CZebOSGFMeprEXc9MdP+5ywhxzgFbTz
X-Exchange-Antispam-Report-Test: UriScan:(104657075078662)(9452136761055);
X-Microsoft-Antispam-PRVS: <BL2PR01MB545DDACC3726B8F3989341AFE830@BL2PR01MB545.prod.exchangelabs.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(13016025)(5005006)(13018025)(3002001)(100000703101)(100105400095)(10201501046)(93006095)(93004095)(6055026)(6041248)(20161123564025)(20161123558100)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BL2PR01MB545;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BL2PR01MB545;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR01MB545;4:mk0otvz54mDxCw3DngyUhjiXB/pGBdYycYiNif2rRYh8kBDk1pEJyR6tT8DFTQXCGNGBtSPbyaZyEfQlmJhs/YnuCLQ0PwfonhvXjZUw98fl53l5EkpoWZihJPuMQTnPZJ6EQWCgscBO9jrnMC5RDvaZu4UNapKEGkYbvLmdlX7KPlgEjU5PuNhI/zWCK76rCcoZGn/hPxwY8NkclwyutLTK0+31K2+ijo3OS+gHZN4lkuUI9XkPaTg7H/uLMzwFsCaP+eKDEyvSn55DezCKuuGDgaDgamWt0e8Gvfal09QzzMRFKvuTEARM++B1JfS+tOCD2F5iefLwDkZGM+Gdtg==
X-Forefront-PRVS: 0402872DA1
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BL2PR01MB545;23:sFlHYVOLrUaw7bgGIj8BKzONVY5MxVIpk98Kd8dy?=
 =?iso-8859-1?Q?zVkeX+WjalJ/aZvxrFSNBnVHQJGtlOIrYHWjPr4fd+3qk28lankMjY4MES?=
 =?iso-8859-1?Q?C3KrmlICot7CoEkWmqdSMYvfhlwShQzKKwDSTi75ejuGGhtQaJ7FUJUSIh?=
 =?iso-8859-1?Q?hS6pynIS+iqJajCrcq+Eizbk27UfrZ++3ByZAPnDaUx5n/sr7sxJJ8dlTu?=
 =?iso-8859-1?Q?ae+aKdUMQuuo2/PxVQ9pKV0YQ4xEEiH4UI19GWWVKOYue+5yeRYhRgJd1v?=
 =?iso-8859-1?Q?84OAg37tmgOqdRtmD4tVwB6Su61oURUkYQZ+2h+EQznP2UxXjHzHGTB3/d?=
 =?iso-8859-1?Q?j5qoblg/H0+Xe74/QV5ZFhHodzX/gSBoL5iMCjAOpF/K850oyVcf+8HTY4?=
 =?iso-8859-1?Q?T+jsUiNoWpj2VyAUuRe3UT10Bmh4z2xCTCxBkAj2tA/teX54PSJ0NB/P56?=
 =?iso-8859-1?Q?zBluR6x48xXyb7cG3qFV3uFsamFRGiggDQt//OtbRMH/zCJAWpmUDWvn4k?=
 =?iso-8859-1?Q?nzGVOytMVC4bhEbb9K9C2y4EYUBzsDPFMZUClEs3eRyGncineMibeUE4wU?=
 =?iso-8859-1?Q?rJB1k/pyRjXkw1Udtc3+o1xZMQer39fyBPk3B7SyTMebyoEr3b9d07Pmk8?=
 =?iso-8859-1?Q?eLl2VoMhzGhNPLQqfnjVkGkq06l4lXVmCBNGfxOnSNtw1qdVWCM6eiUmbj?=
 =?iso-8859-1?Q?GJAlJerBATSonZfMtbTv2or4a0Q38OeVuLUhkIr3xkwdMsNhkQ86jKzfGj?=
 =?iso-8859-1?Q?TJYlv1ytwhEqD3+WTcs4tW2Rdraw9MqrJLZUMGsZnJhvAmEB1AKNmIrIBf?=
 =?iso-8859-1?Q?x27usYIakUkmtPNtviRnWgsr1u4dAv7oKzlsWv4ogu0vatoKyiBFlE+9E7?=
 =?iso-8859-1?Q?0GkvWHnmAhI2N6tr1oQW5mOi5cw4m0uUFitaOLmCfcNu9Xhecjwa+qcHa1?=
 =?iso-8859-1?Q?xfdi/drI1HiUaBdJoVrQ1IbxvG/FyWvKIAtYZJYymoY6Sca/a0U49LmXnB?=
 =?iso-8859-1?Q?o+v/XiAEVF0BgU2kelqLv1iPZY+A/IyA8KY4TRkmKZw8HDZmMZjTnsIH9W?=
 =?iso-8859-1?Q?zcmpTyG63jK+0lwnjzqUXAP09Hai8CVWcZtoSE+K17gzRCGhqPSoMPTPIQ?=
 =?iso-8859-1?Q?SKvfZL6mUHPZuMfB0A181175zINNdpB8P7kwRtTr6i0Ad/yFcvl8c3iXpm?=
 =?iso-8859-1?Q?YLI0VJ7QbSyrFi6wXoWVvjqexwi20qDsgwI0ESDCtQPDNMvBIu2wU=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR01MB545;6:FwJoNGD5Dnbf34+AsqFe3bMHV2VwdqB78Pr7da2ILEblXPm7fuJS0tikaZ825i+lqoSvuN6P7Nn5pPCZpAgEsqK2NYqOBrp2pbepSrfNquY7AiyKdI0UPu7qvM6C/mccJ2DmqZpQOqQ3+HI1O8PkfZnipT3kPsFAAhKfLJxKyr9S+gjP/q0RzBDoI0zKSULeuw6JJcLztqRX+rUlkO8NGE3n0KUvZD+oUR6o/RdflFC8TC4h8ODtMrI8lynnyf3sjCgeEy7gcYGa7vXl92y7eSLzOXgVslte2aSiZwes81oy+dwdreAewNbq85vzmwVFmG+ck2KIG6L53mRPsDRAVw==;5:Chb4gMeOrGAi5YemfX3zUfbRzhjXqZ/gQd/SvNTrAeb8DbLRKtZNmVpW2PgXfbuYcBgjYU5ttkJsoOtvr8UvZ7w2KfknGuAZwJgJcBYiwQND3hhpagqLuHtohvcKjmAd6VAcH4qHx/O+7E+iVunSWQ==;24:Ee6bInV3kQRojTN+jZNL2NjfbWqSmK0qDqbHvdJRZlO3LzDITd337VZYYfX1WVLohsDF06QeJTU12hcWC2jojyZAhag+xUWsiznOVSM9zJg=;7:1/yy/T0eO/rqFN3LNstBpoyh0661ldxai2o3chrYgVtarLGEwfygoFrSTr7speFOfkNX/WwZGWDoPZPF4hjFQ462MblOeychNGWSKCygiH5jd9IBiY5KEdbDeD++6NSHWBi7mibzUmowJJKObLRwFfrVPrkGJDpeAQraMZ8UdHZV3d2HeAwsTHVWxaixitPYPB9yigDod77USScWyIh0kFOgGH+j7gQu6kvdC1Dd8ys=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arris.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2017 11:29:51.6952
 (UTC)
X-MS-Exchange-CrossTenant-Id: f27929ad-e554-4d55-837a-c561519c3091
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f27929ad-e554-4d55-837a-c561519c3091;Ip=[216.234.144.41];Helo=[webmail.arris.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR01MB545
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your quick answer!=0A=
=0A=
>  1. Definitely these defaults are under-documented. I couldn't find=0A=
>    them anywhere in git-fetch(1).=0A=
=0A=
Yes, some sort of explanation would be good, especially since one of the fi=
rst sentences state that you always get relevant tags.=0A=
=0A=
>  2. If we continue to follow the "are we storing any refs" rule for the=
=0A=
>     default, possibly it should expand to "did we store anything,=0A=
>     including opportunistic tracking-ref updates".=0A=
=0A=
Personally I think that I would prefer to always fetch relevant tags. If I =
don't want tags I can simply use the "--no-tags"=0A=
=0A=
-- Magnus=0A=
=0A=
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
From: Jeff King <peff@peff.net>=0A=
Sent: Thursday, August 17, 2017 11:28=0A=
To: Carlsson, Magnus=0A=
Cc: git@vger.kernel.org=0A=
Subject: Re: git fetch with refspec does not include tags?=0A=
=0A=
On Thu, Aug 17, 2017 at 09:02:52AM +0000, Carlsson, Magnus wrote:=0A=
=0A=
> In the git fetch documentation it states that by default you will=0A=
> fetch all tags that point into the history to the branches fetched.=0A=
>=0A=
> "By default, any tag that points into the histories being fetched is=0A=
> also fetched; the effect is to fetch tags that point  at branches that=0A=
> you are interested in. This default behavior can be changed by using=0A=
> the --tags or --no-tags options or by configuring=0A=
> remote.<name>.tagOpt. By using a refspec that fetches tags explicitly,=0A=
> you can fetch tags that do not point into branches  you are interested=0A=
> in as well."=0A=
>=0A=
> But for me I get tags if I do "git fetch" or "git fetch origin" but if=0A=
> I do "git fetch origin master" I don't get tags related to the master=0A=
> branch.=0A=
>=0A=
> I understand that this might be due to me specifying a refspec and=0A=
> then it will only get that exact refspec, but for me it's not that=0A=
> clear from the documentation what I should expect. I read it as when I=0A=
> fetch something all related tags will come along.=0A=
=0A=
I'll admit that our tag-autofollow behavior has often confused me. So=0A=
I'll try to untangle what's happening at least if not the reasoning. :)=0A=
=0A=
I think the problem is not that you have a refspec, but that your=0A=
refspec has no destination. Looking at the fetch code, we seem to turn=0A=
on autotags only when the destination is a "real" ref and not just the=0A=
default FETCH_HEAD. Which sort-of makes sense. If you're doing a one-off=0A=
into FETCH_HEAD, you probably don't want to create tags, even if you=0A=
have the objects they point to.=0A=
=0A=
But this is further complicated by the opportunistic tracking-ref=0A=
updates.  You can see some interesting behavior with a setup like this:=0A=
=0A=
  git init parent=0A=
  git -C parent commit --allow-empty -m one &&=0A=
  git -C parent tag -m foo mytag=0A=
=0A=
  git init child=0A=
  cd child=0A=
  git remote add origin ../parent=0A=
=0A=
and then:=0A=
=0A=
  # no tags, we just populate FETCH_HEAD because of the bare URL=0A=
  git fetch ../parent=0A=
=0A=
  # this does fetch tags, because we're storing the result according to=0A=
  # the configured refspec ("refs/heads/*:refs/remotes/origin/*").=0A=
  git fetch origin=0A=
=0A=
  # this doesn't fetch tags, as the main command is "just" populating=0A=
  # FETCH_HEAD. But then our logic for "hey, we fetched the ref for=0A=
  # refs/remotes/origin/master, so let's update it on the side" kicks=0A=
  # in. And we end up updating FETCH_HEAD _and_ the tracking branch, but=0A=
  # not the tags. Weird.=0A=
  git fetch origin master=0A=
=0A=
  # and this one does fetch tags, because we have a real destination.=0A=
  git fetch origin master:foo=0A=
=0A=
So what I'd say is:=0A=
=0A=
  1. Definitely these defaults are under-documented. I couldn't find=0A=
     them anywhere in git-fetch(1).=0A=
=0A=
  2. If we continue to follow the "are we storing any refs" rule for the=0A=
     default, possibly it should expand to "did we store anything,=0A=
     including opportunistic tracking-ref updates".=0A=
=0A=
-Peff=0A=
