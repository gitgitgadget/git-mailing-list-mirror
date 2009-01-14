From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RESEND PATCH] fast-import: Cleanup mode setting.
Date: Wed, 14 Jan 2009 03:28:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901140326530.3586@pacific.mpi-cbg.de>
References: <1231897027-16197-1-git-send-email-felipe.contreras@gmail.com> <alpine.DEB.1.00.0901140308200.3586@pacific.mpi-cbg.de> <20090114021751.GW10179@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Miklos Vajna <vmiklos@frugalware.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 14 03:29:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMvVC-0002w8-RW
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 03:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914AbZANC1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 21:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbZANC1n
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 21:27:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:43415 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752047AbZANC1m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 21:27:42 -0500
Received: (qmail invoked by alias); 14 Jan 2009 02:27:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 14 Jan 2009 03:27:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX192Y3w9K5d2ux8R5hTgvYbZUMwCuZfpDqpvlYXuu/
	0yhWK4I24JyQC0
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090114021751.GW10179@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105575>

Hi,

On Tue, 13 Jan 2009, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Wed, 14 Jan 2009, Felipe Contreras wrote:
> > 
> > > "S_IFREG | mode" probably is only required for 0644 and 0755.
> > 
> > Why should we want to have that patch?  IOW what does it fix, and what 
> > might it break?
> 
> It cleans up the code to make it more readable.
> 
> It makes no sense to be doing S_IFREG | S_IFLINK, which happens when
> the input is for a symlink.  It doesn't break anything to do that |
> operation, but it also looks damn odd when reading the function.

Imagining myself reading the commit message 6 months from now, in all 
likeliness I will have wished that those two paragraphs were in there.  
Verbatim.

Ciao,
Dscho
