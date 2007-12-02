From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/6] builtin-commit: Add newline when showing which commit
 was created
Date: Sun, 2 Dec 2007 12:13:07 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712021212490.27959@racer.site>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site>
 <Pine.LNX.4.64.0711111736440.4362@racer.site> <20071201222106.GA27102@coredump.intra.peff.net>
 <Pine.LNX.4.64.0712012238510.27959@racer.site> <20071202054030.GA393@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 02 13:14:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyniH-0008N0-SM
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 13:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223AbXLBMNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 07:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752947AbXLBMNa
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 07:13:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:60521 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752199AbXLBMN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 07:13:29 -0500
Received: (qmail invoked by alias); 02 Dec 2007 12:13:27 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp003) with SMTP; 02 Dec 2007 13:13:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19CGmwAsulCEq9ggQs218S1lpOmpNPbOwVa9YvlYR
	YXc/FvP1AhUcCy
X-X-Sender: gene099@racer.site
In-Reply-To: <20071202054030.GA393@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66773>

Hi,

On Sun, 2 Dec 2007, Jeff King wrote:

> On Sat, Dec 01, 2007 at 10:41:47PM +0000, Johannes Schindelin wrote:
> 
> > Basically, I ran a test case in which the shell script was different from 
> > the builtin version, and this was the patch that fixed it for me.
> > 
> > Maybe it should have been
> > 
> > 	if (log_tree_commit(&rev, commit))
> > 		printf("\n");
> > 
> > at the end of print_summary() instead.  Can you try if that fixes it for 
> > you?
> 
> No, it doesn't, unless you meant "if (!log_tree_commit(...". Of course,
> I can't get log_tree_commit to return anything but true anyway (either
> log_tree_diff shows something, or since we have set always_show_header,
> we end up calling show_log).
> 
> It would be helpful if you could remember the test case, but perhaps
> that is not an option at this point.

IIRC it was "git commit -m bla".

Hth,
Dscho
