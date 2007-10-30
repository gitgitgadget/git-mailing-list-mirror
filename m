From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Missing MIME-headers in git-email-tool ..
Date: Tue, 30 Oct 2007 12:07:14 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710301157290.4362@racer.site>
References: <20071030095338.GZ6372@mea-ext.zmailer.org>
 <Pine.LNX.4.64.0710301028360.4362@racer.site> <20071030112750.GA6372@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matti Aarnio <matti.aarnio@zmailer.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 13:08:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImptB-0001mZ-Dt
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 13:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbXJ3MH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 08:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752154AbXJ3MH4
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 08:07:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:52948 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751262AbXJ3MHz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 08:07:55 -0400
Received: (qmail invoked by alias); 30 Oct 2007 12:07:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 30 Oct 2007 13:07:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ahAglDCbaIIXHvaNCYlDo9gIjspLPBnVKmXaLOs
	REO0pbFUlLTLem
X-X-Sender: gene099@racer.site
In-Reply-To: <20071030112750.GA6372@mea-ext.zmailer.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

[please Cc: me]

On Tue, 30 Oct 2007, Matti Aarnio wrote:

> On Tue, Oct 30, 2007 at 10:31:41AM +0000, Johannes Schindelin wrote:
> 
> > On Tue, 30 Oct 2007, Matti Aarnio wrote:
> > 
> > > The  git-send-email  does send posts without any sort of MIME labeling:
> > > 
> > >   From: / To: removed
> > > 
> > >   Subject: [PATCH 0/2] Blackfin I2C/TWI driver updates
> > >   Date: Tue, 30 Oct 2007 17:33:15 +0800
> > >   Message-Id: <1193736797-9005-1-git-send-email-bryan.wu@analog.com>
> > >   X-Mailer: git-send-email 1.5.3.4
> > >   Precedence: bulk
> > > 
> > > 
> > > which per MIME rules means that the message in question is equivalent
> > > to one with header labels:
> > > 
> > >   MIME-Version: 1.0
> > >   Content-Type: text/plain; charset=US-ASCII
> > >   Content-Transfer-Encoding: 7bit
> > 
> > AFAICT MIME headers are only added when needed.  (But that might only 
> > apply to format-patch; however, if you signed off with your name, all 
> > should be well.)
> 
> I wish that were true..   We (VGER's Postmasters that is) would not see
> so much rejections from all over the places...   Would it motivate you
> if we sent all GIT caused ones to you ?

Heh.

I'm not a send-mail user myself, so I did not ever have any reason to dive 
into its source code.  Sorry.

I understand your pain.  But as we assume UTF-8 in git if no other 
encoding is selected, I think it makes more sense to default to UTF-8.

That said, I actually like the behaviour which I think is intended, to not 
specify anything when the message can be interpreted as US-ASCII.

BTW I tried to find anything in the message you referenced which would 
make it non-ASCII, but I did not find anything.  But then, I am not 
subscribed to the lkml, and can only get stripped down versions of the 
mails via marc or kerneltrap.

Any send-email gurus want to join into this discussion?

Ciao,
Dscho
