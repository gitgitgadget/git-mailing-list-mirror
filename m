X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: git blame [was: git and bzr]
Date: Thu, 30 Nov 2006 17:24:22 -0500
Message-ID: <20061130222422.GC30922@fieldses.org>
References: <456B7C6A.80104@webdrake.net> <Pine.LNX.4.64.0611271834090.30076@woody.osdl.org> <456CEF31.8080600@webdrake.net> <Pine.LNX.4.64.0611281906520.3395@woody.osdl.org> <456D7A76.3080605@webdrake.net> <Pine.LNX.4.64.0611290830010.3395@woody.osdl.org> <456F21D6.1060200@webdrake.net> <Pine.LNX.4.64.0611301034420.3513@woody.osdl.org> <87d574u2tl.wl%cworth@cworth.org> <Pine.LNX.4.63.0611302314320.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 22:24:51 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, Linus Torvalds <torvalds@osdl.org>,
	Joseph Wakeling <joseph.wakeling@webdrake.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0611302314320.30004@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32814>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpuKW-00059s-7J for gcvg-git@gmane.org; Thu, 30 Nov
 2006 23:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031559AbWK3WY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 17:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031564AbWK3WY3
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 17:24:29 -0500
Received: from mail.fieldses.org ([66.93.2.214]:27790 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S1031559AbWK3WY2
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 17:24:28 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GpuKM-0002w5-Ct; Thu, 30 Nov 2006
 17:24:22 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Thu, Nov 30, 2006 at 11:17:12PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 30 Nov 2006, Carl Worth wrote:
> 
> > Here's a crazy idea. How about a "git tutorial" builtin or "git example" 
> > or something that would create a repository into some useful state for 
> > demonstrating something.
> 
> That sounds fine! Actually, it should be very simple to turn the tutorial 
> into such a script, displaying the command with an explanation, and 
> executing the command. It could even call gitk from time to time, so the 
> user can form a mental model of the ancestor graph.

Currently tutorial.txt doesn't work like that--there are places where it
just tells the user to edit a file, or make a few commits, without
listing commands to do so.  It also isn't linear.  That could all be
"fixed", but I think the result would just make it more tedious.

But I agree that a "git tutorial" command to set up a canonical example
repository might be fun.

