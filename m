From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: New mailmap file for the kernel
Date: Mon, 28 Jul 2008 12:53:49 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807281251000.2725@eeepc-johanness>
References: <9e4733910807272145y5b67112er4b90cc36141663c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 12:53:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNQMY-000280-9r
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 12:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107AbYG1Kwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 06:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754945AbYG1Kwn
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 06:52:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:51941 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753794AbYG1Kwm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 06:52:42 -0400
Received: (qmail invoked by alias); 28 Jul 2008 10:52:41 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp050) with SMTP; 28 Jul 2008 12:52:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lEZti7KflBSKb8jNUd4T3sm7QkH/wGRo6dVuE+5
	G5EzygS/WG7flu
X-X-Sender: user@eeepc-johanness
In-Reply-To: <9e4733910807272145y5b67112er4b90cc36141663c1@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90437>

Hi,

On Mon, 28 Jul 2008, Jon Smirl wrote:

> I made a new mailmap file for the kernel. I'll put it out on LKML 
> tomorrow.
> 
> It takes a new philosophy, there is an entry for every email address
> in the kernel git tree even if the name associated with it is correct.

Note that this makes maintaining the list much more tedious.  Of course, 
if you step up to maintain it, that is not an issue for others.

> As a result of this clean up the number of unique contributors to the 
> kernel fell from 4,284 to 3,821. A total of 463 errors or about 12% of 
> all name/email pairs. We clearly need to do some validation.

FWIW I think it is the responsibility of every contributor to quickly 
check if their credentials are correct, and provide a patch if they are 
not.

> Now that the file has every valid name/email in it is should be possible 
> to validate the name/email in all new commits. When a new developer 
> comes along we'll know it since they won't be in the file.

Unless somebody forgets, right?

Also note that in a distributed world, you cannot properly speak of a "new 
developer".

> Maybe Linus will send them a welcome message.

Kidding?

Ciao,
Dscho
