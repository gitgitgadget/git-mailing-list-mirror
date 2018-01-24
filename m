Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50BEC1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 16:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934271AbeAXQ3u (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 11:29:50 -0500
Received: from smtpq2.mnd.mail.iss.as9143.net ([212.54.34.165]:42414 "EHLO
        smtpq2.mnd.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934157AbeAXQ3t (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Jan 2018 11:29:49 -0500
X-Greylist: delayed 1091 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Jan 2018 11:29:49 EST
Received: from [212.54.34.120] (helo=smtp12.mnd.mail.iss.as9143.net)
        by smtpq2.mnd.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <git@jessiehernandez.com>)
        id 1eeNeC-00015w-C5
        for git@vger.kernel.org; Wed, 24 Jan 2018 17:11:36 +0100
Received: from 53544873.cm-6-5b.dynamic.ziggo.nl ([83.84.72.115] helo=jessiehernandez.com)
        by smtp12.mnd.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <git@jessiehernandez.com>)
        id 1eeNeC-0000uo-Af
        for git@vger.kernel.org; Wed, 24 Jan 2018 17:11:36 +0100
Received: by jessiehernandez.com (Postfix, from userid 112)
        id 63DBA2142B; Wed, 24 Jan 2018 17:11:34 +0100 (CET)
Received: from mail.jessiehernandez.com (localhost [127.0.0.1])
        by jessiehernandez.com (Postfix) with ESMTP id 81AF1203CF
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 17:11:30 +0100 (CET)
Received: from 185.46.212.85
        (SquirrelMail authenticated user jessie)
        by mail.jessiehernandez.com with HTTP;
        Wed, 24 Jan 2018 17:11:30 +0100
Message-ID: <54fd6a226955dc427bb25d5be37b4b0a.squirrel@mail.jessiehernandez.com>
Date:   Wed, 24 Jan 2018 17:11:30 +0100
Subject: Creating sparse checkout in a new linked git worktree
From:   "Jessie Hernandez" <git@jessiehernandez.com>
To:     git@vger.kernel.org
Reply-To: git@jessiehernandez.com
User-Agent: SquirrelMail/1.4.23 [SVN]
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-SourceIP: 83.84.72.115
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=T4SiscCQ c=1 sm=1 tr=0 a=n+ob1Bm1t1G9OO4azozuvA==:17 a=8nJEP1OIZ-IA:10 a=RgaUWeydRksA:10 a=SqOO0BFNNWZpJ7Fq0i0A:9 a=wPNLvfGTeEIA:10
 none
X-Ziggo-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

I am trying to get a sparse checkout in a linked worktree but cannot get
it working. I have tried the following

* git worktree add /some/new/path/new-branch --no-checkout
* git config core.sparseCheckout true
* <add the directory I would like to checkout out to
$GIT_DIR/info/sparse-checkout>
* cd  /some/new/path/new-branch
* git read-tree -mu sparse-checkout

But I still end up with a fully populated worktree.

Is there something I am missing or doing wrong?

thank you for any response.

jessie


