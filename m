From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 11/11] Support bundles in builtin-clone
Date: Sun, 9 Mar 2008 17:59:56 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803091755530.19665@iabervon.org>
References: <alpine.LNX.1.00.0803081804280.19665@iabervon.org> <alpine.LSU.1.00.0803090027570.3975@racer.site> <alpine.LNX.1.00.0803091447230.19665@iabervon.org> <alpine.LSU.1.00.0803092155450.3975@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 09 23:00:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYTZP-0004Bp-78
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 23:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbYCIV77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 17:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753304AbYCIV77
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 17:59:59 -0400
Received: from iabervon.org ([66.92.72.58]:48376 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753009AbYCIV77 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 17:59:59 -0400
Received: (qmail 13500 invoked by uid 1000); 9 Mar 2008 21:59:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Mar 2008 21:59:56 -0000
In-Reply-To: <alpine.LSU.1.00.0803092155450.3975@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76674>

On Sun, 9 Mar 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Sun, 9 Mar 2008, Daniel Barkalow wrote:
> 
> > On Sun, 9 Mar 2008, Johannes Schindelin wrote:
> > 
> > > On Sat, 8 Mar 2008, Johannes Schindelin wrote:
> > > 
> > > > This forward-ports c6fef0bb(clone: support cloning full bundles) to 
> > > > the builtin clone.
> > > > 
> > > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > > ---
> > > 
> > > Wow... Is this a new send-email feature?  I did not send this email...
> > 
> > Nope, it's an old format-patch feature. format-patch generates the 
> > messages with the From: being the commit author, and my MTA doesn't 
> > complain about the fact that I'm sending email with some entirely 
> > different From:. It would probably be more clever to have format-patch 
> > use the committer or the current user as the From:, and put an 
> > additional From: in the message body with the author if it's not the 
> > email From:.
> 
> I think that makes sense.
> 
> > Of course, you did sort of send that email 
> > (http://permalink.gmane.org/gmane.comp.version-control.git/75743).
> 
> Sort of.
> 
> Of course, I am okay with it, but I consider the From: issue a real bug in 
> send-email (or format-patch, if you want).

Agreed; (format-patch, I didn't use send-email). But I don't understand 
the flow control in pretty.c nearly well enough to fix it right now. It 
lists the author in the headers, like all of the log output formats, and 
doesn't then have the author available in the body, afaict.

	-Daniel
*This .sig left intentionally blank*
