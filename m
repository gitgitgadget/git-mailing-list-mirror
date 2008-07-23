From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not
 been set
Date: Wed, 23 Jul 2008 20:41:48 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807232040320.8986@racer>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <alpine.DEB.1.00.0807231817460.8986@racer> <488772BC.80207@workspacewhiz.com> <200807232122.38471.robin.rosenberg.lists@dewire.com> <7vd4l4cs24.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:42:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLkEZ-0007Ce-0r
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350AbYGWTls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 15:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753341AbYGWTlr
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:41:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:40825 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753302AbYGWTlr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 15:41:47 -0400
Received: (qmail invoked by alias); 23 Jul 2008 19:41:45 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp003) with SMTP; 23 Jul 2008 21:41:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/i4+IibDbiF1w3z7onKGX+nZ7M9seDUvyfZk2kwB
	3MjzN6TVuwPl73
X-X-Sender: gene099@racer
In-Reply-To: <7vd4l4cs24.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89758>

Hi,

On Wed, 23 Jul 2008, Junio C Hamano wrote:

> Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
> 
> >> There are certain file formats, such as a Visual Studio .sln file, 
> >> that MUST be CRLF.  When a .sln file is not CRLF, Visual Studio 
> >> refuses to read it.  I want to be able to set into the committed 
> >> .gitattributes file the list of files that must be translated to the 
> >> proper format regardless of the autocrlf setting.  An example is 
> >> below:
> >> 
> >> *.bat crlf
> >...
> >> *.vcw crlf
> >
> > Wouldn't "*bat -crlf " etc be good for these, and thus store CRLF in 
> > the repo.
> 
> I'd agree.  And I do not think we would want to introduce "crlf=force" 
> that converts working tree files that could be LF terminated to CRLF 
> upon checking in.  That is as bad as some helpful editors that adds CR 
> at the end of line without being asked.

You can say that only because you are not in the situation having a lot of 
CR/LF files in your _public_ repository _in spite of_ setting the 
gitattributes correctly.

That seriously sucks.

Ciao,
Dscho
