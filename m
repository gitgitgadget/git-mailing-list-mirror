From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git push bug?
Date: Thu, 18 Oct 2007 17:21:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710181720010.25221@racer.site>
References: <1192719040.9433.5.camel@gentoo-jocke.transmode.se> 
 <0DAC53EF-021D-441C-9520-9795AAB6DE54@zib.de> <1192723269.9433.21.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>, git <git@vger.kernel.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Thu Oct 18 18:21:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiY7y-0003pQ-7W
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 18:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756991AbXJRQVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 12:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753373AbXJRQVb
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 12:21:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:51116 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754073AbXJRQVa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 12:21:30 -0400
Received: (qmail invoked by alias); 18 Oct 2007 16:21:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 18 Oct 2007 18:21:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX191nnVqhzV1np8l4NECQ55IDgBQZrbyZ31NGAihq4
	5YxmBU8/YtwqeS
X-X-Sender: gene099@racer.site
In-Reply-To: <1192723269.9433.21.camel@gentoo-jocke.transmode.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61544>

Hi,

On Thu, 18 Oct 2007, Joakim Tjernlund wrote:

> Seems like it is a bit too easy to make mistakes here. Why can I delete 
> a branch with :linus but not create one with linus:linus?

I wonder why you bother with the colon at all.  Just

	git push <remote> linus

and be done with it.  The colon is only there to play interesting games, 
not something as simple as "push this branch" or "push this tag".

Ciao,
Dscho
