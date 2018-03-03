Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEF821F576
	for <e@80x24.org>; Sat,  3 Mar 2018 10:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeCCKBJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 05:01:09 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.28]:44876 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeCCKBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 05:01:09 -0500
X-Greylist: delayed 1011 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Mar 2018 05:01:08 EST
Received: from [91.113.179.170] (helo=[192.168.92.26])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1es3iA-0003fR-Q3
        for git@vger.kernel.org; Sat, 03 Mar 2018 10:44:14 +0100
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Subject: git stash push -u always warns "pathspec '...' did not match any
 files"
To:     git@vger.kernel.org
Message-ID: <349f9369-b799-4f7b-bda1-33bcbd7ea067@syntevo.com>
Date:   Sat, 3 Mar 2018 10:44:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reproducible in a test repository with following steps:

$ touch untracked
$ git stash push -u -- untracked
Saved working directory and index state WIP on master: 0096475 init
fatal: pathspec 'untracked' did not match any files
error: unrecognized input

The file is stashed correctly, though.

Tested with Git 2.16.2 on Linux and Windows.

-Marc

	
