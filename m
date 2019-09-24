Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 161E41F463
	for <e@80x24.org>; Tue, 24 Sep 2019 22:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394310AbfIXWF1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 18:05:27 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:30942 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387542AbfIXWF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 18:05:27 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iCsw1-0003Ih-7S; Tue, 24 Sep 2019 23:05:25 +0100
Subject: Fwd: git-gui: failure to distinguish 3-way common ancestors in hunk
 markers (#2340)
References: <b2f412e2-d95f-0f73-5341-73c19ee2c6f7@iee.email>
To:     Git List <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>
From:   Philip Oakley <philipoakley@iee.email>
X-Forwarded-Message-Id: <b2f412e2-d95f-0f73-5341-73c19ee2c6f7@iee.email>
Message-ID: <7baf2b10-56fa-1cb4-0571-cb3c6be8feb3@iee.email>
Date:   Tue, 24 Sep 2019 23:05:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b2f412e2-d95f-0f73-5341-73c19ee2c6f7@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi list,
cc Pratyush,

[resend without attached png file]

While rebasing an old series, I had a 3-way merge fall back that didn't 
show the `||||||| merged common ancestors` very well in git-gui.

That is, the conflict markers, and common ancestor lines, are treated as 
being part of the current HEAD hunk, rather than being separated.

I opened a Git for Windows issue 
https://github.com/git-for-windows/git/issues/2340 which has the 
screenshot of the git-gui markers.

I've not had any chance to look at the underlying code, but thought it 
worth reporting. I guess the issue has been there a while.

Philip



