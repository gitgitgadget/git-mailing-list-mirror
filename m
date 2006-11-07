X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Did anyone have trouble learning the idea of local vs. remote branches?
Date: Tue, 7 Nov 2006 12:24:50 -0500
Message-ID: <20061107172450.GA26591@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 7 Nov 2006 17:25:11 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31079>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhUh0-0002cR-1e for gcvg-git@gmane.org; Tue, 07 Nov
 2006 18:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965574AbWKGRYz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 12:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965587AbWKGRYz
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 12:24:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38576 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S965574AbWKGRYy
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 12:24:54 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GhUgp-0005d2-0B for git@vger.kernel.org; Tue, 07 Nov 2006 12:24:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 BC5A120E487; Tue,  7 Nov 2006 12:24:50 -0500 (EST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Today I was talking with someone that I collaborate with through
Git and they still seemed to not get the idea that all branches
in their repository are local, and that at least a 'git fetch'
is needed to update the local tracking branches to the version
in the central repository that we collaborate through.  And this
isn't the first time we've had such discussions.

It dawned on me that this person still hasn't grasped the idea
behind fetch.  A few other users that I know also have commented on
how difficult fetch is to learn.

Most seemed to think that fetch would update their working directory,
or their current branch, as there is no other way to "download
changes from origin".  They also seem to expect their local tracking
branch to automatically update, especially when invoking
`git checkout -b foo tracking-branch`.


Clearly there is a gap in communicating these ideas in a way that
they can be understood by users.  Of course in at least one case
the users just isn't reading any Git documentation and plows ahead
as though it were CVS ('cause everything's "just like CVS") *sigh*.

-- 
