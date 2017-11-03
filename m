Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E504D20450
	for <e@80x24.org>; Fri,  3 Nov 2017 16:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932788AbdKCQm5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 12:42:57 -0400
Received: from smtp.prolan-power.hu ([62.201.102.190]:45907 "EHLO
        smtp.prolan-power.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932321AbdKCQm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 12:42:56 -0400
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Nov 2017 12:42:56 EDT
Received: from [10.10.10.175] (unknown [10.10.10.175])
        by smtp.prolan-power.hu (Postfix) with ESMTPSA id 0E95E3E0
        for <git@vger.kernel.org>; Fri,  3 Nov 2017 17:33:25 +0100 (CET)
To:     git@vger.kernel.org
From:   =?UTF-8?B?UMOpdGVy?= <e2qb2a44f@prolan-power.hu>
Subject: git, isolation
Message-ID: <9f514a9b-858c-9f3a-e2d4-a45987a19b9a@prolan-power.hu>
Date:   Fri, 3 Nov 2017 17:33:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

If I do a "git commit", issue git operations, and at the end, issue a "rm <the_git_dir>", is there any guarantee that my 
filesystem will be "clean", i.e. not polluted or otherwise modified by some git command? Are the git operations 
restricted to the repo-directory (and possibly remote places, over network)? Do the git-directory behaves as it were 
chroot-ed or be a sandbox? (Yet another words: is the git-directory isolated from the rest of the local filesystem (and 
packaging system)?)


Péter



