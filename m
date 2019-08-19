Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A0631F461
	for <e@80x24.org>; Mon, 19 Aug 2019 09:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfHSJlf convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 19 Aug 2019 05:41:35 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.112]:43331 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726366AbfHSJlf (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Aug 2019 05:41:35 -0400
Received: from [85.158.142.199] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-central-1.aws.symcld.net id DD/CF-30864-9CE6A5D5; Mon, 19 Aug 2019 09:41:29 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRWlGSWpSXmKPExsWi+sWpUvdkXlS
  sQf9HZouuK91MDowenzfJBTBGsWbmJeVXJLBmHF9/gLlgo1jF2ks/mRsYVwp1MXJxCAmsZZRo
  XrKFBc7pnL6FCcLZzShx4dIp5i5GTg42AUWJtjnT2LsYOThEBPQl+i6IgoSFBfQk9n06wwJii
  wgYS7xrWMoMYetJvDk0C8xmEVCVWPtxFRuIzSvgIrFrSgMjiM0oICvxaOUvdhCbWUBc4taT+U
  wgtoSAgMSSPeeZIWxRiZeP/7FC2AYSW5fuY4GwFSSefu1nhejVkViw+xMbhK0tsWzha2aIXYI
  SJ2c+AasXEpCTuNP2i3kCo8gsJOtmIWmfhaR9FpL2BYwsqxgtkooy0zNKchMzc3QNDQx0DQ2N
  dc10TYz0Eqt0k/RSS3WTU/NKihKBknqJ5cV6xZW5yTkpenmpJZsYgXGTUsimtYNx4aw3eocYJ
  TmYlER5FWaFxwrxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4PXLjIoVEixKTU+tSMvMAcYwTFqCg0
  dJhPd5LlCat7ggMbc4Mx0idYrRnmPCy7mLmDkOHp0HJN/9XAwkN89duohZiCUvPy9VSpx3bg5
  QmwBIW0ZpHtxQWMq5xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmYdxXIcp7MvBK43a+AzmIC
  Omv34UiQs0oSEVJSDUy9on9eTbynnVVyUWPlZ03BM74ncmRC329Zt3LO40fvD1zP4Tp6Y4tVn
  CzTWV727evZzbystZ0uiGxOdeV7+lDHbeKppr5rB2MF3hnFlPD9Egycsuq/QfzNiuOuIdnsRZ
  0bPHfOMTx8XWXx8bAr6/Py9Ba3332wWEdl2dOFb3OtBMQLsk8I/13yzeZvisysk4yOmy+/naE
  tG6Lwzk7RqIdzw7731ou2e5SfTq6vTv6xviXkU94U3RlmKzlPOb+6p8BncvavfJW78xkeR8Un
  PxyebxbesFLJieMQo4qPa9fee7XXLTmi38YteV59Q754ie69v0ZVbczr2x1XCVcnTBI9/bevb
  tJbnWt/brxYvCFXiaU4I9FQi7moOBEAmSjgL7QDAAA=
X-Env-Sender: eda@waniasset.com
X-Msg-Ref: server-32.tower-244.messagelabs.com!1566207688!686532!1
X-Originating-IP: [37.244.66.121]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=waniasset.com,-,-
X-VirusChecked: Checked
Received: (qmail 11429 invoked from network); 19 Aug 2019 09:41:29 -0000
Received: from unknown (HELO smtp.waniasset.com) (37.244.66.121)
  by server-32.tower-244.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 19 Aug 2019 09:41:29 -0000
Received: from WCL-EX13MBX-DR.wcl.local (10.45.7.24) by WCL-EX13MBX.wcl.local
 (10.45.7.22) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Mon, 19 Aug
 2019 10:41:26 +0100
Received: from WCL-EX13MBX.wcl.local (10.45.7.22) by WCL-EX13MBX-DR.wcl.local
 (10.45.7.24) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Mon, 19 Aug
 2019 10:41:23 +0100
Received: from WCL-EX13MBX.wcl.local ([fe80::e996:e311:ad61:40e6]) by
 WCL-EX13MBX.wcl.local ([fe80::e996:e311:ad61:40e6%12]) with mapi id
 15.00.1263.000; Mon, 19 Aug 2019 10:41:22 +0100
From:   Ed Avis <eda@waniasset.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git switch and restore user interface
Thread-Topic: git switch and restore user interface
Thread-Index: AdVWcLjWfi3Pi/Y3QraS0O0y/jadrg==
Date:   Mon, 19 Aug 2019 09:41:22 +0000
Message-ID: <a3a66e58b1e44e88b9c11655c7c77e87@WCL-EX13MBX.wcl.local>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.45.11.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think it would be helpful for git switch to print a reminder of the old and new branches.

Hi, a couple of suggestions for these experimental new commands.  Git switch should print the branch you are leaving:

% git switch foo
You were previously on branch bar (abcdef).
You are now on branch foo (bcdef0).

Sometimes I forget what branch I was on before and having it in the terminal history would help a lot.


For git restore, it might be worth splitting the command further, into 'safe restore' and 'destructive restore'.  The safe command would always stop rather than lose data:

% git safe-restore .
The following local changes would be overwritten:
   Fee.c
   Foe.c
Stash them first, or (etc etc).

The command that unconditionally overwrites working copy changes should be given a different and more dangerous-sounding name.

The reason I suggest this is to make sure of a sensible answer to the newcomer's question: "I just deleted a file by mistake in my working copy, how do I get it back from git?".  Too often at the moment the answer is "git checkout ." which while correct is also much too dangerous to be a first resort.  There should be an obvious and safe command for restoring missing files without losing local changes.

In fact, I'd be quite happy for it to be like git clean, which in the default configuration requires some flag like -f to make it lose any local changes, even though the very purpose of git clean is to delete files.


To learn how we protect privacy, please use this link (https://www.qma.com/gdpr.html) to read our Privacy Notice.

This email and any files transmitted with it are CONFIDENTIAL and are intended solely for the use of the individual(s) or entity to whom they are addressed. Any unauthorised copying, disclosure or distribution of the material within this email is strictly forbidden. Any views or opinions presented within this email are solely those of the author and do not necessarily represent those of QMA Wadhwani (QMAW) unless otherwise specifically stated. An electronic message is not binding on its sender. Any message referring to a binding agreement must be confirmed in writing and duly signed. If you have received this email in error, please notify the sender immediately and delete the original. Telephone, electronic and other communications and conversations with QMAW and/or its associated persons may be recorded and retained.

Please note that your personal information may be stored and processed in any country where we have facilities or in which we engage service providers. If you provide personal information to us by email or otherwise, you consent to the transfer of that information to countries outside of your country of residence and these countries may have different data protection rules than your country.

