Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 202581F424
	for <e@80x24.org>; Mon, 18 Dec 2017 12:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759195AbdLRMhc (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 07:37:32 -0500
Received: from mail-by2nam01on0093.outbound.protection.outlook.com ([104.47.34.93]:45696
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759118AbdLRMaa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 07:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arris.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=R9EJAnk00V5Gdf+2HSutVDfgYK13uyK0IPd/5R07eo0=;
 b=hLyKhQXrav7tVqyMRMmcvJeXVT4Ibny7ZVwP7cPCPdd3vt8V9+TQNhbs3UOHQiE/7YhrcDeulhnRcasp18QCIcoPIcNCx7fIobWZ3cv2LKTzo1LPzBIgprbl8BKMQ4yHsWdkIDXLLBmWMPsYe/Ex61CZVPF4oR0xVr35cdgoSgA=
Received: from MWHPR01CA0039.prod.exchangelabs.com (10.172.172.153) by
 DM5PR01MB2683.prod.exchangelabs.com (10.172.185.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.323.15; Mon, 18 Dec 2017 12:30:28 +0000
Received: from BN3NAM01FT052.eop-nam01.prod.protection.outlook.com
 (2a01:111:f400:7e41::209) by MWHPR01CA0039.outlook.office365.com
 (2603:10b6:300:101::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.323.15 via Frontend
 Transport; Mon, 18 Dec 2017 12:30:28 +0000
Authentication-Results: spf=pass (sender IP is 216.234.144.41)
 smtp.mailfrom=arris.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=arris.com;
Received-SPF: Pass (protection.outlook.com: domain of arris.com designates
 216.234.144.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.234.144.41; helo=webmail.arris.com;
Received: from webmail.arris.com (216.234.144.41) by
 BN3NAM01FT052.mail.protection.outlook.com (10.152.67.165) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.20.302.6 via Frontend Transport; Mon, 18 Dec 2017 12:30:28 +0000
Received: from ATLEXCH2.ARRS.ARRISI.COM (10.2.195.16) by
 ATLOWA1.ARRS.ARRISI.com (10.2.131.252) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 18 Dec 2017 07:30:24 -0500
Received: from ATLEXCH5.ARRS.ARRISI.com (10.2.131.23) by
 ATLEXCH2.ARRS.ARRISI.com (10.2.195.16) with Microsoft SMTP Server (TLS) id
 15.0.1178.4; Mon, 18 Dec 2017 07:30:23 -0500
Received: from ATLEXCH5.ARRS.ARRISI.com ([fe80::304f:2ad9:b296:d722]) by
 ATLEXCH5.ARRS.ARRISI.com ([fe80::304f:2ad9:b296:d722%24]) with mapi id
 15.00.1178.000; Mon, 18 Dec 2017 07:30:23 -0500
From:   "Carlsson, Magnus" <Magnus.Carlsson@arris.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Fetching commit instead of ref
Thread-Topic: Fetching commit instead of ref
Thread-Index: AQHTd/n5P2PiK0t7E0q8cmWqHBiCcg==
Date:   Mon, 18 Dec 2017 12:30:23 +0000
Message-ID: <1513600223353.28799@arris.com>
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
X-Forefront-Antispam-Report: CIP:216.234.144.41;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(2980300002)(438002)(505004003)(189003)(199004)(374574003)(57704003)(478600001)(2900100001)(97736004)(15974865002)(106002)(305945005)(966005)(7736002)(5660300001)(6306002)(5640700003)(6916009)(72206003)(316002)(50466002)(59450400001)(5890100001)(5250100002)(47776003)(117636001)(97876018)(14454004)(68736007)(1730700003)(106466001)(36756003)(8746002)(102836003)(53936002)(8936002)(69596002)(356003)(86362001)(23756003)(3846002)(551944002)(81156014)(2501003)(8676002)(2906002)(6116002)(81166006)(2351001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR01MB2683;H:webmail.arris.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN3NAM01FT052;1:eyqLFuMryqiqF46uySLkjihyxN9s3q0u6CIrIVMWunkAVHpkKQmAF1JUurruntHaY/+YZkudD3b4Gu2UVBIhzinZcg6pnUYQHlwjKv/bPIxP7Wos+KrGneXwwLb/nLfX
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98712e83-245f-4365-7c1c-08d546131f2e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4608076)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603307);SRVR:DM5PR01MB2683;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR01MB2683;3:rp2p0OxCuLjE2m5Az68qavuOBR4Aw3Io19BxbusaoIi6jv57GqYAabGI5OWcZ8yHbZzE4UgJ6xNEBCqnKqzz9rWoARebY4iuTPnxhaQO21ofh7+PU0FZ/N726WrDP+eQtnv1ELCKJtZYrGXbvXM62p2nE9D3pCYw/Pq4ilF8M89j4xfZ4qGfB+5R/0RSSiwzFIjikcZA/5EJjzKdpNcFZIfBa+B5oHgZvnMEHQCXP34XuL2ORUipnLHJU+c7gFinNATk73pD3CosBubIlUgYV9TgEN7Pf1evLWFtWpmM17cByH0H06Tmnxvnw5e8Y3Y9E5dwEgCeSovWYsbyJR2kdkAQTlqoVu0Lr35+oB8IVUg=;25:N7nwOIkbH8yMck3oK0ifkxdIpLf+f2Kin9YeLpX2GjNliLtvTwc7VoV5jw/7GPfOrd7iL2LHKzzdjnCbrpiv5ad8Z+VbYwqqPf1MeS6jHUNBPsNC/eW1AiTgCD9SwTN6YfVH8UNzbyBmlyyfW1WE0Ujp1VEpaJuUfV4RsmVix2o1WFJqO/fMJnJqTSYFbwMjMes6jxATDFyqKLJ9/1NyqC7+1Q4XKYrXuxph4b8YvAnZbpLjx86+G7dAIkkcClvwLFqrciw6ITr/pDzq/SLBoeK9BVa2JPtCdHT6ZPQuREFEQg1Zh9CAZhrLVVstZDJpaWhKmcTEvraGRzxEKSVN3N98N1UfUgsUU8CDCF80l9Q=
X-MS-TrafficTypeDiagnostic: DM5PR01MB2683:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR01MB2683;31:UYQnt0iM4avVXT5K0DaigD5/HwfsQjtxiPDIKdOrn7evgJUQdcjLOt8XI8Zc9fGljxuaQewZK6c2Z20EPDGqyRnFoANKs067KLU2wIDUDuypt1CCzK0imzKvvFnmhD6RNjn7muFKnNuRBWGKhfqHAEjzXFf4WFFYbbaIxIAg4fOg4dI12r2hE9xrlhBjeGWZk+JDdXwRH1V1X0DniHrnKkIev1XuRgAcoUQRR9hrwQA=;20:I2UQNMGTCGyUejSzUw9mp6JtBd2J4HYJTVveBHpb0ylcJkGv0zoPVE2PIuVqwShOwROOuh7E36O0IEQ+ESa+9tf5k14F+gGhvSPlq9KopX3zTVDP4/eGBybi25A/PSc0XgHvuGhPzscOQun4kcMBDVQYSLD4lgbWEDAilEqBNQS3x2m4Rxx66ROQN9N77MGXG07VOdsHE4gBISxN2G7bTjSiVNl7d/O8e4Q1p5YDI7apdB0EKBqF42dujgCMvBBNI0vHS85up6AsBTR+AqDSszXhwSzIw8XTwvkWzrTGTuxtk5//H76IE4tcfna56OL8ub6+fssKS4OpY/vQolwzqcGkwBm/cSiv8xWOL/IKc6LkDQf7LAl8b2OaVwwNM+HKOa7/wIuHkGWpdiFyD8LirewDMrF8RHINU+29mJmCamkf/xjBnkfUc2dYbHUuL12HV+wSTc2vmSMS2Ma0DHmsNu6t04AosFY/fZ84xsNRdv5RtgCEYVpKhnLqvH9y61kQ
X-Microsoft-Antispam-PRVS: <DM5PR01MB2683D57DABB1126EDC055B75FE0E0@DM5PR01MB2683.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863)(104657075078662)(166708455590820)(185212123834332);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3231023)(3002001)(6055026)(6041248)(20161123560025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123564025)(20161123562025)(6072148)(201708071742011);SRVR:DM5PR01MB2683;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:DM5PR01MB2683;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR01MB2683;4:+0aAXdRmOu7pS3k7vLh9tl9f8fz40XQbINO6PYeZNNI77lOtkWZ4PVR/mXy+OBvwKuYgvCtUDAqWtJAkyl699kXpG2RuUOw6OCQf66JG4Iq4ZOR2mI34hT+dK80rb4cskGn7BgxJ6AnWwprVDAiIYHVWe0t1TxYj2s1IH7Gs4vl1KLYYLVh7Vn93SX+dADXVAuBwx/SrIOxGI0kqtjm1K6ZcIpyXc0g9dXLp09yfXESRdWQtaPzHmAmAz/HU2KdfJsHEKZHLzKDxkhd7d2BcBAjPlRVtpwUtoxrYzksiMjiLmD4pbCVIb4Gu2Vbewjx84MO9A4AnLRrYVIWQqHs2ZxI3OV1z49/6+/W35/OjSWr1EDU8RHpu9SxOq8yVl8x3JxasQDETw90E9Xt6vggrPuGvZVdiaPZNcNJR26P/U48=
X-Forefront-PRVS: 0525BB0ADF
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;DM5PR01MB2683;23:Ijv+LaQ+px5EJocC1jwZlbasIgSIKR7GzoelFpo?=
 =?iso-8859-1?Q?1geQNqlmcvNck8Mscle9fq/htT1NfRAOIDKD5mYb98ojBHABJhzbxvAMYH?=
 =?iso-8859-1?Q?pWb/JkCVuckf4quEY1SwalYrblfgDqgk/Uymlz0ihQzYyYWrvWky27xDez?=
 =?iso-8859-1?Q?DHtu1OrTXjHaGdDoLhdud1q7qhIEtfGWwm6eg4cce1sNLdiLK4JDvythMS?=
 =?iso-8859-1?Q?F9f1Go7yYalw5VbMcdPA72eVL1+eUrLhWeV1TlschAh8IwLWtCCne02Ypo?=
 =?iso-8859-1?Q?ajViXAfrFpdiYOYUIxUhPu5QCTUTBubgR655GHN9rCeGNtWWE3pLZxFfzB?=
 =?iso-8859-1?Q?gjRDqtEJLwKtUww1zd6f9C5bQBBvzh+Sy29BnPwAe2I+S08Xd1Z3Iv5aGT?=
 =?iso-8859-1?Q?9zYb1J7fsSbnEZLnGajrjCfL9qrr4Ar9m5/JVZjstE1HAEWfe6LypV96fe?=
 =?iso-8859-1?Q?CXz67PrKZMNku5FBQwkv6DbfQ/5wJWW09joSHgVlKnehsmb1vNRIj84yJl?=
 =?iso-8859-1?Q?Ug/nDKSxGeaEzIxQdmPKb36FWkJV60gebAOI2y196+s2i31YAuTdCXc1IG?=
 =?iso-8859-1?Q?CDbe3gY1h1NJVxVJtv5yhGs8nCN3Iby+u04xNmx2kQFXEpYKonyp38G9w2?=
 =?iso-8859-1?Q?KOxDxQilazp7r8GRYsCGGJOwWIUtVJaUEc8EEArM4XwxI9KIlfLWzwjYsK?=
 =?iso-8859-1?Q?8zgXHeqn++/2u7bCtMZCWVch5S9z+rT5EYpeq5q2BPqAzZGVOSJ9dolvRR?=
 =?iso-8859-1?Q?69O0/HzsQkRDW0K3lo+F2Bpbb3Eu0T+600X0J9DEPj4h8e0CNs4a8av04h?=
 =?iso-8859-1?Q?Tf0Luk73vOdOZ4G/mGMRh0d6iyUXmESkKfplgP2zBCpicvTYF4ftidM2AU?=
 =?iso-8859-1?Q?4RMtY4LYZ7u7pMktcbG1FYUK7Ijuqdem/FDBYixoKbJFaPIMbfYI6f8GHd?=
 =?iso-8859-1?Q?7yvFtKtgt6yqrxoLy4hGG8M54WMWpLaAlcWZFolJD8150mJzOWteJ2bF2+?=
 =?iso-8859-1?Q?IIfSuA820fRVwp9i2tjjumPWgBo+lQqZkl4NZyqR7PD7w644mRyt7Dzx6N?=
 =?iso-8859-1?Q?clTJsQLhkSdxj+hxd6jp3KkiV9WoDvI9ER4uU+yPtuXPZOkkd8jNz89+kK?=
 =?iso-8859-1?Q?1IllKGa+8tSUOwq0uxrwy5GIUqm95PWBkdzghtMaFx+Eof88mAsWdewjfa?=
 =?iso-8859-1?Q?vjY/oI6vzXa1VwjKjuDQNgwGVUeEL1TsL+DVlEbU+ZpACOzHwIyR+nNTnS?=
 =?iso-8859-1?Q?Y3ch9ipy5Hb1DLiM9cBPvNX3x3U+wCqKjofH4FAgsYdDjrZ8WBeyxWkK1F?=
 =?iso-8859-1?Q?pW4rY1fMhV2RpI+yCmvkPu/?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR01MB2683;6:uqXxx9dPtRRyvHRPJQX8lwb93taRhjgQuuJnvnJSjZ3lmUiHza9Pk1rO+cubOaWolRAYY+1mXgTB2n5RQMk02MYasrKtHogo242kPNJzRGiM+TwRADcRwVncJcrI1V5aL9rOCLHPbjsj3U/jUvhQ8WY1JWHuay6Vc16p8Sc2UDYfc4d2EajXT0VP/7CADNQyuQIM5hMJh8vTrK72B5iOtv1BjxoStqqtWkAd3zeMJ04JEPMOr0oYBpjag9AQu1/o4UhI1GbZDr3MF0CjYYvwaOfzxqZOMNqlZ/kmActTqUjFOSDFgWd4egQSTyQq1kP7cGRMpF7jgsI+AwftZm/pycwKkK252ElT75XnhP4AtEY=;5:JtmAXek9O+qabiLX0oycMdaKfqZI8I3dDOx+KvX0XpbOjeVq0rTAKxP+7/CGGDnvHcHrnedUrk0sRcyhHa3bL96VMipIdojaMR2Lnrf6WORV9+N/RZ9RfgYUmWT7H4EDbWCCiz13PEoGCLn0/z/HPrkxkvXcdNyOe0Gwbuw9BZo=;24:mUTVYHZq9zYxQz94OeYOs02o8A0zAa5mr5xnda/Prrty7kuZtbmzunN++0UfP19o8wozGKMNJpfdbQhEqdz2BUfK/mYud/JPtLoCFEF///0=;7:hFeP+9265l95cQeL1s7lFX2D0pWtvBP5r50h09B963GSsGcihfcXI10vccgUDuWvzn8Pol1rWIb6a0i3xYt9ATBpxTsQfxOklYhbWkVSfa0PKwFzL45okb7MAKbno4d7zRRNd9OMQGev0WDKroJ33Db/4j6ojUYetbJC7fSXjuByyGnyXHR7mkOFXmv9ioTcC+xLxt76v1GinXn8983+Ln0JzAz2JY36PU4z6UFh5PP1SsA6vMoPEDIhkHNIODv8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arris.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2017 12:30:28.1599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98712e83-245f-4365-7c1c-08d546131f2e
X-MS-Exchange-CrossTenant-Id: f27929ad-e554-4d55-837a-c561519c3091
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f27929ad-e554-4d55-837a-c561519c3091;Ip=[216.234.144.41];Helo=[webmail.arris.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR01MB2683
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi=0A=
=0A=
I am involved in the git-subrepo project (https://github.com/ingydotnet/git=
-subrepo/). It's an attempt to simplify the inclusion of repos into other r=
epos.=0A=
=0A=
In a certain situation I would really need to fetch all commits related to =
a specific commit (SHA). I have read the git fetch documentation and found =
nothing regarding this. It only seems to support fetching references.=0A=
=0A=
I found some traces on stack overflow:=0A=
https://stackoverflow.com/questions/14872486/retrieve-specific-commit-from-=
a-remote-git-repository=0A=
=0A=
Following that recommendation it feels like it almost works:=0A=
$ git fetch subrepo 50f730db793e0733b159326c5a3e78fd48cedfec:refs/remote/su=
brepo/foo-commit=0A=
remote: Counting objects: 2311, done.=0A=
remote: Total 2311 (delta 0), reused 0 (delta 0), pack-reused 2311=0A=
Receiving objects: 100% (2311/2311), 703.64 KiB | 0 bytes/s, done.=0A=
Resolving deltas: 100% (1174/1174), done.=0A=
----> So far so good, but then an error message appear:=0A=
error: Server does not allow request for unadvertised object 50f730db793e07=
33b159326c5a3e78fd48cedfec=0A=
----> And nothing seems to be fetched.=0A=
=0A=
Is there a way to fetch a commit and any ancestors to that commit based on =
a SHA?=0A=
=0A=
Why do I need this?=0A=
In git-subrepo we try to recreate another repo within our main repo. Creati=
ng the necessary parent references when they appear. In some cases we need =
to make sure that we have access to the correct commits from the subrepo, b=
ut we don't have any references except a SHA.=0A=
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
 ARRIS:=A0 Legal entity: Arris Sweden AB - Registered Office: Teknikringen =
2, 583 30 Linkoping, Sweden - Reg No:556518-5831 - VAT No:SE 556518-583=0A=
 =0A=
 This electronic transmission (and any attached document) is for the sole u=
se of the individual or entity to whom it is addressed.=A0 It is confidenti=
al and may be attorney-client privileged.=A0 In any event the Sender reserv=
es, to the fullest extent, any "legal  advice privilege".=A0 Any further di=
stribution or copying of this message is strictly prohibited.=A0 If you rec=
eived this message in error, please notify the Sender immediately and destr=
oy the attached message (and all attached documents).=0A=
      =
