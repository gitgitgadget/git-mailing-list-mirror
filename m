Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27D251F403
	for <e@80x24.org>; Wed, 13 Jun 2018 22:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935733AbeFMWSD (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 18:18:03 -0400
Received: from mail-ve1eur01on0111.outbound.protection.outlook.com ([104.47.1.111]:37863
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935540AbeFMWSC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 18:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Frontmatec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOe4uaD4XccP+JqY5w5nqxSikO1gDmkTHBpAz+6ndd4=;
 b=Ww75Csv8uyknZPaGQ86UK6SSwgVAT4J2pmF6R8mGWDqkLnahFCau1IZjqdVtN2AikzzKY/UlfW4ly54D5dscOD0ShdS3L3RBEeN4gy8kx07hlYCA5P7RLCmqVCqvlarGBTRbCmzSXFuXWrXU1O7ycWnwaOWCJI0BbSjulTu6WYg=
Received: from DB6PR0101MB2344.eurprd01.prod.exchangelabs.com (10.169.220.142)
 by DB6PR0101MB2469.eurprd01.prod.exchangelabs.com (10.169.221.138) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.820.11; Wed, 13 Jun
 2018 22:17:58 +0000
Received: from DB6PR0101MB2344.eurprd01.prod.exchangelabs.com
 ([fe80::98a7:369a:60e2:c111]) by
 DB6PR0101MB2344.eurprd01.prod.exchangelabs.com
 ([fe80::98a7:369a:60e2:c111%6]) with mapi id 15.20.0863.016; Wed, 13 Jun 2018
 22:17:58 +0000
From:   "Antoine W. Campagna" <awe@frontmatec.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: fatal: could not reset submodule index
Thread-Topic: fatal: could not reset submodule index
Thread-Index: AdQDXhRDGoKkUkcaQy2EB6OED0HkCg==
Date:   Wed, 13 Jun 2018 22:17:58 +0000
Message-ID: <DB6PR0101MB2344147D4749598823B094F1D97E0@DB6PR0101MB2344.eurprd01.prod.exchangelabs.com>
Accept-Language: fr-CA, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [207.134.192.27]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0101MB2469;7:TKbKfM/orHJQOT6X8zUsF7Hl0KCDWFdEyusSEWI3Dna0qQxpeE7Br2Njz4JQs472JYwnpLsSikE+4CTMuIMgp+Wk8XlqSzEdPOl3TrOSZ2c9rfvIfFft4YMeYZgJ5PLZ/FNZyeGdlm22u3XNE0SDVnz60XBrHQMG3MDinmG8QITIQaKdLhsu/2zBxZMSoBwljiHICMbjZkqukigP+sFBPuYf3FWSXL1y4HXr9tGP7D/uxinG/WtkpXNqA6HeO1Ty
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: c8a21b64-4494-45da-f41a-08d5d17b84fc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0101MB2469;
x-ms-traffictypediagnostic: DB6PR0101MB2469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=awe@frontmatec.com; 
x-microsoft-antispam-prvs: <DB6PR0101MB246913EEB6C1E693170B9285D97E0@DB6PR0101MB2469.eurprd01.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0101MB2469;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0101MB2469;
x-forefront-prvs: 07025866F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(39850400004)(199004)(189003)(59450400001)(6506007)(66066001)(5660300001)(6436002)(186003)(2900100001)(316002)(55016002)(2351001)(5640700003)(68736007)(5250100002)(3280700002)(486006)(476003)(7696005)(97736004)(7736002)(102836004)(26005)(6916009)(105586002)(106356001)(33656002)(99286004)(305945005)(3660700001)(81156014)(8936002)(81166006)(1730700003)(53936002)(14454004)(8676002)(6116002)(9686003)(3846002)(2906002)(74316002)(86362001)(2501003)(478600001)(25786009)(42262002)(554374003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0101MB2469;H:DB6PR0101MB2344.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: frontmatec.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GiD+zXCWx/ZDbG2Dqyto/xsESRPYzzObsZ3DjDzvN4zB8heGp3WuXbIjql8WIBM9om+rgCajyIUIMvQDUGLOudfH3zHPbrKeT51sdT2g3fCtvbd90YrMonzQ+UAhdx40vljIHn+ueMEGHleBASuEZ8TT68LhdIZrJcK90E9LV1eaY3qQxvaZ2P+DF7wWzz55
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Frontmatec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a21b64-4494-45da-f41a-08d5d17b84fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2018 22:17:58.3134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bfbef180-ca7f-492d-bcde-824120bd7b33
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0101MB2469
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I would like to add submodules to existing projects.
Some branches would have the submodules and some branches would not.
Since we often switch from one branch to another, I would like the submodul=
es to update automatically so I activate the option submodule.recurse.
But I am experiencing a problem if I do the following:
  1. Clone repo, with master containing no submodules
  2. Checkout a branch that contains submodules. It results in this error:
	fatal: not a git repository: ../.git/modules/submodule
	fatal: could not reset submodule index
I think git is trying to update the submodule but the submodule has not yet=
 been initialized (runs "git submodule update" without "--init").
Is there a way to ask git to initialize the submodule automatically ?


Here is the full reproduction instructions:

# Create a repository
mkdir main
cd main
git init
touch main.txt
git add main.txt
git commit -a -m "Initial commit"
cd ..

# Create a second repository
mkdir sub
cd sub
git init
touch sub.txt
git add sub.txt
git commit -a -m "Initial commit of repo sub"
cd ..

# Add the second repository as submodule, on a separate branch
cd main
git branch with-submodule
git checkout with-submodule
git submodule add ../sub sub
git commit -a -m "Add submodule"

# Set main repo back to master branch (without the submodule)
git checkout master
cd ..

# Make a clone and checkout the branch
git clone main clone1
cd clone1
git checkout with-submodule
# Submodule is not automatically updated (sub folder is empty)
git submodule update --init --recursive
# Now the submodule content is there
# But I want to automatically update submodules when checking out a branch
cd ..

# Trying again, adding --recursive during clone
git clone --recursive main clone2
cd clone2
git checkout with-submodule
# Submodule is still not automatically updated (sub folder is empty)
git submodule update --init --recursive
cd ..

# Trying again, adding --recurse-submodules during checkout
git clone --recursive main clone3
cd clone3
git checkout --recurse-submodules with-submodule
# Fails with these error messages :
#	fatal: not a git repository: ../.git/modules/sub
#	fatal: could not reset submodule index
# It seems like Git tries to update the submodule but without having initia=
lized the submodule
cd ..

# Trying again with submodule.recurse
git config --global submodule.recurse true
git clone main clone4
cd clone4
git checkout with-submodule
# Submodule is still not automatically updated (sub folder is empty)
# It seems like submodule.recurse does not affect git clone

# Trying again with both submodule.recurse and --recursive
git config --global submodule.recurse true
git clone --recursive main clone5
cd clone5
git checkout with-submodule
# Fails with these error messages :
#	fatal: not a git repository: ../.git/modules/sub
#	fatal: could not reset submodule index
# Same issue as with "git checkout --recurse-submodules"

# I tested this in git-bash on Windows 10
$ git --version
	git version 2.17.1.windows.2
# And in Ubuntu in WSL
$ git --version
	git version 2.17.1

