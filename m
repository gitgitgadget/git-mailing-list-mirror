X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-explain
Date: Tue, 5 Dec 2006 01:21:26 -0800
Message-ID: <20061205092126.GE27236@soma>
References: <200612031701.15594.alan@chandlerfamily.org.uk> <Pine.LNX.4.64.0612031024480.3476@woody.osdl.org> <7v1wngwws6.fsf@assigned-by-dhcp.cox.net> <7vwt57j94c.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612042253250.2630@xanadu.home> <20061205035721.GA26735@fieldses.org> <7v1wnekh6a.fsf@assigned-by-dhcp.cox.net> <20061205072622.GA21839@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 09:21:43 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061205072622.GA21839@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33329>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrWUY-0000KC-0r for gcvg-git@gmane.org; Tue, 05 Dec
 2006 10:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968161AbWLEJV2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 04:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968163AbWLEJV2
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 04:21:28 -0500
Received: from hand.yhbt.net ([66.150.188.102]:43141 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S968161AbWLEJV1
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 04:21:27 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 2B1A72DC034; Tue,  5 Dec 2006 01:21:26 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue,  5 Dec 2006
 01:21:26 -0800
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Mon, Dec 04, 2006 at 10:09:17PM -0800, Junio C Hamano wrote:
> 
> > Should I take these responses to mean that you two are negative
> > about the approach of spending extra cycles to commands that can
> > leave the working tree in a "in the middle of doing something"
> > state to help having a unified command to explain what the
> > situation is and suggest the user possible exits, or are you
> > saying that it might be a good idea but "git explain" is a bad
> > name?
> 
> It seems like the point of this command is to show some state
> information which would otherwise be hard to see. I think of 'git
> status' as the way to look at the repository state. Perhaps we should
> enhance the output of 'git status' to note things such as failed merges,
> whether we're bisecting, in the middle of applying a patch series, etc.
> There could be an optional verbosity switch to give "full explanations"
> including recommended ways to deal with the situation.

I wholeheartedly agree that 'git status' should show something like
this.  I actually had some stuff that was a work-in-progress several
months ago that enhanced status with several things like this; but got
distracted and forgot about that repository.  I'll try to dig it out
sometime tomorrow.  I remember my work started from wanting to know
what 'git-rerere' would be recording.

-- 
