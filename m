Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DEAR_SOMETHING,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6762620A04
	for <e@80x24.org>; Mon, 17 Apr 2017 15:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbdDQPMP (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 11:12:15 -0400
Received: from mout2.freenet.de ([195.4.92.92]:47842 "EHLO mout2.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753427AbdDQPMO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 11:12:14 -0400
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Apr 2017 11:12:14 EDT
Received: from [195.4.92.142] (helo=mjail2.freenet.de)
        by mout2.freenet.de with esmtpa (ID liebundartig@freenet.de) (port 25) (Exim 4.85 #1)
        id 1d08Ci-0001hn-2d
        for git@vger.kernel.org; Mon, 17 Apr 2017 17:04:36 +0200
Received: from localhost ([::1]:57867 helo=mjail2.freenet.de)
        by mjail2.freenet.de with esmtpa (ID liebundartig@freenet.de) (Exim 4.85 #1)
        id 1d08Ch-0007sI-Us
        for git@vger.kernel.org; Mon, 17 Apr 2017 17:04:36 +0200
Received: from mx6.freenet.de ([195.4.92.16]:48899)
        by mjail2.freenet.de with esmtpa (ID liebundartig@freenet.de) (Exim 4.85 #1)
        id 1d08Ae-0005Yp-2D
        for git@vger.kernel.org; Mon, 17 Apr 2017 17:02:28 +0200
Received: from p20030045447e6e03916ae2ce22ebfc83.dip0.t-ipconnect.de ([2003:45:447e:6e03:916a:e2ce:22eb:fc83]:49992)
        by mx6.freenet.de with esmtpsa (ID liebundartig@freenet.de) (TLSv1.2:DHE-RSA-AES128-SHA:128) (port 465) (Exim 4.85 #1)
        id 1d08Ad-0002w1-Tr
        for git@vger.kernel.org; Mon, 17 Apr 2017 17:02:28 +0200
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Genz?= <liebundartig@freenet.de>
Subject: minor typo in documentation - surplus 'a'
Message-ID: <cdf721fe-6cfe-ae43-001e-c9ffbdb4a9de@freenet.de>
Date:   Mon, 17 Apr 2017 17:02:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Originated-At: 2003:45:447e:6e03:916a:e2ce:22eb:fc83!49992
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear sir or madam,

I noticed a minor typo in `man 1 git-commit`.
There are two consecutive 'a'. At:
https://github.com/git/git/blob/maint/Documentation/git-commit.txt#L97
you can read:
---8<---
--reset-author::
	When used with -C/-c/--amend options, or when committing after a
a conflicting ...
---8<---

Please, remove one 'a'.



I searched the code for another occurrence with:
git-maint$ for F in $(find . -type f); do grep -o "a_[[:space:]]a" <(paste -sd_ $F) | tr -d '_' ; done
a	a
a	a

One is in Documentation.
The other is from a test file, no change needed there:
https://github.com/git/git/blob/maint/t/t3904-stash-patch.sh#L94


Thank you in advance.
Have fun.
-- 
Kind regards,
René
