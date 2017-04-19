Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DEAR_SOMETHING,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 960861FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 20:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939571AbdDSUrp (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 16:47:45 -0400
Received: from mout1.freenet.de ([195.4.92.91]:33130 "EHLO mout1.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S939568AbdDSUrp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 16:47:45 -0400
Received: from [195.4.92.142] (helo=mjail2.freenet.de)
        by mout1.freenet.de with esmtpa (ID liebundartig@freenet.de) (port 25) (Exim 4.85 #1)
        id 1d0wVr-0006iu-Hb
        for git@vger.kernel.org; Wed, 19 Apr 2017 22:47:43 +0200
Received: from localhost ([::1]:50065 helo=mjail2.freenet.de)
        by mjail2.freenet.de with esmtpa (ID liebundartig@freenet.de) (Exim 4.85 #1)
        id 1d0wVr-0002xd-Dl
        for git@vger.kernel.org; Wed, 19 Apr 2017 22:47:43 +0200
Received: from mx17.freenet.de ([195.4.92.27]:54569)
        by mjail2.freenet.de with esmtpa (ID liebundartig@freenet.de) (Exim 4.85 #1)
        id 1d0wT8-0000nt-Hw
        for git@vger.kernel.org; Wed, 19 Apr 2017 22:44:54 +0200
Received: from p20030045447e6e3990f8c675965ced16.dip0.t-ipconnect.de ([2003:45:447e:6e39:90f8:c675:965c:ed16]:46504)
        by mx17.freenet.de with esmtpsa (ID liebundartig@freenet.de) (TLSv1.2:DHE-RSA-AES128-SHA:128) (port 465) (Exim 4.85 #1)
        id 1d0wT8-0004jD-CO
        for git@vger.kernel.org; Wed, 19 Apr 2017 22:44:54 +0200
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Genz?= <liebundartig@freenet.de>
Subject: minor typos in documentation
Message-ID: <ea2780fd-8d63-6060-fb17-df5720bbc3de@freenet.de>
Date:   Wed, 19 Apr 2017 22:44:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Originated-At: 2003:45:447e:6e39:90f8:c675:965c:ed16!46504
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear sir or madam,

At:
https://git-scm.com/docs/git-commit#git-commit---long

you can read:
When doing a dry-run, give the output in a the long-format.

 From my point of view it should read:
When doing a dry-run, give the output in the long-format.



Furthermore in the file:
./Documentation/gitremote-helpers.txt

you can read:
As the a push option

It should be changed to:
As the push option



Additionally in the file:
./ci/run-windows-build.sh

please change:
# Script to trigger the a Git for Windows build and test run.

to:
# Script to trigger the Git for Windows build and test run.



And in the file:
./diff.c

change:
  *   1. collect a the minus/plus lines of a diff hunk, divided into

to:
  *   1. collect the minus/plus lines of a diff hunk, divided into

Thanks a lot in advance for fixing these minor typos.
-- 
Kind regards,
René
