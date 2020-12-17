Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76465C2BB9A
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 18:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C19B2395A
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 18:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731737AbgLQSN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 13:13:58 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:42678 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgLQSIa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 13:08:30 -0500
Received: from client3368.fritz.box (i5C744572.versanet.de [92.116.69.114])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 832CC3C092E;
        Thu, 17 Dec 2020 19:07:48 +0100 (CET)
To:     Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org
From:   Stefan Haller <stefan@haller-berlin.de>
Subject: git-gui patches
Message-ID: <b76cf18c-91ff-342b-af26-7b2a67bd6d8a@haller-berlin.de>
Date:   Thu, 17 Dec 2020 19:07:48 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

I was wondering what your plans are for the git-gui patches that have
been floating around in the past few weeks.

The most important one for me is this one:

  <https://lore.kernel.org/git/
   20201122133233.7077-1 serg.partizan@gmail.com/>

because it fixes a regression that was introduced in 2.29. I was hoping
that this could be included in 2.30 to fix the regression (but maybe
that's too late already).

Related (and actually on top of that one) is

  <https://lore.kernel.org/git/
   20201124212333.80040-1-stefan@haller-berlin.de/>

which I hope should also be uncontroversial. I think this is a
considerable improvement, and would be happy to see this included.


And then we have

  <https://lore.kernel.org/git/
   20201122194537.41870-2-stefan@haller-berlin.de/>

which you said you would apply, but I don't see this in your tree yet.
Just wanted to make sure that this doesn't fall through the cracks.

Thanks,
Stefan
