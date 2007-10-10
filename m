From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] git-gui: set NO_MSGFMT to force using pure tcl
 replacement in msysgit
Date: Wed, 10 Oct 2007 20:46:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710102044220.4174@racer.site>
References: <8F81028C-9924-4AA2-A58D-961AD10F5315@zib.de>
 <11919995392158-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0710101651360.4174@racer.site>
 <CC4EB4CA-3BA0-4C00-8B23-31B09032CC69@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: spearce@spearce.org, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 21:46:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfhVt-0003f6-9J
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 21:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755425AbXJJTq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 15:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755312AbXJJTq0
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 15:46:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:46341 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755108AbXJJTq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 15:46:26 -0400
Received: (qmail invoked by alias); 10 Oct 2007 19:46:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp003) with SMTP; 10 Oct 2007 21:46:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Ak4sGLw+AE/muEAa2OvJgkSUvhSqVQHVyaFcaHd
	aVFdYk0MohMPVI
X-X-Sender: gene099@racer.site
In-Reply-To: <CC4EB4CA-3BA0-4C00-8B23-31B09032CC69@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60535>

Hi,

On Wed, 10 Oct 2007, Steffen Prohaska wrote:

> On Oct 10, 2007, at 5:52 PM, Johannes Schindelin wrote:
> 
> > On Wed, 10 Oct 2007, Steffen Prohaska wrote:
> > 
> > > Shawn's git-gui Makefile supports the pure tcl replacement for 
> > > msgfmt if setting NO_MSGFMT. This patch sets the NO_MSGFMT for 
> > > msysgit.
> > 
> > Would it not be cleaner to set this in 4msysgit and export it?
> 
> What does "set this in 4msysgit" mean?

It means what you probably assumed, that we change the Makefile in /git.

> Would running 'make' in /git/git-gui/ be supported by your solution?

No, not really.  Just like "make" in /git/t/ does not pick up on the 
NO_SYMLINKS option.

Ciao,
Dscho
