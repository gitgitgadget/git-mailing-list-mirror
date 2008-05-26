From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now
 incompatible with Cygwin (and probably Windows)
Date: Tue, 27 May 2008 00:10:19 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805270007430.30431@racer>
References: <483AC2CE.7090801@gmail.com> <alpine.DEB.1.00.0805261521130.30431@racer> <483AF570.9000609@gmail.com> <alpine.DEB.1.00.0805262226400.30431@racer> <483B3E86.5020100@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 01:11:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0lqL-0007KS-6j
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 01:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654AbYEZXKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 19:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755416AbYEZXKO
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 19:10:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:45698 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753631AbYEZXKN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 19:10:13 -0400
Received: (qmail invoked by alias); 26 May 2008 23:10:11 -0000
Received: from R105f.r.pppool.de (EHLO racer.local) [89.54.16.95]
  by mail.gmx.net (mp017) with SMTP; 27 May 2008 01:10:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/iwRxPjrXincEAMRChOgqWkPpmixrJhHycJiwuhp
	yiUh9JJszEQlFD
X-X-Sender: gene099@racer
In-Reply-To: <483B3E86.5020100@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82971>

Hi,

On Mon, 26 May 2008, Mark Levedahl wrote:

> So, there is now a range of git's history that is unusable (and 
> non-bisectable) on Windows, at least from the porcelain. And apparently, 
> somewhere in that unusable history, a change was introduced that causes 
> test failure on Cygwin. Great...

Oh, for the love of God!  It is not like we will not fix this problem 
eventually!  Screwing a lot of users by rewriting history, just because of 
Windows, which we need too many ugly work-arounds in Git's source code for 
anyway, is _not_ an option.

Or would you suggest to scrap almost the complete history of Git just 
because most of it does not compile on platform XYZ, while the initial 
revision did?  Exactly.

Ciao,
Dscho
