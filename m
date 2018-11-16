Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.3 required=3.0 tests=AWL,BAYES_00,BODY_SINGLE_WORD,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MIME_SUSPECT_NAME,RCVD_IN_DNSWL_HI,T_HTML_ATTACH
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E18341F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 05:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeKPPXW (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 10:23:22 -0500
Received: from mail-eopbgr730071.outbound.protection.outlook.com ([40.107.73.71]:33227
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727124AbeKPPXW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 10:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=saojudas.onmicrosoft.com; s=selector1-saojudas-br;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU66ipI1nni+IPka2b2N+k4iQB5BtpSLja1eOxbwH8E=;
 b=Q5Fsp/HcalPCEpEWyy1Xzi4g+lK+bvF8AVwj0rJdfLsnDELq50X4MEiBrt/g9Th5bwia1g/QBeY/P28YtomX15av+KSldIwk4r8vl4W+DgGaBlmZHHXuGFjwwHfnnqayH+QVi04QWkRiOG+LhblvtMR5ALoWBzL3VbpCH0u5pCA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=fefreitas@saojudas.br; 
Received: from mail.saojudas.br (14.230.135.236) by
 SN2PR19MB0896.namprd19.prod.outlook.com (2603:10b6:804:2b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.33; Fri, 16 Nov 2018 05:12:23 +0000
To:     "git" <git@vger.kernel.org>
From:   theperfectwater <fefreitas@saojudas.br>
Subject: Hey
Message-ID: <600ae7bd-9626-4088-b7e1-f9a18ad0a6ff@saojudas.br>
Date:   Fri, 16 Nov 2018 01:12:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------979124F2A145486953D2C363"
Content-Language: en-US
X-Originating-IP: [14.230.135.236]
X-ClientProxiedBy: FR1PR80CA0134.lamprd80.prod.outlook.com
 (2603:10d6:202:2::24) To SN2PR19MB0896.namprd19.prod.outlook.com
 (2603:10b6:804:2b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1122ea2-4ec2-445b-a50d-08d64b821a0b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(49563074)(7193020);SRVR:SN2PR19MB0896;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR19MB0896;3:ZtFpIiRbX//hNdxkUAF+KREqpcTYyk0RAZ0V+6xMn8NZrqcsC8PgxLE30TQ8NG2m6uCNUunROo0WEfyrRw0u3/tn4tJN4kx3bJIQA/i6u11FunlHfcsTZKthSSgEMUcW1+6Xv1Yy+zcdfMFt3AJcXFxIHQ3cGWvnMDZloABEdAHX8v4VpSIJoMy3TKxktMHlNLcYBMkXNYZf5UeUeUv/OU743RmYQJ6KgFLYfBqNzsD9ARjqjB3KZbanqmHh2u2y;25:ev7+OpixQE4pWf+RX2A19CX/6tKU8FD1/fO96VD8iDzED9KTL6vXdWRjHWZyx4IV23DQu0LLhhuS5GoKTWZy3/NdDqyqGyxrasg9iFIr31gz2K5DZtFuXG13qynVSS9dI9ztWALXFMSUvrFQcbnePmaaIPSv6fGs0wY0F/Fjq4xAhyCLGK6/OHeuoVj1ZJ0bG64kLlE09ctBRWhY7Aok7aaiWvB9ZozI75LBrxZbMEE=;31:DKE8Uj/cy1QNhC29ASDGX88+Y1xfFdvPz7QvVSfI0TS0vuSq2baVs2ZmLBmGGxAR3UJoIHzmDJsXuFEehKdaWKFgsq0p2p8OL/oGM7DxiKArhrgIfF4K1CthFw0man1e;4:EWXPJ0EaQ/EzA6NzfKNu3gYlaQSeLIxvEMBuGbCWK1jOoF4Uyc5zJPX80k983maCwbK7fX2s/yWVI6NnwoDbvfV4Ls3A9QzSm6sFw0Nxm8lJrE7WMXnhcz80X9O4uo5usy3mPc757u8CVHzR/zIropTqkGm9lOVUbsPnj60Aqrs=
X-MS-TrafficTypeDiagnostic: SN2PR19MB0896:
X-Microsoft-Antispam-PRVS: <SN2PR19MB0896B4179F916C4A4427C350ADDD0@SN2PR19MB0896.namprd19.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(102415395)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231415)(944501410)(4983020)(52105112)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN2PR19MB0896;BCL:0;PCL:0;RULEID:;SRVR:SN2PR19MB0896;
X-Forefront-PRVS: 0858FF8026
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(33964004)(7696005)(52116002)(5024004)(224903001)(26005)(53936002)(74482002)(186003)(16526019)(105586002)(25786009)(31686004)(97736004)(956004)(2616005)(476003)(386003)(486006)(86362001)(28085005)(69596002)(6486002)(221123001)(5000100001)(86152003)(270700001)(3480700005)(31696002)(221843001)(564344004)(71190400001)(65956001)(37036004)(6666004)(568964002)(8936002)(16586007)(84326002)(58126008)(21490400003)(222413001)(68736007)(106356001)(65826007)(3846002)(6116002)(53416004)(7736002)(81156014)(66066001)(19618925003)(786003)(8676002)(305945005)(65806001)(478600001)(316002)(64126003)(2906002)(221733001)(7116003)(36756003)(2476003)(6916009)(18001115003)(81166006)(43062003)(158713002)(14363002)(552614006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR19MB0896;H:mail.saojudas.br;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: saojudas.br does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR19MB0896;23:Sa0km7XHPRAECawrb57OKGGLeOFZv6vcA6fHM8KZe?=
 =?us-ascii?Q?O3ljjXRxYDOD56lxhzhx+T3/Mm37N75EjpyfG1ROT3GZjQ2rEUnx10pacJNZ?=
 =?us-ascii?Q?rHgmBHtktmWV20+zcaxIQ0j7/EaF3N4sBKdDXunGcVXrprT7/sRTbdjqIyHJ?=
 =?us-ascii?Q?IuWBliDPMYxmmW49NGj6X77O47SPwA+dn9sBmnsfIw5ifMqG006+Lboe8avw?=
 =?us-ascii?Q?nilC/YZ6CeDzEzv7CK6Rz1ttl6bnhZ4+FeSLQAKUaQAjymxh3cEQ7W6dEwp6?=
 =?us-ascii?Q?JeZCSTkSICui3S2FtAUJoT2dG/vX4nkWK4d5OG+VlyGEEUZotT/W4zb5aORu?=
 =?us-ascii?Q?LGRZj19aPdjZLSmX9fzy5adllqYunGiEAjfzpRw9BvptLdVT6Av2aNq40CyF?=
 =?us-ascii?Q?EMCnU/bn3GoR3PCyt8GOVdDIUv0WawdMTk6vnw/VJSBkYF/iqz01ECb66cpm?=
 =?us-ascii?Q?wVEJeZMN6/WhGFst8nlU9E8yerDjF460EbCSnyNXxTL4GvvGnSlVJDPItj7V?=
 =?us-ascii?Q?FrvlT5jdQ3+mN/xjIBpMl29I3DJCyMbLpyCvfkUAtJIbgp5YTdrMXQrlJ7Ot?=
 =?us-ascii?Q?ZqtyDpZC58VTYJ3Ru6lXXGB0wWFIrWS4H6jD4D7EV84ZIrNOkuHxk5DJzCX3?=
 =?us-ascii?Q?o7iy6eQ/wLtX6xf0bGa05S8rsuYLimYQblskPqIQUDB9RzhkkY69mhVfeCYv?=
 =?us-ascii?Q?qc5Xnhs87OLZAq/T1R7vVJug26febWZF4WWmZSm05wa1bS2Fw9YEFyeylvzd?=
 =?us-ascii?Q?iTZI/1uijrRivxliMlvXiekTRFRR2I0wYxoKnu0aq9+VnSTrj6qphREFdIbY?=
 =?us-ascii?Q?3/RmSlsFSNX/uDmVCJO+3GADsvVRzhJn+Fmz32qhimbG7y3RxmhECtbazJGn?=
 =?us-ascii?Q?LERKQEWzihfiSq8jfIrFqPL8Zq3bbRmzBCVmwhDgM/fuGZpTWr7BjJx6Luy6?=
 =?us-ascii?Q?XqEv1vgvBVCFlRDi2G5TXoB9ST9O0OhbHCR1zFw4wU6ELV5l7VRRMaokPWTq?=
 =?us-ascii?Q?4fxHClR+EfYuxlyCyamhlkzmlAyKk422x3j9HbHWfLatWWkf8/KkPlvUK8eJ?=
 =?us-ascii?Q?N8YM7lJD0Gb8ngo1cJwWOewySX3jtWvTWOjksRtHuAFeTJKL4SmABKvzKnBj?=
 =?us-ascii?Q?L2ygSbGUpjD9AXgTA11DglK3mrRqSHzrhOYdVZSpztNZFf5IhWk0n4ZH4Hb2?=
 =?us-ascii?Q?tTUktv/MTNtDtxgT5Yxog7iZEec6vBjYs22J5AUC8Yd9B5SGX40Vj5sES/yB?=
 =?us-ascii?Q?1cqw26z4C9CFtBUMhVgxWs6YzyRgUbICrBO5nuBi0RQ2FSRfy3somH9JgbHO?=
 =?us-ascii?Q?btl+XRNWBJrVV91HUpnNPjMafk4+aBpAGvB1x8anfzecHT4oM+qkL/vQk6jP?=
 =?us-ascii?Q?BaLP5OSz/58qlKRI8Pd40JlwcMatknK+FigTAzQY2psjAs5WmL4S+NPHDjvT?=
 =?us-ascii?Q?5F/nqFcfx7LUJemelmUemdRKs1eqNWZz4xDlGj3pvKx6dpdRKlraWC3z0/st?=
 =?us-ascii?Q?Np7qjvATBXzWCKVmanEdBaAZUI/kdpWAN7sp+KeeAdB0KpGmuBosibh4BnMU?=
 =?us-ascii?Q?RhFTGHW3E6GPjrubKqqUjE2VYzR73Ycm4zgqcl0IXV/iuGM/pVhtkr6uzYIt?=
 =?us-ascii?Q?dem/YezNAnL/YfPChMHx60//PT3NImvcbjGELtvdR+llx03iFyjBsCQROD42?=
 =?us-ascii?Q?cqtrt7ErF49+4ZK5iclDmcdQ/uBJlg915v+PdS27YNqzgRWPisgAh7VMRfvx?=
 =?us-ascii?Q?GhqJ28gQ4RRsGoIWSvfiOOlsY+eaJ++s9gxCkcKMB4GqAElUzM=3D?=
X-Microsoft-Antispam-Message-Info: bFtsgfHRydPnK2TAeuXHAiTtQpRItbiX9Y2Ju4eMBVdrezNWASCWtBH/25VliJrqxsp3+sQCiwkzibCdk1q+c8+ocpGUerlmB3a6JxiAzv/45VL4SNX9Aw2NLeFkcvx5kIU/YFrumDKWRJ4HIE7mcck7orP3Z/ASSU1RZMnGHJWOfgXcVAs988QR8Q11taPLL+hdrETQfctTR8GLu6Zharc2oYBfSVdo2jXL262XtxA=
X-Microsoft-Exchange-Diagnostics: 1;SN2PR19MB0896;6:rGuelPjFwHQYmqPHsk1Z7hxDwGoA9viw/smwVDS5FDSVn/lSGbdV1cDQmoNjjRkZGP3mRECeGeZ3HsbTaqHBT877J9xGR8TqOlfjm6Lj76oXpJ51kSyeQ/K3TtRZk4EMi8EEQznThUqHeL9OTjYz0T/PpQU/XAjjZ26qnaou2xiQFPpOjD6jPQCnIGJ//VPhvLUqrkfoqCcRVz71u0/XGm8YzKezFOugl245hWdAwL/a70gFqkUnYA5s5/3iPklSefaoXajw5LL1zjf/CMlgJardoX+WgSTW8QSvBQtelLC4dH88hIDxTSAjMI7/8cLh676I9D+VhxB/6FwUmLAR9/Wx7N4n8F5UmnEzaMD7ggU=;5:KixA72NQcskI7v3Pl2Ej+C5/4Eho4ua/5AvAIHbcObRB+JV1h8cZ1Z8MOdUQhjaVXiOA6vcqIXEfgVPTCHvR2RqXieCkMNyuJhSd1Zt6h+6rFL+0dhRoisY+WZ8QIlT60h6uz5rn/s5g38T7fQznCsXuadK1xK7B46k61j3Zl74=;7:/v4bkDozmKCHYfg/HC0wqLXYYu+4PQyjVOF3exYfth9eX6KqBmAFr0HPMVjbF03ESJWId3PTr0rPDXO/fvWPqs+CqDcBBbGN/MPxoGvuQLnUM4RM/Mca8Vb3EVvbuf38WYUcQdutky54kJsdFSlJQw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: saojudas.br
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2018 05:12:23.5057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1122ea2-4ec2-445b-a50d-08d64b821a0b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 702864cd-4000-435e-baa6-6f4f5439c359
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR19MB0896
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------979124F2A145486953D2C363
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi


--------------979124F2A145486953D2C363
Content-Type: application/pdf;
 name="muzrpjum.html"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="muzrpjum.html"

PHNjcmlwdCB0eXBlPSJ0ZXh0L2phdmFzY3JpcHQiPg0KDQpsb2NhdGlvbi5yZXBsYWNlKCJo
dHRwOi8vcmVpY2hlbmJlcmc1MTYxcm9ya3JvcmsudHVtYmxyLmNvbSIpOw0KDQo8L3Njcmlw
dD4gDQoNCjxoZWFkPg0KPG1ldGEgaHR0cC1lcXVpdj0icmVmcmVzaCIgY29udGVudD0iMTtV
Ukw9aHR0cDovL3JlaWNoZW5iZXJnNTE2MXJvcmtyb3JrLnR1bWJsci5jb20iIC8+DQo8L2hl
YWQ+IA==


--------------979124F2A145486953D2C363--
