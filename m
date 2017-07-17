Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DADB2082F
	for <e@80x24.org>; Mon, 17 Jul 2017 11:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbdGQLR0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 07:17:26 -0400
Received: from 5.itsy.de ([188.40.84.14]:36532 "EHLO 5.itsy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751318AbdGQLRY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 07:17:24 -0400
Received: from [192.168.0.13] (84-72-0-73.dclient.hispeed.ch [84.72.0.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 5.itsy.de (Postfix) with ESMTPSA id BE6DF6463C
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 13:17:22 +0200 (CEST)
To:     Git Mailing List <git@vger.kernel.org>
From:   Joachim Durchholz <jo@durchholz.org>
Subject: Detect invalid submodule names from script?
Message-ID: <41004589-4a98-2084-b542-51b7458f607b@durchholz.org>
Date:   Mon, 17 Jul 2017 13:17:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all

I'm hacking some script that calls into git, and I need to detect 
whether a repository was configured with a submodule name that will work 
on "git submodule init" and friends.
I *can* run a git init and see whether it works, but I need to be 100% 
sure that the error was due to an invalid submodule name and not 
something else. Bonus points for every version of git for which it works.

Any suggestions?
Thanks!

Regards,
Jo
