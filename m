Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E17331F453
	for <e@80x24.org>; Mon, 24 Sep 2018 20:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeIYCy6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 22:54:58 -0400
Received: from box.datamaskinaggie.xyz ([45.55.255.105]:49052 "EHLO
        box.datamaskinaggie.xyz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbeIYCy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 22:54:58 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Sep 2018 22:54:58 EDT
Received: from authenticated-user (box.datamaskinaggie.xyz [45.55.255.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by box.datamaskinaggie.xyz (Postfix) with ESMTPSA id 926F4140145
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 16:43:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidwbrown.name;
        s=mail; t=1537821824;
        bh=YojbTxb3wV+cZp/+Ub80+SDZ9L0ieJNZTZg1bMklhi4=;
        h=Date:From:To:Subject:From;
        b=iok04NhQDZfiiHf4grAbTZZV5AqEMPATVHiEMbQSOotXpgSNOCQeONggOGx4t7Bd/
         tIdgCDKagwoAQ/CJCDF5UhzvkdYtNjsY/OFGgd+mSd5m+bzklyd9bTrkbmHadzxS6w
         5EA7+FkJ9eTTYv8CLy99GTRurYld/4cptpS+U+bS6YdWv4r09x2reHZu6oKIc71Gpg
         Eshzjk/VTj8+W9xOdTCRgzM8z1Q9x+6t2LGoCoV56xdvPUDnoy+KTWWs2xfT6p/+c/
         JxcxXJXj0YcqbMYnMqytKrPavaGSY13aFZvd5TW0wwD/aBvsi1CfPyD7tK6raVVjaA
         3YK1B4mMR2SWg==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Sep 2018 15:43:44 -0500
From:   David Brown <david@davidwbrown.name>
To:     git@vger.kernel.org
Subject: git clone works in ide but not git bash CLI
Message-ID: <2e7399d2595f403507ebbe748ee5f5ae@davidwbrown.name>
X-Sender: david@davidwbrown.name
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Howdy, I have a conundrum:

App: Spring Cloud Config Server
envvars: GIT_URL and SSH_KEY
IDE: Intellij 2018.2.4 Ultimate

When I use the IDE to assign the SSH_KEY value all is copacetic.

If I assign the envvar at the Git Bash CLI:

com.jcraft.jsch.JSchException: Auth fail

Any guesses?

Thanks and regards,

