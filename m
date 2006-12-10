X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation/git-commit: rewrite to make it more end-user friendly.
Date: Sun, 10 Dec 2006 16:00:57 -0500
Message-ID: <20061210210057.GB23387@fieldses.org>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612082141260.2630@xanadu.home> <7vd56tei20.fsf_-_@assigned-by-dhcp.cox.net> <200612100130.48812.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 21:01:32 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612100130.48812.Josef.Weidendorfer@gmx.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33926>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtVnX-00020R-Rx for gcvg-git@gmane.org; Sun, 10 Dec
 2006 22:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762594AbWLJVBE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 16:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762607AbWLJVBD
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 16:01:03 -0500
Received: from mail.fieldses.org ([66.93.2.214]:41546 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1762594AbWLJVBB (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 16:01:01 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GtVn8-0000QZ-11; Sun, 10 Dec 2006
 16:00:58 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

On Sun, Dec 10, 2006 at 01:30:47AM +0100, Josef Weidendorfer wrote:
> On Saturday 09 December 2006 06:48, Junio C Hamano wrote:
> > +1. by using gitlink:git-add[1] to incrementally "add" changes to the
> > +   next commit before using the 'commit' command (Note: even modified
> > +   files must be "added");
> 
> Regarding this note: Of course unmodified files do not have to be added ;-)
> 
> What about: "(Note: changes in files already known to git, and even new
> changes done after a previous `git add` for a given file, still must
> be staged again)" 

Or maybe: "by using gitlink:git-add[1] to add new content (of either new
or newly modified files) to the next commit."

Man pages are reference documentation, so I figure it's OK to sacrifice
a little newbie-friendliness for accuracy and concision.

I dunno, I think basically the right content is there and Junio should
just commit it (after the git-rm change?), and then allow the rest of us
nitpickers to submit patches against the result to our heart's
content....

