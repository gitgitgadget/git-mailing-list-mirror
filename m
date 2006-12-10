X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation/git-commit: rewrite to make it more end-user friendly.
Date: Sun, 10 Dec 2006 17:41:45 -0500
Message-ID: <20061210224145.GA3748@fieldses.org>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612082141260.2630@xanadu.home> <7vd56tei20.fsf_-_@assigned-by-dhcp.cox.net> <200612100130.48812.Josef.Weidendorfer@gmx.de> <20061210210057.GB23387@fieldses.org> <Pine.LNX.4.64.0612101704390.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 22:42:01 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612101704390.2630@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33947>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtXMq-0003hQ-Mz for gcvg-git@gmane.org; Sun, 10 Dec
 2006 23:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759125AbWLJWlv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 17:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760794AbWLJWlv
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 17:41:51 -0500
Received: from mail.fieldses.org ([66.93.2.214]:54625 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1759125AbWLJWlu (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 17:41:50 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GtXMf-00029S-CK; Sun, 10 Dec 2006
 17:41:45 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

On Sun, Dec 10, 2006 at 05:07:40PM -0500, Nicolas Pitre wrote:
> On Sun, 10 Dec 2006, J. Bruce Fields wrote:
> 
> > Or maybe: "by using gitlink:git-add[1] to add new content (of either new
> > or newly modified files) to the next commit."
> > 
> > Man pages are reference documentation, so I figure it's OK to sacrifice
> > a little newbie-friendliness for accuracy and concision.
> 
> I disagree.  Clarity should be the first goal.  And the fact that even 
> modified files have to be specified is something worth enphasizing, 
> especially since this is not something other systems do.

OK, OK.  Shortest I can manage then is:

	by using gitlink:git-add[1] to add new or modified files to the
	next commit.  This adds a file's current contents only; run
	gitlink:git-add[1] again to include any subsequent changes.

which may not be any improvement.

