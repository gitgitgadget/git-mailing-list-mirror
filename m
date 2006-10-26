X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 06:10:38 -0400
Message-ID: <20061026101038.GA13310@coredump.intra.peff.net>
References: <45357CC3.4040507@utoronto.ca> <20061021130111.GL75501@over-yonder.net> <453F2FF8.2080903@op5.se> <200610251146.06116.jnareb@gmail.com> <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com> <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com> <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 10:10:57 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30177>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd2CE-00016m-NO for gcvg-git@gmane.org; Thu, 26 Oct
 2006 12:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423105AbWJZKKn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 06:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422985AbWJZKKn
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 06:10:43 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:62396
 "HELO peff.net") by vger.kernel.org with SMTP id S1423105AbWJZKKn (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 06:10:43 -0400
Received: (qmail 7802 invoked from network); 26 Oct 2006 06:09:44 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 26 Oct 2006 06:09:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Oct
 2006 06:10:38 -0400
To: James Henstridge <james@jamesh.id.au>
Sender: git-owner@vger.kernel.org

On Thu, Oct 26, 2006 at 05:57:20PM +0800, James Henstridge wrote:

> >If you two have the same commit that is a guarantee that you two
> >have identical trees.  The reverse is not true as logic 101
> >would teach ;-).
> 
> That was the point I was trying to make.  Carl asserted that in git
> you could tell if you had the same tree as someone else based on
> revision IDs, which doesn't seem to be the case all the time.

If you have the same revision (commit IDs), you have the same tree (at
the same time, by the same committer, etc).

If you have a different revision (commit), you may or may not have the
same tree. You can then check the tree id, which will either be the same
(you have the same tree) or differ (you don't).

Thus, in the converse, if you have the same tree, you _will_ have the
same tree id. You may or may not have the same commit id.

