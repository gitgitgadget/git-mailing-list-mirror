Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B851A20958
	for <e@80x24.org>; Fri, 31 Mar 2017 11:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932892AbdCaLzq (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 07:55:46 -0400
Received: from mail-sn1nam01on0128.outbound.protection.outlook.com ([104.47.32.128]:26528
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754418AbdCaLzo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 07:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lsac.org; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=W4c+6h56QXaw91bVn8of9fbuSbkcT8IBzPtK7d+a+EQ=;
 b=hwFOmIYNrWF6XoU3XHQQOBEHYrdX2/lOgnPPZ62JrxKSMIXXjDzJbbtF+9LeSvq9ZOXglL+gQ4IzfhNDaax+yaB/p3Vr4TJNKRV02GMV0wl/oU4cvVYBFcOhEg7YtOi3A2oKg2lw5+lI/CfqPPaK1hvKmMLUVWax++0YCrhsjgo=
Received: from BLUPR08CA0033.namprd08.prod.outlook.com (10.141.200.13) by
 BL2PR08MB498.namprd08.prod.outlook.com (10.141.93.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.991.14; Fri, 31 Mar 2017 11:55:42 +0000
Received: from CO1NAM03FT005.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::203) by BLUPR08CA0033.outlook.office365.com
 (2a01:111:e400:88d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1005.10 via
 Frontend Transport; Fri, 31 Mar 2017 11:55:42 +0000
Authentication-Results: spf=pass (sender IP is 64.9.4.149)
 smtp.mailfrom=LSAC.org; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=LSAC.org;
Received-SPF: Pass (protection.outlook.com: domain of LSAC.org designates
 64.9.4.149 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.9.4.149; helo=smtp.lsac.org;
Received: from smtp.lsac.org (64.9.4.149) by
 CO1NAM03FT005.mail.protection.outlook.com (10.152.80.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1005.5 via Frontend Transport; Fri, 31 Mar 2017 11:55:41 +0000
Received: from EX1-PRD.lsac.org (172.16.1.148) by EX2-PRD.lsac.org
 (172.16.1.149) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Fri, 31 Mar
 2017 07:55:40 -0400
Received: from EX1-PRD.lsac.org ([fe80::95b0:a9b5:d9ec:9ecf]) by
 EX1-PRD.lsac.org ([fe80::95b0:a9b5:d9ec:9ecf%15]) with mapi id
 15.00.1263.000; Fri, 31 Mar 2017 07:55:40 -0400
From:   "Mayne, Joe" <JMayne@LSAC.org>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git Branching - Best Practices - Large project - long running
 branches
Thread-Topic: Git Branching - Best Practices - Large project - long running
 branches
Thread-Index: AdKqFGFr4AbqHgmuQoWxd5KT1pKR9wAAUHTQ
Date:   Fri, 31 Mar 2017 11:55:40 +0000
Message-ID: <4bb4871d8a78402bbef91231134a613b@EX1-PRD.lsac.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.22.2.78]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.9.4.149;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(6009001)(39410400002)(39400400002)(39830400002)(39450400003)(2980300002)(438002)(55674003)(199003)(189002)(356003)(47776003)(8676002)(7636002)(7596002)(305945005)(7736002)(38730400002)(110136004)(50986999)(54356999)(6916009)(33646002)(108616004)(7696004)(189998001)(2351001)(53416004)(97756001)(86362001)(106466001)(80792005)(23726003)(3846002)(102836003)(5640700003)(55016002)(6116002)(2906002)(5660300001)(1730700003)(24736003)(8746002)(46406003)(8936002)(2501003)(2900100001)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR08MB498;H:smtp.lsac.org;FPR:;SPF:Pass;MLV:sfv;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT005;1:6PVCjQDBvFZQ/Tb3eq5ME92bFldoC0IrlmRAdhiK7hhgpPw1BppdtQqjdxPV6VwUNxPEfQkPyXydVVJqqL0Fk0sOCfyET36cKXdsejdQQvrmn4IyKYXibIlIBfi/PcY5XDXG7zuqCnhdDT6FTjtjpz2trX9lST7U7YX96qlfFWpzf8wjeLfAobyzZLQO1xFxgomwkO8OWDh8b9KlFB4CeooVKVRpmOGXevcHk7I24xfMuiHD7BetAZiB54HYPUUZPAmen7C5icCidS5GK4Ja5g2+Xs4NiNacu06dhXl99Ghwcnl4HBsteQNuokV3QxN3MJQWV8wG1DgQu/lrd9txmtxBFI5ySmrCIxB+2LGVu/5nBZ+fiRlm8Z2rl8frH45lcnQBDaQ7JBwV/3LUSzupoo/esbAaFpzUykSBiUuMQ8Gp4T9j4sp7bwDCBdnVn3k6irRLFysPuCA6vTrsxf4OMRSf7AOyFjtPbtjdWYbmsLHnrZZBk9CCmXW11OEDETrcTKhzCoaktZKk002ahnBGO3BS9Br8W3+XnVFltwKVBIQ=
X-MS-Office365-Filtering-Correlation-Id: 731db525-3e33-4153-0133-08d4782cdb27
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(8251501002)(2017030254075)(201703131423075)(201703031133081)(201702281549075);SRVR:BL2PR08MB498;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR08MB498;3:OONmFmrZbX2RX2BiLpzbq1ozXtFHkggRDy2mADFPknMJi5pxNdJ8WMIDiMQtF2VXHv7FcZ4n38ezq3f1+42r6C4jZ5/+vA9Rjt0Xn8CcOa/q4y2OLfS9oiQ63r91Iy0fKLgY/8MB4vG5OvGIGnHsQdTTg62Z7rotjBVoy76eP02jlxboMomMZrkNFI/2GZkoKEx0qB3AGIoBzaFxvbTuGKghHqwFq43OpkSNAfG0+4bO/9qwgGc/Oa54CJU7MUhnRgPQSW/O6ZIsvD1utK09j8KyJUOz8+8PvFp152jWBL9XkF6FF7v8xcpQRwfcCsl5K4hCIfbp4yxMsK+Tm4aaO1SBgzmo4uhQS71RiUBf4dG35lxz1IK7SjVLEiGh6gdRV0XLLO8m0rTbIq7v6y1hjE+Fx/cQxDOgL6WJz9Dd/7xC8J8xXo/vfP8DJDB+vcC0vp5PmgoUxEiOrNcoBc+a3POjnlGuy3E8d//KWmOkie3Vo5aQRbWYLslitP3U5yJoEiXf5IvHhN6Lz+k+P30+4A==
X-Microsoft-Exchange-Diagnostics: 1;BL2PR08MB498;25:zZL2DrVUQUzCUF29L/FemOuXwIyL/9+6m3/NMGBbUc0l21Z/k84mC4jEVoGZoyFyL6YcVSY+FBFYroQmkRK+8Ow984syk6k2+whIs0kKh10Dhj5OMtIe+mCYLCcNLBTMeazAl55moIt4pL4Y0CAVFUD3MRu49sOwUQuYOva3eRVEhUVADRheoQzLxNSWTx3tCg6n3Kuup/FjR+MO/PjB2MfsbAjMjV6DDN2yvn22M3pDvrVWiPTLfwj7iSMrGUhtO1VwtTx0WjMNlmVILYdzFfsDQJH8/hwOj08DQMoaKfW0B7geURN8QspF+F/DZev0I6Wc3lGUzAt5a7B/JjcQFZnOEqb8zGRawtcoyNlhKQ4y3fa9jcNYG1zONitCTbokcjtShRJZwSvcOMAvZnI9urOGZs7jbx8Yz1aYJJndcSqIN8t4jvCjuEK00xd6OzgF2EvO9DWrBKYuPk8UKxs/Jw==;31:fU8iybDhDc2M2j44TxPKYNCItLne3t9PqeImRi+BkFoqx13ufAFLq8vq4otZsUJyoFH8aVK+Pp+HuLoMP5cP+p3+9hoXJFqlSJ5TqswFflNCfpIZOL8okqdjsAFQo/LbQhXtCKtu1WCxgwJxsdTl53IeOdA+4yzydGag2os0CUgm6pWkOM0YuLepSU8CD3Xe3UizC370rr6NkJF9IO78z2wltvE3KUFvEWbuJ+x0GCnzWC8/9XxGFHIPOFq+ykRUY+RpcLmssRsSTZyg8ITpYQ==
X-Microsoft-Exchange-Diagnostics: 1;BL2PR08MB498;20:/dXEmMsp2VAn28O/iLDqhg1feBEJ/hcc9PzB8UCMD452R5f6OIjESXqjP0PHOEK1Qp6SOujy5v/TxLZPC3U+H4qTaic6mwknJOMIgn7SAEWYQRG2+GVX5PzMEY7FzrbanjsEO4Mq2vw9vvRYpc1vg2sD2DCXJmt4sZ7XlIh9MMXIWdvrahhFNSWOv9TybhjRDSvydfYkHrua/UBog5b8VLCvdRbeKgRRINm8rrMqO77KjQRRL6gr2VunsQVPGlg+JaNs4RSGA6vOttYPin7XWGqGXHRHDhwUYQUmqVUqojyOmcCmiko5E5ewn0PJp4TP4g6iuSQG3xNK83TiJuCWuPvpE1fW2+qt3DT5nVAViY9YG72eh9b73L0onZFIhDUy6BH94s7CZH5okjeLbVjgrufpX9nCYr8fReyFd8QjiUi2YRFjgcWu0DQgKN2/fPqGbsIWKayRZKVplnZgzuece3WaLNtB90fxoLpW+UDmqxk5uR4+4+Aq9bsCAGklPvVh
X-Microsoft-Antispam-PRVS: <BL2PR08MB4983D8E5C191834FB84B730A7370@BL2PR08MB498.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(8121501046)(13013025)(5005006)(13023025)(13020025)(3002001)(93006095)(93004095)(10201501046)(6041248)(20161123562025)(201703131423075)(201702281529075)(201702281528075)(201703061421075)(20161123560025)(20161123555025)(20161123564025)(6072148);SRVR:BL2PR08MB498;BCL:0;PCL:0;RULEID:;SRVR:BL2PR08MB498;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR08MB498;4:S+xnEpjT1w8+U/Uo7IBF9LDB5Pp6ABS+Nhw0TBgcIz2AlBN8XxckoUnzkuQosjHPSbeP5Tvwq662MiLpcmYLY5u12vVBbcia0sg9z0K+YqFXiLDZ8CzT/wSj3v2CnRhoHwzj9XdsGwL1TJ/9neoT9tP8ESFY5pvSZIfvviU19LEszuKDQuYAtGggwuJXOeQOf+zGb0YuLsSPOwJQr3Kw38VUF/fb8iVP8ekdxcNUJmP/KGz2XIlqnsHDAqdlNY4kM9AJI1KlrIEnnB2jFbSw7MY6rKuQy0a5T+/9YLVwhOutaSvUZ4wA6GPUXeOOUBhIEJGCHhcDzM4ufflfMbvTPCaa27zQ5WjOAVBHcg6utO7e2PY3RoNiyoqlMIMQxejMBE2WVok9wb9SUcuicdYl1pA9NcFYsYQVWb5vVQH2h1vKO9fGLvvkbDAxlZHdEEFxHypois+pO7mkrT6lxvPuAzmsBaxNxgztwnKvoUxQeTvbXHwmv2PPOl3FC0bjs0IkRchds6hFga2ZHomqOf6xbUtFkaB/z1pj/ClJziK0jfZasl7xpqy3tggq5vOXtbJ1xVksgdzD7udyiPsIrd+iuLbayt/ZLlkkN/qzS/zGNbS/DLd5I6xaSNKtjcxyU1h22g8G50hg50AYjjXbtx/bsKEnCNUm+qRhwUM6p1bNH/99i/WGyXlXhZ1ZnwQ/9/gm2dirh5Cwhls80Vf+KvcvdD33Cshx7YDrnO/aSGve/XK3qTR5GNtXu/vsgEUtJUGpBar7/MqKn0FIoHu3Utt0vsHBNSv1V3lkiPicm5eKf0RJp9JDYj5CJ2+01am67fvZ
X-Forefront-PRVS: 02638D901B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR08MB498;23:M3J2A+r5gMmonIeEEIZcVoH7CdKcltjauX3GnHhwQJ?=
 =?us-ascii?Q?TQeenzuJJgOz/Sr+ugxp0I3pC1oRfmEsiQhL83ASnJD06pRzzLp4bgj99NuC?=
 =?us-ascii?Q?m8qz38wpXmtjfaZORMMFF4ZgmXNPb5aHkvrZsUsH2mm6ChW6h5BNbY4l9WoQ?=
 =?us-ascii?Q?DRJ2FXBclKfKrTTzO3GPBAkfTZ1GcY5LKSFqQLWFVegHFGM3J6/fEa1JuEnb?=
 =?us-ascii?Q?aa4gdrAHAy91IUNtmqpFqobS1JlfJfEq/rT2D/afwqiq3U+eHWWL0wv5Ykkp?=
 =?us-ascii?Q?Aof6xw8bLkjw75Pq1EEvg7U/hB2jYoBzJ8QrKLCmq5mcO8/ein2FnNAfFaHH?=
 =?us-ascii?Q?hb3RgTKYtfu/ECjLpRtdZo6q2u9WyRswjtj+D5jMjcyfUfBpNG4BYyKi4Tca?=
 =?us-ascii?Q?sJ1l4rON7R6LuDTGScEaRXjm0MmKyr7OfAJ1w700LJCGxW/IMNz/1p+hS3hy?=
 =?us-ascii?Q?85VPYw9KheowuhvV2GbU3F1xPB82mv9yQa1KkflLldx+S25WQWQ7UHcPm56B?=
 =?us-ascii?Q?2xOdGRQqMDz84ZYCX1eL+x5cRKzx0EeB71rGwj6fxjKHZCJYu/yCmcmcq7xz?=
 =?us-ascii?Q?zApUVgUV1k9NMwomd8zJvh6vDRul+IQcbYFTF05r3EP2lICkWqZK9t5wj3QW?=
 =?us-ascii?Q?+r1KAotXZsozW3VJMC6OmYvmS7Lwp7G4b98jAcmj1zPoKQTu6eL/Vcl5A627?=
 =?us-ascii?Q?4V2fEfGHROeg6pP3qXzIc5qiYbklPTcjM67S1SpPEC+IWL1sm1eWw+TvrBQe?=
 =?us-ascii?Q?U2VgrCoGHYuijhVhaztCbArwg4ECsB0P6L0wnRctsc85N6H81qQUF6RcQQPC?=
 =?us-ascii?Q?l9JuxCD0PVpinsSF5QpAOeKSpeWEFIFSzUrs9O8ajMa009JK+oxKnmXdeaZW?=
 =?us-ascii?Q?1oPvQZwQMldMuIRxNCO5XXcvPs08Rat0HlUELVN7dZr+Bh1H5CoxR7vSNo5i?=
 =?us-ascii?Q?aCLuBBe3ncAt9BII6Pr+2vDK7BeamOYXHk384+UOhOV6LRdoFEtnaWTbmh9O?=
 =?us-ascii?Q?6w/VyMaskTTnrPdgSY7y3IATy7vyQJIeXSEu07FMYUmj5Lml9r3bPE41I0Ax?=
 =?us-ascii?Q?a4jmuPLcUvqWb9fX+ybEK63GU+xLuLcfT4mQ7utAHNPg1WcrhaZGrskvPld0?=
 =?us-ascii?Q?2+ikYLH/caQ5rLAzhsTRb3PSId2UCRHMpkjxPY2IhPA0n7IQnkKQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR08MB498;6:R5Pe/yFpaiHEGhPHE5e+xkmwSV8XzPm4hFPV9TEizvkDSaAixXrseEM37Vl0Hpc2X/6/F7ee0ch50E47Wq9Cezsm0pewm79m7wadUUt1piuY9PliF1fXUPBYlH4ofWXJ7EHghsLG4SPj1niuoG9vxAclFJTB2KwB9rwXC3m+g/JmNF8NO90zF3yTilSL9qqh1QHtUk0lfH0xIOM4iz0nQzkt4iaPbL2BQBU12geo42Gm7pJgJXltgd8uq3PIMDO3W8JH+bp6uTlnXDOgV3ILkf26F9z9Ou4rzrRY7MBt44U1xjnLyfuUg8kht4XDPSctZ3PurJISgCzqcSFlrNQhw6ikVFXrgymnr3mumFCYrGFq9VaOkn4irydUc8FVdp9n36KQ8HaddtvI0CNaHxN+2Q==;5:ekE4/viRZFrbljMq6q2Vv+OpI/79CijcwWB3onWJgtV2umHbllmkSewFxIYkHA1rarprEzLUjksfUm9VsBqHrusnkunmpwv9MiBm328Bqm9UAK9uI3g46S/bip74hOqXltN3H7i+KBhjK9AQ7h9IWA==;24:zV9GpQV51ZMQpUvg+JclFFhkZlR2/6JdO+o6MPlSGwzNtXp9iWOsO9ed6SPcH6fAGltUM3lRki6VznD1F6p3067eOdfzjahVKkDTLbewbYo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR08MB498;7:huxgukLT0nER8dGEasFuXaCgiPJw7EBEvSvE6UuMRTiXe7mUCise3IJEKuj+5R7y5Weq/jPTepTfCWWYhuaGEqCakyS2OGg9sPJQuGoGLTtu/jYE7D84ia/3yfGKPAp2eCOM439tcS3jNacqaEA7JXMVJ096hwHse6f6d5NRYn92Pd7NwvTP/XhN8Ar4Qima865Qpz5Q2clBPdm4zFDA/klwjA+suRGTfekl/m8ml9jLFuWJg2j4l8UD68mKrXHp5NbwwV3C96/TnEIdZ1IAM8p/V3XJ11M4iKKuZrI60q9T3ek/9XNnuke6OcsEIZ/MdyDlCFpjiRZd4cvRdRgccg==
X-OriginatorOrg: lsac.org
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2017 11:55:41.4711
 (UTC)
X-MS-Exchange-CrossTenant-Id: e4559af3-b73e-4cc4-967a-c594c303a23e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e4559af3-b73e-4cc4-967a-c594c303a23e;Ip=[64.9.4.149];Helo=[smtp.lsac.org]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR08MB498
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I work on a team of 15+ developers. We are trying to determine best practic=
es for branching because we have had code stepped on when a developer has a=
 long running feature branch.=20

We have a Development branch. Developers are instructed to create a branch =
when they begin working on a feature. Sometimes a feature may take a week o=
r two to complete. So a Developer1 creates a branch and works for a week or=
 two. In the meantime, other developers have created feature branches from =
Development and merged them back into Development.=20

At this point we are not certain if Developer1 should:=20
* Periodically merge the evolving Origin/Development into their Feature bra=
nch and when they are done work merge their feature branch into Origin/Deve=
lopment.=20

OR=20

* Stay on their pure feature branch and when they are done merge into Origi=
n/Development.=20

We have had issues with developers stepping on code when they have long run=
ning branches. We are looking for a best practices.=20

Thank you,
Joe Mayne

