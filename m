X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 20 Dec 2006 15:51:46 -0800
Message-ID: <20061220235146.GA13647@localdomain>
References: <7vejqu8dqv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 23:52:03 +0000 (UTC)
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vejqu8dqv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34986>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxBE3-0002YM-TH for gcvg-git@gmane.org; Thu, 21 Dec
 2006 00:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161026AbWLTXvu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 18:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbWLTXvu
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 18:51:50 -0500
Received: from hand.yhbt.net ([66.150.188.102]:35372 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1161030AbWLTXvt
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 18:51:49 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 5B49C7DC02A; Wed, 20 Dec 2006 15:51:47 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 20 Dec 2006
 15:51:47 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> * ew/svn-pm (Fri Dec 15 23:58:08 2006 -0800) 3 commits
>  + git-svn: rename 'commit' command to 'set-tree'
>  + git-svn: remove support for the svn command-line client
>  + git-svn: convert to using Git.pm
> 
> I've heard a few comments that renaming 'commit' to 'set-tree'
> are received favorably by users, so this might be ready to be
> merged.  Eric's call, but I am not in the rush.

Yes, please merge these for 1.5.0.  I have more on the way that depend
on these patches.  The coming changes to git-svn should make life easier
for Sam's svm/svk patches, too.

-- 
