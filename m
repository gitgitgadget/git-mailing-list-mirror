Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6904120248
	for <e@80x24.org>; Sat, 16 Mar 2019 12:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfCPMW1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 08:22:27 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:47120 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfCPMW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 08:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gNTrpXhcHwVPzus11LjYvuMlo0cJ1P5D81cAW+f7aAc=; b=g46Zot6HU4ePvaaz6FVJff7Drn
        2+O4q8HrgJ4AWqKyi4Cb9kLWJHLbR8VOOjPWlCUaQLxFyA6JGJQrm325emqBzr4lXwWu/e4KFERlx
        /lNzzOv6IUmomNnETQhSxUpPl3WZR/pZ5nkuTCQZv4xHXaOzPUFHQiA6qG2M4H/rUS8ZV0x3CnbxD
        8j6gzkaFEAxySnBBomzwUg2KicD9gKfcxCEnpG7gKp89CFrMUnMdu/4kPB96tNoZJpKRajcBfQMYo
        3tbU0xL6ZQKaUOiRA5DKGG62k2Lyg4LRkAtGc5shbW22E8w0VYvZJWRHDIUvPKOTr9yJEEKIbq6wh
        JSVv+mpQ==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:43546 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h58KX-00AwZj-5x
        for git@vger.kernel.org; Sat, 16 Mar 2019 08:22:25 -0400
Date:   Sat, 16 Mar 2019 08:22:24 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: "man gitattributes" doesn't explain comma-separated attribute
 values
Message-ID: <alpine.LFD.2.21.1903160816410.10724@localhost.localdomain>
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


  more nitpicking, but i'm working my way through the intricacies of
attributes and putting together some (allegedly) simple examples for a
class i'm giving on monday, and i noted a couple possible shortcomings
in "man gitattributes".

  as a working example, i looked at the top-level .gitattributes file
in the git source code itself, which opens with:

  * whitespace=!indent,trail,space
  *.[ch] whitespace=indent,trail,space diff=cpp
  *.sh whitespace=indent,trail,space eol=lf
  ... snip ...

first observation is that i see nothing in the man page that explains
the notion of a comma-separated list of attribute values. maybe i
missed it or maybe it's supposed to be intuitively obvious, but
there's nothing i can see that mentions the possibility.

  related to that is that there is no explanation as to how to
interpret:

  * whitespace=!indent,trail,space

does the "!" apply to "indent" or to the entire list? the man page
doesn't say.

  just being pedantic again.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
