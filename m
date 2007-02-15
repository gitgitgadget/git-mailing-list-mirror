From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: User-wide ignore list
Date: Thu, 15 Feb 2007 16:23:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702151620310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <vpq4ppnvi1j.fsf@olympe.imag.fr> <200702151112.06729.andyparkins@gmail.com>
 <Pine.LNX.4.63.0702151259270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200702151306.33865.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 15 16:34:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHiSM-0003WY-3P
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 16:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbXBOPXa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 10:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbXBOPXa
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 10:23:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:50835 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751534AbXBOPXa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 10:23:30 -0500
Received: (qmail invoked by alias); 15 Feb 2007 15:23:28 -0000
X-Provags-ID: V01U2FsdGVkX1+3W9doj1O3F2b+7LX3hHpQsgPb65bIz0IOG8QYNE
	taEg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702151306.33865.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39830>

Hi,

On Thu, 15 Feb 2007, Andy Parkins wrote:

> On Thursday 2007 February 15 11:59, Johannes Schindelin wrote:
> 
> > > info/exclude::
> >
> > Nope. This is per-repo, not per-user.
> 
> Silly me; I forgot to write the last bit of my email :-)
> 
> $ ln -sf $HOME/.git/exclude $GIT_DIR/info/exclude
> 
> Do that in each of your working checkouts and voila.

... and next time you edit .git/info/exclude, be very surprised that other 
repos have the change, too.

Ciao,
Dscho
