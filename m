From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow passing of an alternative CVSROOT via -d.
Date: Mon, 19 Feb 2007 12:10:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702191209200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45D88A14.4040400@fs.ei.tum.de> <45D934CC.6080707@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	git@vger.kernel.org
To: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Feb 19 12:11:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ6Q9-0007Wb-7J
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 12:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbXBSLKj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 06:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbXBSLKi
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 06:10:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:50552 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932100AbXBSLKi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 06:10:38 -0500
Received: (qmail invoked by alias); 19 Feb 2007 11:10:36 -0000
X-Provags-ID: V01U2FsdGVkX1/1VA02e/r1DNa8E/rlyB+w45eRnKnCORxNb7r92p
	3bsg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45D934CC.6080707@catalyst.net.nz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40121>

Hi,

On Mon, 19 Feb 2007, Martin Langhoff wrote:

> Simon 'corecode' Schubert wrote:
> > This is necessary if using CVS in an asymmetric fashion, i.e. when the 
> > CVSROOT you are checking out from differs from the CVSROOT you have to 
> > commit to.
> 
> I guess you have an anon checkout and then use CVSROOT at commit time to 
> switch to cvs-over-ssh perhaps even on a different server. 
> In-te-rest-ing.

It was kind of common operation when SourceForge had immense problems with 
SSH checkout, but the anonymous services were up-and-running.

I am still worried why "CVSROOT=bla git cvsexportcommit ..." does not run 
as expected, though.

Ciao,
Dscho
