Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80BBC1F42D
	for <e@80x24.org>; Thu, 24 May 2018 13:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969523AbeEXNjo (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 09:39:44 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:34446 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965530AbeEXNjo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 09:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tt9O3vlVqFi5GgGeV+uPhGG31xZltz+dY5jLQfBJOCU=; b=FsW7abswjYlDa+WBdxRA9T0lF1
        driwAaJeiBC68X0ExIw4yenZw/0qNgMeNc6sxaRO+LXxLQa9jT+H/zKM4UHLssP5y8p8mNT+onV+R
        O40IxgbhvAHIsl5RSKvNQ9q7sPhPY9Dt6/YECENKlRYQV2KkMIG3+dNdOppVlpSdeyly4ZDlhw1gb
        gesIAAx87jfWJqmw0v4S+x2dpNkUEQX9EOS0LnmPlr7vp6AmSEykq0XzBGp/01n+YqwEuQL6qAE1X
        Ho1p8xOX9WSpZqJJgG0r0Kp8LST1eQCTouYjUSlDOLSgJyvdl7yZMaBavkhnfO4aAk++BkpiTEeRg
        4jpnfzhA==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:64993 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fLqSy-00Guzc-7U
        for git@vger.kernel.org; Thu, 24 May 2018 09:39:42 -0400
Date:   Thu, 24 May 2018 09:37:48 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: why do "git log -h" and "git show -h" print the same thing?
Message-ID: <alpine.LFD.2.21.1805240934010.12018@localhost.localdomain>
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


  maybe this is deliberate, but it's confusing that, with git 2.17.0,
the output of both "git log -h" and "git show -h" is exactly the same:

$ git log -h
usage: git log [<options>] [<revision-range>] [[--] <path>...]
   or: git show [<options>] <object>...

    -q, --quiet           suppress diff output
    --source              show source
    --use-mailmap         Use mail map file
    --decorate-refs <pattern>
                          only decorate refs that match <pattern>
    --decorate-refs-exclude <pattern>
                          do not decorate refs that match <pattern>
    --decorate[=...]      decorate options
    -L <n,m:file>         Process line range n,m in file, counting from 1
$

is that what's *supposed* to happen?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
