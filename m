Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37C37208CD
	for <e@80x24.org>; Fri,  1 Sep 2017 05:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbdIAFoz (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 01:44:55 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:16079 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbdIAFoz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 01:44:55 -0400
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Sep 2017 01:44:54 EDT
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id DD5C93F613
        for <git@vger.kernel.org>; Fri,  1 Sep 2017 07:39:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QXJr0-Qpbimb for <git@vger.kernel.org>;
        Fri,  1 Sep 2017 07:39:44 +0200 (CEST)
Received: from [192.168.1.10] (h-225-27.A444.priv.bahnhof.se [155.4.225.27])
        (Authenticated sender: mb967074)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id DD67D3F612
        for <git@vger.kernel.org>; Fri,  1 Sep 2017 07:39:42 +0200 (CEST)
To:     git@vger.kernel.org
From:   Magnus Homann <magnus@homann.se>
Subject: submodule: --recurse-submodules vs. submodule.recurse=true
Message-ID: <eba8e727-25ef-b34b-cd2b-e92602709c9b@homann.se>
Date:   Fri, 1 Sep 2017 07:39:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm using git 2.14.1 on cygwin.

Using --recurse-submodules, I can do 'git pull' and the submodules both get fetched and merged
automatically. I was under the impression that setting submodule.recurse to true would have the same
affect, without needing to write --recurse-submodules every time. But the docs seems a bit vague,
and I don't understand the git code.

Is there a way to config git pull to automatcially do a "--recurse-submodules" ?

Thanks,
Magnus
