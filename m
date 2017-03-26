Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F7B320958
	for <e@80x24.org>; Sun, 26 Mar 2017 23:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbdCZX54 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 26 Mar 2017 19:57:56 -0400
Received: from mail-oln040092008080.outbound.protection.outlook.com ([40.92.8.80]:48480
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751493AbdCZX5y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 19:57:54 -0400
Received: from BY2NAM03FT009.eop-NAM03.prod.protection.outlook.com
 (10.152.84.57) by BY2NAM03HT244.eop-NAM03.prod.protection.outlook.com
 (10.152.85.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.1005.5; Sun, 26
 Mar 2017 23:57:08 +0000
Received: from CY4PR14MB1238.namprd14.prod.outlook.com (10.152.84.55) by
 BY2NAM03FT009.mail.protection.outlook.com (10.152.84.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1005.5 via Frontend Transport; Sun, 26 Mar 2017 23:57:07 +0000
Received: from CY4PR14MB1238.namprd14.prod.outlook.com ([10.173.112.137]) by
 CY4PR14MB1238.namprd14.prod.outlook.com ([10.173.112.137]) with mapi id
 15.01.0991.020; Sun, 26 Mar 2017 23:57:07 +0000
From:   BongHo Lee <techcap@live.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: --no-commit option does not work.
Thread-Topic: --no-commit option does not work.
Thread-Index: AdKmir/J9RuJU+nkRnmdOtcrokqnLQAATdQQ
Date:   Sun, 26 Mar 2017 23:57:07 +0000
Message-ID: <CY4PR14MB1238D2E5D35E99405AA8BF61CB300@CY4PR14MB1238.namprd14.prod.outlook.com>
References: <CY4PR14MB1238A8AC2BFECB56B9B68056CB300@CY4PR14MB1238.namprd14.prod.outlook.com>
In-Reply-To: <CY4PR14MB1238A8AC2BFECB56B9B68056CB300@CY4PR14MB1238.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=live.com;
x-incomingtopheadermarker: OriginalChecksum:2E2B02FE5BCD5B6B3C91F3BD7EE6F360B1E99FA97DC2FD9B3AB91249B4D32231;UpperCasedChecksum:311F25F7B76D45635571BD7083A4E93A36C876DAC27B8116C78C47018890965F;SizeAsReceived:7976;Count:41
x-tmn:  [eVvxPJOMJCMT13B3RKhgBZeY5FlnNZ6j]
x-microsoft-exchange-diagnostics: 1;BY2NAM03HT244;5:xFAl3ib0DE2GZv9ZyxvDZuf06ge9cK8ELYpBVVVMjqen2qZdIufPtGF2g45z3bcaNfCmfgoP9G3DB31U6fajA8cBRjME/GhZMImVeZYmh6Gdj90JnunXwXqpiABhNiG1Cg9PbrWxJrTlnIYHYmyz9UirOGQm+872JXLU+DGjCmM=;24:h5+IlzDiWrB4aRp80QgbbwIHbzB0mdp4z8gEIVuCSe9doym+zzOtBpS6vef5XkSZWUfkqka+XXtvKMTTnuIsKd1dC5ejNskiBVRbMG++F6w=;7:dEHTkRWoadmevWBLkWCjM18ZzSCfCA2XogET3uQQ/747/5Tljx7FZicnbJYBnfb+mlJJKL/hGwueTyY10fPZjCvSXBlbgx1/4jadzzCfASB7Hl4U6Q8O+y/URfpWWkO1/7ICKKcufkK5XVNC3dvoS/ujaEfLYuf0fG4ctzNZRqouHNLR42aAxFjG+HXnNCB2RjDQ/yUXOS1IK+pMBVxHYOKi+3ZxvnbZD3Kf6WyZZ2SLBHm+vA/jxs4co1fGh1A3b62Q01j18LDCVKJCi8dMmv6c3e/HOd9uXRkTNtethPnTWcPwpfKcamxM12eBCxfI
x-incomingheadercount: 41
x-eopattributedmessage: 0
x-forefront-antispam-report: EFV:NLI;SFV:NSPM;SFS:(7070007)(98901004);DIR:OUT;SFP:1901;SCL:1;SRVR:BY2NAM03HT244;H:CY4PR14MB1238.namprd14.prod.outlook.com;FPR:;SPF:None;LANG:en;
x-ms-office365-filtering-correlation-id: 087cc9c4-1bfb-4b44-5d7c-08d474a3cf97
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201702061074)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322274)(1603101448)(1601125374)(1701031045);SRVR:BY2NAM03HT244;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(444000031);SRVR:BY2NAM03HT244;BCL:0;PCL:0;RULEID:;SRVR:BY2NAM03HT244;
x-forefront-prvs: 0258E7CCD4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2017 23:57:07.5971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2NAM03HT244
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Setup
Version : git version 2.12.1.windows.1

OS Version : Microsoft Windows [Version 10.0.14393]

Options 
$ cat /etc/install-options.txt
Path Option: Cmd
SSH Option: OpenSSH
CURL Option: OpenSSL
CRLF Option: CRLFCommitAsIs
Bash Terminal Option: MinTTY
Performance Tweaks FSCache: Enabled
Use Credential Manager: Enabled
Enable Symlinks: Disabled


Git Command : git merge --no-commit origin/workingBranch

. What did you expect to occur after running these commands?
merge but no commit.
. What actually happened instead?
commited

Reference URL : https://github.com/techcap/nf-interpreter

Details
I tried to merge from MergeTest to master.
After checking out master, I run below command.

C:\work\nf-interpreter-techcap>git branch
  MergeTest
  TemplateModification
  UpdateBuildInstruction
* master

C:\work\nf-interpreter-techcap>git merge --no-commit origin/MergeTest
Updating 197ad33..028f9f5
Fast-forward
mergeTest.txt | 1 +
1 file changed, 1 insertion(+)
create mode 100644 mergeTest.txt

C:\work\nf-interpreter-techcap>git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
nothing to commit, working tree clean

If I add --no-ff option, it works properly.
I think --no-commit option should be worked without --no-ff.

https://github.com/git-for-windows/git/issues/1102#issuecomment-289206961
