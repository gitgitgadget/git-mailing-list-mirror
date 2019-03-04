Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C487D20248
	for <e@80x24.org>; Mon,  4 Mar 2019 20:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfCDUlU (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 15:41:20 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:57984 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCDUlU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 15:41:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gQ1WfrH8dX5wxT4dQHmV+xM5Nn8Zk7aZ+tERE2o5lq8=; b=T2cyPXR8evVs+ajnDlSYroNNZT
        SKec4W/7gMMxeZu+1gpJAy3MVoHWZag9GmI+R6RuR7imlK97I4pB9sstbSkpaWWCnyPa5eSoOjZcj
        lV5NZf6zF8niyJE0GW75/MAt2kZoFMR8lVJJYLzJ5qOiUkA8ZczKCjR3MKWVNBGDj6sil16h3vTAn
        nuz63QhcPft2pyuPvKoblVcuRjdv2C5ZQdURMpe04NRQP+cOF5lbJasO8FzoJp5Fn6unxH5E0YmjA
        rx8CY+EL8DA0uL7k0GxBzaoNX71GXlFQl/Hc72bjtZueD74zot6Bj0u2kc2jtRS/6runnWdSlAqg9
        feEGvtQA==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:40430 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h0uOj-00E5o6-Gx
        for git@vger.kernel.org; Mon, 04 Mar 2019 15:41:18 -0500
Date:   Mon, 4 Mar 2019 15:41:16 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: is "git rebase ... [branch]" equivalent to first "git checkout
 [branch]"?
Message-ID: <alpine.LFD.2.21.1903041536460.12447@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  i *think* i know the answer to this based on man page and reading
the code, but i just want to verify that i'm not missing any subtlety.

  according to "man git-rebase":

   git rebase [-i | --interactive] [<options>] [--exec <cmd>]
       [--onto <newbase>]
       [<upstream> [<branch>]]

and:

  "If <branch> is specified, git rebase will perform an automatic git
checkout <branch> before doing anything else. Otherwise it remains on
the current branch."

  is it *absolutely* equivalent to either specify the final "[branch]"
argument on "git rebase", or to just "git checkout branch" first
before running the rebase, then leaving off that final argument?

  everything i've seen suggests those two things are identical, but
i've been fooled before.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

