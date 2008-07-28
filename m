From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: short log and email address
Date: Mon, 28 Jul 2008 19:34:18 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807281928400.8986@racer>
References: <9e4733910807281106y56f8b67ao86f78822c4b4ad58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 20:35:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNXZ5-0003fG-CQ
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 20:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972AbYG1SeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 14:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752885AbYG1SeV
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 14:34:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:57344 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751499AbYG1SeV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 14:34:21 -0400
Received: (qmail invoked by alias); 28 Jul 2008 18:34:19 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp029) with SMTP; 28 Jul 2008 20:34:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Qqq5/Rt8QKu6QV75P7Jz3nA5232hXqYk49KgcUF
	yGRp2Cm7U2df/k
X-X-Sender: gene099@racer
In-Reply-To: <9e4733910807281106y56f8b67ao86f78822c4b4ad58@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90484>

Hi,

On Mon, 28 Jul 2008, Jon Smirl wrote:

> Using the -e option in shortlog changes the results by spitting things 
> out by email address instead of leaving them combined by name. That's 
> probably not what you want. Instead you want everything combined by name 
> and then display the most recent email address used.

What is so wrong with _not_ using -e (since you do not want to see the 
email address stored in the commit message, and -e would be asking for 
that _exactly_)?

After the fact, you can annotate the names with all you like.  For 
example, the most recent email address for that person.

But as Mark pointed out, the name might be a bad key.  Maybe you will have 
to do something completely different, namely maintain a separate list of 
(correct) names and emails, and then having line numbers in .mailmap, 
like:

1 <davem@sunset>
1 <davem@sunrise>
1 <davem@moonshine>
2 <dave.miller@miller.com>
2 <dave.miller@highnoon.miller.com>

etc

However, I have to say that I see small value in that, and an inordinate 
amount of work that nobody wants to do.

Ciao,
Dscho
