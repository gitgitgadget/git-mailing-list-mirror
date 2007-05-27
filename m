From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT on MinGW problem
Date: Sun, 27 May 2007 11:52:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705271149450.4648@racer.site>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>
 <4656A304.AF39A0B6@eudaptics.com> <Pine.LNX.4.64.0705251113280.4648@racer.site>
 <46588DA4.5020109@xs4all.nl> <Pine.LNX.4.64.0705262311380.4648@racer.site>
 <46592B92.9060403@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Sun May 27 12:52:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsGMY-0005ZW-Nz
	for gcvg-git@gmane.org; Sun, 27 May 2007 12:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbXE0Kwe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 06:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbXE0Kwe
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 06:52:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:55771 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750790AbXE0Kwd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 06:52:33 -0400
Received: (qmail invoked by alias); 27 May 2007 10:52:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 27 May 2007 12:52:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+RH+VA2p6R10tmifRBRMjKWjzVUrJUrA6R0YV234
	fYYAuru0M8BhtX
X-X-Sender: gene099@racer.site
In-Reply-To: <46592B92.9060403@xs4all.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48530>

Hi,

On Sun, 27 May 2007, Han-Wen Nienhuys wrote:

> Johannes Schindelin escreveu:
> 
> > I recently compiled tcl and tk from scratch on MinGW. (No cross-compile.) 
> > Worked out of the box:
> > 
> > 	http://prdownloads.sourceforge.net/tcl/tcl8.4.14-src.tar.gz
> > 	http://prdownloads.sourceforge.net/tcl/tk8.4.14-src.tar.gz
> >       
> 
> GCC barfs on:
> 
>       ((Tcl_Obj **) objv) += (async + 3);

Ah yes, I was using MinGW's own GCC, which is GCC 3.something.

It is a new "feature" of GCC 4.x to disallow constructs like these. 
(Probably because GCC people think that other people are not intelligent 
enough to understand such constructs, and therefore prohibit their use.)

Ciao,
Dscho
