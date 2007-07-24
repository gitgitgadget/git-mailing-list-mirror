From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Teach the --cover-letter option to format-patch
Date: Tue, 24 Jul 2007 16:19:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707241615170.29679@iabervon.org>
References: <Pine.LNX.4.64.0707100126250.6977@iabervon.org>
 <Pine.LNX.4.64.0707101300450.6977@iabervon.org> <Pine.LNX.4.64.0707101819350.4047@racer.site>
 <200707242212.27837.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 22:19:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDQrK-0006l8-6b
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 22:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547AbXGXUTv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 16:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757329AbXGXUTu
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 16:19:50 -0400
Received: from iabervon.org ([66.92.72.58]:3946 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755998AbXGXUTu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 16:19:50 -0400
Received: (qmail 10265 invoked by uid 1000); 24 Jul 2007 20:19:48 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Jul 2007 20:19:48 -0000
In-Reply-To: <200707242212.27837.kumbayo84@arcor.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53638>

On Tue, 24 Jul 2007, Peter Oberndorfer wrote:

> On Tuesday 10 July 2007 19:20, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Tue, 10 Jul 2007, Daniel Barkalow wrote:
> > 
> > > I think this is missing the ultra-important "extra_headers" stuff, which 
> > > is what makes my messages actually reach the right people. That's why 
> > > I'd like the code shared for generating headers (except for Subject) for 
> > > a rev_info between the code that does it for patch messages and the code 
> > > for the cover letter. I think it's also missing making [PATCH 1/N] a 
> > > reply to it if the series is set up as replies.
> > 
> > Ah yes. Both issues should be relatively easy to integrate into my patch.
> > 
> > > I like the design, in any case. I want the blurb actually stored in the 
> > > objects directory somehow, so that I don't have to trawl through my sent 
> > > email for it when I send the series again for some reason, but that's a 
> > > relatively straightforward extension to your code. (Read an object with 
> > > a hash and stick the text in instead of the ***...*** parts.)
> > 
> > I do not understand. But then, my patch should be a good starting point. 
> > Go wild.
> > 
> > Ciao,
> > Dscho
> Anybody working on this?
> Somebody, *cough* convinced me into working on this.
> I already split up the existing patch into logic parts, and will now try to read message / header
> from file or a commit.

Last night, I was thinking about it, but I hadn't actually gotten started. 
If you do it, I'd suggest using an unsigned tag for the message rather 
than a commit, since it fits the design for a message in an unsigned tag 
(extra information about the tagged version).

	-Daniel
*This .sig left intentionally blank*
