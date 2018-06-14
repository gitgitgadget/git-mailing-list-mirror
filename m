Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42CAA1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 18:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754780AbeFNSTd (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 14:19:33 -0400
Received: from mail-eopbgr10093.outbound.protection.outlook.com ([40.107.1.93]:20192
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754660AbeFNSTc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 14:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Frontmatec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFaNT/67PGYlFrXaS1DJ9WCRWJXxRe4s2tcWgMQMDRI=;
 b=FeYLloR9tBzLlgFK0TOUYwe0Jzk3jfxSiL6AG7LzbvEQ6YJR8GcGaW1LfWWVOgl+3Acg3aB61iGLOZZ73I+1isXEngWl7LN84PEhmsNkLVt9brD8hcS/2PtO+amw/FdzPVm+11WhT+Q4qjKqfTUNTtt71kDaWbgz3+0emgcVnQQ=
Received: from DB6PR0101MB2344.eurprd01.prod.exchangelabs.com (10.169.220.142)
 by DB6PR0101MB2453.eurprd01.prod.exchangelabs.com (10.169.221.23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.14; Thu, 14 Jun
 2018 18:19:28 +0000
Received: from DB6PR0101MB2344.eurprd01.prod.exchangelabs.com
 ([fe80::98a7:369a:60e2:c111]) by
 DB6PR0101MB2344.eurprd01.prod.exchangelabs.com
 ([fe80::98a7:369a:60e2:c111%6]) with mapi id 15.20.0863.016; Thu, 14 Jun 2018
 18:19:28 +0000
From:   "Antoine W. Campagna" <awe@frontmatec.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: fatal: could not reset submodule index
Thread-Topic: fatal: could not reset submodule index
Thread-Index: AdQDXhRDGoKkUkcaQy2EB6OED0HkCgAqeIaA
Date:   Thu, 14 Jun 2018 18:19:27 +0000
Message-ID: <DB6PR0101MB2344D682511891E4E9528598D97D0@DB6PR0101MB2344.eurprd01.prod.exchangelabs.com>
Accept-Language: fr-CA, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=awe@frontmatec.com; 
x-originating-ip: [207.134.192.27]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0101MB2453;7:7jh1j5neFITaKJwMbA1vg5oyNVR6/J0O4ZGAFvAE34evtN0Zq4Y72nJy/mFqDdlYpmpbJTpu6nQTlbsTtalxVb36aKyc5NBOJxH2zy0Gwjhf67j1QQ+BM00L+cjVOo9obkGlW+yFN7GhEGOwmWAk5ZalaCeiLo4ZHUAzL2pCTYdC4v/MhMq4cGcBYYxubpluPZb4idhsWFM33JyFN5dmn+ukCCNtY72hqeRu1jsW8ghLfYcLRve6GXMR32p1hb05
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4b9c9272-f8f9-4010-1352-08d5d2235db5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0101MB2453;
x-ms-traffictypediagnostic: DB6PR0101MB2453:
x-microsoft-antispam-prvs: <DB6PR0101MB2453AB7FCB8BBF847DBDA05ED97D0@DB6PR0101MB2453.eurprd01.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0101MB2453;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0101MB2453;
x-forefront-prvs: 0703B549E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39850400004)(376002)(39380400002)(189003)(199004)(99286004)(6916009)(229853002)(9686003)(2906002)(86362001)(316002)(55016002)(6436002)(5640700003)(476003)(68736007)(486006)(97736004)(2351001)(5660300001)(106356001)(105586002)(2501003)(14454004)(6116002)(3846002)(53546011)(102836004)(6246003)(478600001)(186003)(53936002)(26005)(33656002)(3660700001)(66066001)(3280700002)(74316002)(7736002)(2900100001)(305945005)(8936002)(6506007)(5250100002)(59450400001)(8676002)(25786009)(7696005)(1730700003)(81156014)(81166006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0101MB2453;H:DB6PR0101MB2344.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:;
received-spf: None (protection.outlook.com: frontmatec.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5lP/btqOaTIm3uoinJMBdV6kpKNIrZHv4pWkRI/cd+0BPO/52/jNVTQRBabQlndpAM3Rd7gD26f3FknYiqLg05Y6UY6JlVfiVV2PB6eBtdPPUZFPCFci1LxQN7fAnTWsfULc7d5QNP5B4eYfsWTeLnQdeV6QqJZzmdr/4IIRMiCkJnTNtiVb8VzcfS9tq4tk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Frontmatec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9c9272-f8f9-4010-1352-08d5d2235db5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2018 18:19:27.9888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bfbef180-ca7f-492d-bcde-824120bd7b33
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0101MB2453
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 13, 2018 at 18:19, Antoine W. Campagna wrote:
> Here is the full reproduction instructions:

Newlines got mangled, making my message hard to read. Sorry.

Here is the corrected reproduction instructions:

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
lized the submodule cd ..

# Trying again with submodule.recurse
git config --global submodule.recurse true
git clone main clone4 cd clone4
git checkout with-submodule
# Submodule is still not automatically updated (sub folder is empty)
# It seems like submodule.recurse does not affect git clone

# Trying again with both submodule.recurse and --recursive
git config --global submodule.recurse true
git clone --recursive main clone5 cd clone5
git checkout with-submodule
# Fails with these error messages :
#	fatal: not a git repository: ../.git/modules/sub
#	fatal: could not reset submodule index
# Same issue as with "git checkout --recurse-submodules"

