X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 1/2] Allow users to require source branch on git-checkout -b.
Date: Fri, 8 Dec 2006 10:39:31 -0500
Message-ID: <20061208153931.GA14378@fieldses.org>
References: <20061207100152.GA12966@spearce.org> <7vlkljsd1k.fsf@assigned-by-dhcp.cox.net> <20061207195715.GG12143@spearce.org> <7v64cns8nf.fsf@assigned-by-dhcp.cox.net> <20061207214053.GC31035@fieldses.org> <20061207215914.GC12502@spearce.org> <20061208044516.GC5939@fieldses.org> <20061208055938.GB13999@spearce.org> <7vac1yoq3r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 15:39:48 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vac1yoq3r.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33701>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gshp5-0007T9-M9 for gcvg-git@gmane.org; Fri, 08 Dec
 2006 16:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425575AbWLHPjh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 10:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425579AbWLHPjg
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 10:39:36 -0500
Received: from mail.fieldses.org ([66.93.2.214]:56669 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1425575AbWLHPjg (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 10:39:36 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1Gshoy-0003sg-0E; Fri, 08 Dec 2006
 10:39:32 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Thu, Dec 07, 2006 at 10:31:52PM -0800, Junio C Hamano wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> >> But my main complaint is just that I wouldn't want to see the behavior
> >> of defaulting to HEAD--behavior which is simple, easy to explain, and
> >> shared by most other git commands--by something significantly more
> >> complicated.  That's more a complaint about Junio's suggestion than
> >> yours, though.
> >
> > True, defaulting to HEAD is something that is done almost everywhere.
> > Changing it for `git checkout -b` may surprise a lot of people,
> > almost as much as --index vs. --cached.
> 
> I did not mean to change the default to something other than
> HEAD depending on the configuration.

Right, I understand that behavior in existing repositories is not
changed...

> > (3) otherwise, it barfs if you do not give an explicit
> >     branch-point.
> 
> ... but a newly created repositories would have an
> allowbranchbydefault entry on "master" (and only on "master"),
> which means new people would be prevented from making mistakes
> when on a non-master branch 'foo':

... my concern is the default behavior on newly created repositories,
which (unless I've misunderstood) would become more complicated.

> But I do not deeply care about this.

OK.  Me neither, to be honest.

