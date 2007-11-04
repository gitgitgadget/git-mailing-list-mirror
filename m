From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Warning: cvsexportcommit considered dangerous
Date: Sun, 4 Nov 2007 21:35:41 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711042133330.4362@racer.site>
References: <Pine.LNX.4.64.0711041638270.4362@racer.site>
 <623F4AFA-FE43-4046-9D3F-435396BBE17D@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Alex Bennee <kernel-hacker@bennee.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Nov 04 22:37:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ion9n-0007yU-UK
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 22:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936AbXKDVhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 16:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752867AbXKDVhE
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 16:37:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:49566 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752045AbXKDVhD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 16:37:03 -0500
Received: (qmail invoked by alias); 04 Nov 2007 21:37:00 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp010) with SMTP; 04 Nov 2007 22:37:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/vTXgri0bv+Wyugd3eEqNyessKn2E+orsSk0bium
	h6D2DmxXR2XpEq
X-X-Sender: gene099@racer.site
In-Reply-To: <623F4AFA-FE43-4046-9D3F-435396BBE17D@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63446>

Hi,

On Sun, 4 Nov 2007, Steffen Prohaska wrote:

> On Nov 4, 2007, at 5:41 PM, Johannes Schindelin wrote:
> 
> > ever since the up-to-date check was changed to use just one call to 
> > "cvs status", a bug was present.  Now cvsexportcommit expects "cvs 
> > status" to return the results in the same order as the file names were 
> > passed.
> > 
> > This is not true, as I had to realise with one of my projects on 
> > sourceforge.
> > 
> > Since time is so scarce on my side, I will not have time to fix this 
> > bug, but will instead return to my old "commit by hand" procedure.
> 
> I introduced this 'optimization', which turned out to be a bug. So, I 
> feel responsible. Sorry for the trouble.
> 
> In August this was already recognized and a patch submitted:
> 
> http://marc.info/?t=118718458000004&r=1&w=2
> 
> I do not know why it wasn't applied. I forgot re-checking after my 
> vacation.

It slipped by me, because of holiday, too.  (I was on my well needed 
holiday then.)

But that patch really seems like a step back to me.  The line "File: ... 
Status: ..." should be parsable enough to fix the bug properly, instead of 
undoing the optimisation.

AFAICS Robin replied with a "let's see if a proper fix materialises", and 
I kind of hope that it will materialise soon.

Ciao,
Dscho
