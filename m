Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AD79201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 15:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758389AbdKOPeq convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 15 Nov 2017 10:34:46 -0500
Received: from mailout.ip-plus.net ([164.128.36.32]:48358 "EHLO
        mailout.ip-plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758410AbdKOPep (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 10:34:45 -0500
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Nov 2017 10:34:45 EST
Received: from mailhost1.helsana.ch (unknown [193.73.106.136])
        by mailout.ip-plus.net (Postfix) with ESMTP id D8D2920639
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 16:27:18 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.44,399,1505772000"; 
   d="scan'208";a="47265899"
Received: from unknown (HELO TrustMail) ([192.168.130.113])
  by mailhost1.helsana.ch with SMTP; 15 Nov 2017 16:27:18 +0100
X-FilterName: OutgointMailToTrustmailLB
X-IronPort-AV: E=Sophos;i="5.44,399,1505772000"; 
   d="scan'208";a="23515988"
From:   Ninivaggi Mattia <mattia.ninivaggi@helsana.ch>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [Feature- Request] Option to commit after checking out branch command
 is made
Thread-Topic: [Feature- Request] Option to commit after checking out branch
 command is made
Thread-Index: AdNeJI/H/NuxvwNOQkuzmHO0ARwB7g==
Date:   Wed, 15 Nov 2017 15:27:18 +0000
Message-ID: <670f44c0ac554f2faec5a6112376b015@MSSMAILP06.ads.hel.kko.ch>
Accept-Language: de-CH, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.30.238.29]
x-c2processedorg: cfdb09a0-13e2-4260-a47c-f8e494924444
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey guys

Sometimes I tend to forget to commit changes before I checkout another branch and the following scenario happens (via cli on windows [with git bash]):

1. I checkout a branch, without having commited first
    > git checkout dev
2. I get this error message:
    > error: Your local changes to the following files would be overwritten by checkout:
    > // List of files
    > // ..
    > //
    > Please commit your changes or stash them before you switch branches.

But I would rather prefer a scenario like this:

1. I checkout a branch, without having commited first
    > git checkout dev
2. I get a message like this:
    > Your local changes to the following files would be overwritten by checkout:
    > // List of files
    > // ..
    > //
    > Would you want to commit first? (y/n))

IF y --> prompt for commit message and commit automatically
IF n --> display error message: "Please commit your changes or stash them before you switch branches"

This would be a faster/ more productive way to handle this error.

I think it wont be a big challenge, you just should put a message in the cli-tool when this error occurs and call the commit functionality if "y" is pressed. If you'd like I'll even consider doing it myself. If you have some documentation or some tipps on where to look for it.

Cheers

Ninivaggi Mattia
