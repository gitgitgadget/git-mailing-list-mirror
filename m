Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D12C1F42D
	for <e@80x24.org>; Mon, 21 May 2018 11:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbeEULUE (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 07:20:04 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:37532 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeEULUD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 07:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hbVYKpqXulusNyHzBJDHZ8WuL52Jpc8NLUa6elNCxDA=; b=CJG+dM+PbGkXJagl4oXOYJCAt8
        GKmdNV0TZpatQwQcdbEUTbwFwlYCQxI/5QUVC8BfSlRfGOJ9r4h75CoNx99PP/eU4xscaGAyTrS5F
        /eiyhH9kbILjdnMj9vLsZrDEUFYmbJuVq8HXi2y+nQIVRMXhHVAeBiK1y0kiQIFsWDfxC07ElVZQD
        Whu/49cnRuXmtd8Mj0zM5mh7gDFg1vfLYGVksA70me27Pq7ECb+OOHpArlWlHOjAbeVO0rbDXEBSj
        kHn1OgZsmvaHIjMhAE+K3weBdDDe9BfHVAGccth2wnFIXVSj16VgvuLQegP+HZjj9iiZSDgJPxX2n
        Wwf+p+hA==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:43116 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fKirB-00F3hf-8o
        for git@vger.kernel.org; Mon, 21 May 2018 07:20:02 -0400
Date:   Mon, 21 May 2018 07:18:30 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: which files are "known to git"?
Message-ID: <alpine.LFD.2.21.1805210717040.9926@localhost.localdomain>
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


  updating my git courseware and, since some man pages refer to files
"known to git", i just want to make sure i understand precisely which
files those are. AIUI, they would include:

  * tracked files
  * ignored files
  * new files which have been staged but not yet committed

is that it? are there others?

rday
