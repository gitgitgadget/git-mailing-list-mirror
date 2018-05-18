Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BED321F42D
	for <e@80x24.org>; Fri, 18 May 2018 09:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeERJi6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 05:38:58 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:43906 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeERJi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 05:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IrFXTcszp5McXavQ0qDdPiO1n3nIUmNrpqWIfoyXlhc=; b=MJXvpy27Jvwra5wkiIMi1LHfBB
        RLjrviaGIUmMe4mdhRViUk+kD4XJrstDZy66gl6lPlrPAbD/qvF2vb4zwWCPBvCgKbHmiK4jfm3XF
        teaeCWFnZfq+Cr885vwY8T+gQArbWHtCZdCqZNYdohKbrhhGfH6/x2bPyQQF5SbyVBIItuzVHE8rG
        9ymt0C8XGgtiLJjZl8k7mqQEijjQ6bWsv0Um5UcnBxgxkWMuts9TgX4rgXkgQBdwx6e/0QpqKtrch
        16ZlWjQ4p6WHXKjzq0oYKtT7oNN9goBRIxfOqzVn32VRkNb70ohndItTekXtiNxfwvc+Qvkdf9i2H
        6B19vZWQ==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:43198 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fJbqh-00DzP6-F9
        for git@vger.kernel.org; Fri, 18 May 2018 05:38:56 -0400
Date:   Fri, 18 May 2018 05:37:28 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: error(?) in "man git-stash" regarding "--keep-index"
Message-ID: <alpine.LFD.2.21.1805180534170.6786@localhost.localdomain>
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


  toward the bottom of "man git-stash", one reads part of an example:

  # ... hack hack hack ...
  $ git add --patch foo            # add just first part to the index
  $ git stash push --keep-index    # save all other changes to the stash
                                              ^^^^^ ???

i thought that, even if "--keep-index" left staged changes in the
index, it still included those staged changes in the stash. that's not
the impression one gets from the above.

rday
