From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC,PATCH] Make git prune remove temporary packs that look like
 write failures
Date: Mon, 4 Feb 2008 16:33:29 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802041633190.7372@racer.site>
References: <e1dab3980802040610s27a54a9due3b42db5f59c0cd5@mail.gmail.com> <alpine.LSU.1.00.0802041512140.7372@racer.site> <alpine.LFD.1.00.0802041105170.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Tweed <david.tweed@gmail.com>,
	gi mailing list <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Feb 04 17:34:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM4HL-0002bO-I9
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 17:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbYBDQeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 11:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752660AbYBDQeJ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 11:34:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:44254 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750996AbYBDQeI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 11:34:08 -0500
Received: (qmail invoked by alias); 04 Feb 2008 16:34:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 04 Feb 2008 17:34:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wldAOQCIwJecSPcdUmmSC+rXPXOzpGb80timJ+E
	mlho4UxTOIDHWJ
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0802041105170.2732@xanadu.home>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72521>

Hi,

On Mon, 4 Feb 2008, Nicolas Pitre wrote:

> On Mon, 4 Feb 2008, Johannes Schindelin wrote:
> 
> > On Mon, 4 Feb 2008, David Tweed wrote:
> > 
> > > +                       if(c>0 && c<4096 && stat(name, &status) == 0
> > > +                          && status.st_mtime < now - 600){
> > 
> > Please have spaces after the "if" and before the "{" (just imitate the 
> > style of the rest of the file).
> > 
> > Also, 10 minutes grace period for any ongoing fetch or repack seems a 
> > bit arbitrary.  Maybe default to 10 minutes, and introduce 
> > prune.packGracePeriod?
> > 
> > (Which reminds me that it might be useful to add a 
> > prune.looseObjectsGracePeriod to avoid having to type --expire= all 
> > the time?)
> 
> Please use the same parameter for both.  There is no need to have 
> separate settings.

Right.

Ciao,
Dscho
