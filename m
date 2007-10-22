From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git filter-branch --subdirectory-filter error
Date: Mon, 22 Oct 2007 14:44:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710221440540.25221@racer.site>
References: <200710221227.13279.wielemak@science.uva.nl>
 <Pine.LNX.4.64.0710221218150.25221@racer.site> <200710221337.50730.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jan Wielemaker <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Mon Oct 22 15:45:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjxaW-0003iO-KS
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 15:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbXJVNos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 09:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbXJVNos
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 09:44:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:43385 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751879AbXJVNos (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 09:44:48 -0400
Received: (qmail invoked by alias); 22 Oct 2007 13:44:46 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 22 Oct 2007 15:44:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+zSe8xBSSzpWQjtbwjnC9aVP2vevtdcVf/yZxpJz
	Z1RUhrP714SfG2
X-X-Sender: gene099@racer.site
In-Reply-To: <200710221337.50730.wielemak@science.uva.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62004>

Hi,

On Mon, 22 Oct 2007, Jan Wielemaker wrote:

> On Monday 22 October 2007 13:20, Johannes Schindelin wrote:
>
> > The subdirectory filter does not look kindly upon a history where some 
> > commits lack the subdirectory in question.  However, this should work:
> >
> > 	git filter-branch --subdirectory--filter RDF 95807fe01..HEAD
> 
> Thanks, but ... hmmm.
> 
> $ git filter-branch --subdirectory-filter RDF 
> 95807fe01c39d3092e3ac3a98061711323154d77..HEAD
> Rewrite 0a43c802dd60f53d48136a32526a4b2a5f0d43e5 (1/11)fatal: Not a valid 
> object name 0a43c802dd60f53d48136a32526a4b2a5f0d43e5:RDF
> Could not initialize the index

I suspect again that this commit does not contain the RDF/ subdirectory.

> This started as a big project with a lot of history in CVS, including 
> moved (read deleted and re-created) files. This was moved to SVN and 
> from there immediately to GIT. In GIT lots of things have been renamed. 
> The RDF directory was created quite recent in the project and things 
> from various subdirectories were moved there.
> 
> Is there something that might be worth a try or should we go the simple
> way: keeping the old combined repo for later reference and create two
> new ones from fresh files?

It sure sounds pretty tricky.  (IOW I'm probably unable to help more...)

Ciao,
Dscho
