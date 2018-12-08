Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AA0E20A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 16:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeLHQFv (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 11:05:51 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:58416 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeLHQFu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 11:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=68Q/VoLDuxdd4YxEhhQ8Daq1569uui/eMNC/UjB3ryc=; b=d3xb/8O2EriGrE+sPD5YK5PGQA
        ANJSyPerYV2Uu+GtAXu/QirGmcXFJBwz0/Kkq9Y9W61SwYfSOTLJciudiodpRzCe2jAwicczw+hDR
        ceB0QHHrZRmzaMJVYSactnGhxwWTyOfsA93Um58i+w7OzCMdia/i92bWukfG6TK3uQIHsaPRr6jWt
        mgQVdRmHTZYW7GYnTOC1gb87b+ljIjTuF75/lDRJB+nyPzLS8vF/S6VeuTQGPNANKpko36pMsAQd0
        a6v7b+3rEBu+xGshM7neYuPLdly3UvRmuwTQ4rfLglme+P2vNPUT63RrZeoWygd3yuWiNNDBzEepS
        iRxHEp9A==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:49366 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1gVf6y-0007vO-Ty
        for git@vger.kernel.org; Sat, 08 Dec 2018 11:05:49 -0500
Date:   Sat, 8 Dec 2018 11:05:46 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: why doesn't "git reset" mention optional pathspec?
Message-ID: <alpine.LFD.2.21.1812081103500.29142@localhost.localdomain>
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


  from "man git-reset":

SYNOPSIS
  git reset [-q] [<tree-ish>] [--] <paths>...
  git reset (--patch | -p) [<tree-ish>] [--] [<paths>...]
  git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]

oddly, the third form says nothing about possible "<paths>", even
though i'm pretty sure they're valid in that third case (at least for
"--mixed"). thoughts? is that just an oversight in the man page?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
