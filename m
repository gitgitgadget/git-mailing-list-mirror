Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B36541F404
	for <e@80x24.org>; Mon, 16 Apr 2018 14:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755168AbeDPODs (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 10:03:48 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:48870 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbeDPODr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 10:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vBfCvHcDJhR7H4iFy5RTdB+eo7I5AQpIaP4zKg9XWtg=; b=OebPm99GOs/qTzqixlRz6wiutP
        Y46aWOMQpp2f0qe5JF9bGeB3cU3akj7ZmVEdVe8skyFMww6bVbRmacU27G+f177az/ShNPOAT0C7t
        Nt7XQvRseWg1udh0dsoctjQvFxolFi2BlPRWQ5hxWco3byOET92Z/ldLzf08H7I++w64b1h1WTX0E
        1MOD90ZhgV/sjVv62Frn+rWmz/6q1/3J22lcIQqUtRVkY2DQ2HgLdLed3ANpG0Q5TNK8+MN8jQfiG
        oAzft5FCJwp6/EZMUaa0952+duaX3QYmSXOdywMRWE12bXyO5nsWlP+JZV/v0fW8KRm2aEV4hkUF2
        Si4Lq4mg==;
Received: from [209.37.255.2] (port=52430 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1f84jK-0003C1-87
        for git@vger.kernel.org; Mon, 16 Apr 2018 10:03:46 -0400
Date:   Mon, 16 Apr 2018 07:03:36 -0700 (PDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: "proper" way to deactivate push for a remote?
Message-ID: <alpine.LFD.2.21.1804160659300.6118@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-1.0
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


 another feature i've seen for the very first time ... working with
kubernetes so i checked it out of github, and part of the instructions
for that is to make sure you don't accidentally try to push back to
the github remote, so the directions suggest:

$ git remote add upstream https://github.com/kubernetes/kubernetes.git
$ git remote set-url --push upstream no_push

  fair enough, i just assumed the word "no_push" was some magical
keyword in that context, but as i read it, all you need to do is put
*some* invalid URL value there, is that correct?

  and is that the accepted way to do that? what about just deleting
that line from .git/config? is that valid, or is there a different
recommendation for doing that? thanks.

rday
