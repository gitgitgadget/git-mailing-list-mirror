X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC/PATCH 2/2] git-svn: rename 'commit' command to 'set-tree'
Date: Sat, 16 Dec 2006 13:44:56 -0800
Message-ID: <20061216214455.GC26800@hand.yhbt.net>
References: <m28xh8amxa.fsf@ziti.local> <11662558902535-git-send-email-normalperson@yhbt.net> <7vbqm4ezv8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 21:45:08 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vbqm4ezv8.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34645>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvhL6-0000Jn-40 for gcvg-git@gmane.org; Sat, 16 Dec
 2006 22:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753820AbWLPVo7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 16:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbWLPVo7
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 16:44:59 -0500
Received: from hand.yhbt.net ([66.150.188.102]:59175 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1753820AbWLPVo6
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 16:44:58 -0500
Received: by hand.yhbt.net (Postfix, from userid 500) id E62542DC034; Sat, 16
 Dec 2006 13:44:56 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > 'set-tree' probably accurately describes what the command
> > formerly known as 'commit' does.
> >
> > I'm not entirely sure that 'dcommit' should be renamed to 'commit'
> > just yet...  Perhaps 'push' or 'push-changes'?
> 
> I think Pasky did such a three-way rename to avoid breaking
> people's fingers.  I thought it was a reasonable transition
> strategy, but some people might say its only effect was to break
> people's fingers not just once but twice, so Pasky himself
> and/or Cogito users may have some input on this.

Good point about breaking fingers twice.  I don't think 'commit'
accurately describes any current operation that git-svn does; so the
command can probably go away safely.  I'm guessing that something along
the lines of 'push' is probably a better way to describe 'dcommit'.

> We are talking about major UI change between 1.4 series and
> v1.5.0 on the core Porcelain-ish side, so if you feel confident
> that things would settle down in a month or so in the git-svn
> front, it may be a good idea to roll sweeping changes into the
> same timeframe.

I plan on supporting remotes in the config file; and adding support for
svn in git-fetch (wrapping git-svn multi-fetch, which should get faster
by then)

-- 
