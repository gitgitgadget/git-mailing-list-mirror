Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F28E1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 13:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755028AbeDTNgw (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 09:36:52 -0400
Received: from mail-sn1nam01on0133.outbound.protection.outlook.com ([104.47.32.133]:62850
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754936AbeDTNgt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 09:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Dvxx1FI50Slh6riIKB64e31yul6kDpRRBFgp11MNgLI=;
 b=ZdqRBpjNz7DRuF5gGFVNs63w9ihdtsxOv4Z9LgJzRFmuvxBSj760IjRx4uRoZisXecpc4Avc/dlpShngyEwtnEB2pZEfg2JOu0pQ8XTOFfqZM5uLIvmgCPf6X3NLRU4Kh83uQ4fNkgENu5Ipp9MLgUeBx5IbpTHgnfI65l1uwvY=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0872.namprd21.prod.outlook.com (10.167.111.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Fri, 20 Apr 2018 13:36:47 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0715.010; Fri, 20 Apr 2018
 13:36:47 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "newren@gmail.com" <newren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1 0/2] add additional config settings for merge
Thread-Topic: [PATCH v1 0/2] add additional config settings for merge
Thread-Index: AQHT2KyggoQ2ksFcfEGq4tI0iaVNBA==
Date:   Fri, 20 Apr 2018 13:36:47 +0000
Message-ID: <20180420133632.17580-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.windows.1
x-clientproxiedby: BN4PR10CA0019.namprd10.prod.outlook.com (2603:10b6:403::29)
 To DM5PR2101MB1016.namprd21.prod.outlook.com (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0872;7:LPXIs9kjaMm2mq7Z/E5+mNe/2TsydBK4eXji15yB3EsW52wMyXkVR9gPXiSShT4KU1HkP7boWu2GjBVLol5w2rLVIj3tJ+Cgqxac7ZOf/0J3c4HRF8A9dOZc/WgPNtT2fymWQVkktvZcSxmpVBW7E5Hpb1wMNsP+fqtn7Mk2Pj3vIgGqmj92T4ylgXDltLEp15mIy4TQRq6ocS+Y9oZH+BWzjlWZ2g3dsO0J6twWknR2imZpWWbwh2a/4C/Q/LfM;20:xZpLBunOYd5xcZZP4xTFvq8fCZhBe+0SqQeM0qCLNr6zaKHNjDRGjHROKmdBihGUKbU1V8qrlPiWZDVpSmjAgsH8rFBx3lThgUQzHn/Fzj3B7471c8cOxJTBX0t1sKMAWp9YrXrpUQFJvksH6Z+PHqfXI/wv2vj6U+dpa0wuc8Y=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB0872;
x-ms-traffictypediagnostic: DM5PR2101MB0872:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB087218149B76B23B193D98C3F4B40@DM5PR2101MB0872.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(166708455590820);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231232)(944501394)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0872;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0872;
x-forefront-prvs: 0648FCFFA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(39860400002)(396003)(376002)(8936002)(6916009)(5250100002)(5640700003)(575784001)(476003)(54906003)(25786009)(10290500003)(50226002)(81166006)(966005)(8676002)(4326008)(1730700003)(3280700002)(3660700001)(14454004)(72206003)(386003)(478600001)(52116002)(39060400002)(2900100001)(86612001)(6506007)(107886003)(2501003)(53936002)(186003)(8666007)(6512007)(6306002)(6486002)(10090500001)(2616005)(99286004)(5660300001)(102836004)(2351001)(22452003)(26005)(36756003)(6116002)(3846002)(2906002)(8656006)(1076002)(316002)(6436002)(66066001)(7736002)(305945005)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0872;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8vs38eG7GlovJ/TEAMa0m3g0ShdW+zp0kOnZH6xlP7M3Xguki9P3tUAuUTyw0W856L+qXneht7yNMqgyv6kcj/RyvO0Zq3nyn/s+z7M0WI//8K8oIo9RhDIj1oTTb20r56Py0+hDwrpnEe8vKxOEAXvTylEYSI+4KXNkOwGOr2PZU5q3sSpsmTv7Iuh4Y286
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 19962408-7a76-45f0-16b6-08d5a6c3c323
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19962408-7a76-45f0-16b6-08d5a6c3c323
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2018 13:36:47.2308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0872
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This enables the user to set a couple of additional options for merge.

1. merge.aggressive - this is to try to resolve a few more trivial
   merge cases.  It is documented in read-tree and is not something you
   can pass into merge itself.

2. merge.renames - this is to save git from having to go through the entire
   3 trees to see if there were any renames that happened.

For the work item repro that I have been using this drops the merge time
from ~1 hour to ~5 minutes and the unmerged entries goes down from
~40,000 to 1.

Helped-by: Kevin Willford <kewillf@microsoft.com>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>

Base Ref: master
Web-Diff: https://github.com/benpeart/git/commit/a3d157f5be
Checkout: git fetch https://github.com/benpeart/git merge-options-v1 && git=
 checkout a3d157f5be

Ben Peart (2):
  merge: Add merge.renames config setting
  merge: Add merge.aggressive config setting

 Documentation/merge-config.txt | 9 +++++++++
 merge-recursive.c              | 2 ++
 2 files changed, 11 insertions(+)


base-commit: 0b0cc9f86731f894cff8dd25299a9b38c254569e
--=20
2.17.0.windows.1


