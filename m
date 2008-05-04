From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] I don't known anyone who understands what it means when
 they do a merge and see "file.txt: needs update".  "file.txt: has changes"
 is much clearer.
Date: Sun, 4 May 2008 10:29:26 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805041027150.30431@racer>
References: <1209798522-13618-1-git-send-email-timcharper@gmail.com> <alpine.DEB.1.00.0805031509170.30431@racer> <7v3aozwcj6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 04 11:30:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsaXy-0003Mr-De
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 11:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854AbYEDJ3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 05:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753811AbYEDJ3a
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 05:29:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:35005 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752139AbYEDJ33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 05:29:29 -0400
Received: (qmail invoked by alias); 04 May 2008 09:29:28 -0000
Received: from dslb-088-067-220-031.pools.arcor-ip.net (EHLO dslb-088-067-220-031.pools.arcor-ip.net) [88.67.220.31]
  by mail.gmx.net (mp021) with SMTP; 04 May 2008 11:29:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19rVax/Nyxrxct4IITa9bUltyMPSwiAG+kzWwvpw3
	AwygX0F40zulXA
X-X-Sender: gene099@racer
In-Reply-To: <7v3aozwcj6.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81154>

Hi,

On Sat, 3 May 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sat, 3 May 2008, Tim Harper wrote:
> >
> >> -			printf("%s: needs update\n", ce->name);
> >> +			printf("%s: has changes\n", ce->name);
> >
> > How about "local changes"?
> 
> Aren't there Porcelain and end-user scripts that relies on the output by
> doing "sed -ne s'/: needs update$//p"?

Potentially.  But I thought that it would make more sense to use 
--name-only in that case.

However, I obviously like that you go out of your way to cause the least 
damage to current users, so how about something like in merge-recursive, 
where you can change some output based on an environment variable?

In this case, I'd rather make it an option, but that may be overkill.  But 
then, enough people have commented that this message is irritating them.

Ciao,
Dscho
