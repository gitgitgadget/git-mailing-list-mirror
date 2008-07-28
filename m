From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: short log and email address
Date: Mon, 28 Jul 2008 20:11:40 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807282010190.8986@racer>
References: <9e4733910807281106y56f8b67ao86f78822c4b4ad58@mail.gmail.com>  <alpine.DEB.1.00.0807281928400.8986@racer> <9e4733910807281157u44c08a59ld3bdc0416e8a1d03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 21:12:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNY9C-0001YE-Si
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 21:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbYG1TLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 15:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbYG1TLm
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 15:11:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:35285 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751893AbYG1TLl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 15:11:41 -0400
Received: (qmail invoked by alias); 28 Jul 2008 19:11:40 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp067) with SMTP; 28 Jul 2008 21:11:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/BUvQOu8vB9g9hNvLaJVEasofkm6n089TAEqJMho
	VYa39hBsSPMBax
X-X-Sender: gene099@racer
In-Reply-To: <9e4733910807281157u44c08a59ld3bdc0416e8a1d03@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90488>

Hi,

On Mon, 28 Jul 2008, Jon Smirl wrote:

> On 7/28/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> >  On Mon, 28 Jul 2008, Jon Smirl wrote:
> >
> >  > Using the -e option in shortlog changes the results by spitting 
> >  > things out by email address instead of leaving them combined by 
> >  > name. That's probably not what you want. Instead you want 
> >  > everything combined by name and then display the most recent email 
> >  > address used.
> >
> > What is so wrong with _not_ using -e (since you do not want to see the 
> > email address stored in the commit message, and -e would be asking for 
> > that _exactly_)?
> 
> I wanted -e to give me the most recent email so that I would know how
> to sort the mailmap alias list.

As I explained, that is not what -e is _supposed_ to do.  In Git, content 
is king, and as such -e should look at the content.  Unsurprisingly, that 
is exactly what it does.

Nothing prohibits you from post-processing the output, though.

Ciao,
Dscho
