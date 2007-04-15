From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Define a few built-in attribute rules.
Date: Sun, 15 Apr 2007 18:21:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704151819390.18846@racer.site>
References: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net> <200704131033.15751.andyparkins@gmail.com>
 <7vejmm78qp.fsf@assigned-by-dhcp.cox.net> <7vvefy5tzo.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0704141839030.5473@woody.linux-foundation.org>
 <7vr6qm5r73.fsf@assigned-by-dhcp.cox.net> <7v8xcu5ps7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 15 18:22:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hd7Uv-0008QI-SA
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 18:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbXDOQWX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 12:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753066AbXDOQWX
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 12:22:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:54412 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752995AbXDOQWW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 12:22:22 -0400
Received: (qmail invoked by alias); 15 Apr 2007 16:22:20 -0000
Received: from 88-110-140-199.dynamic.dsl.as9105.com (EHLO 88-110-140-199.dynamic.dsl.as9105.com) [88.110.140.199]
  by mail.gmx.net (mp048) with SMTP; 15 Apr 2007 18:22:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187F1McS6c7G1e5Vv4rMQ/7LaMSugSjpbC4SxvdWg
	SxaaMj8nbXyKVP
X-X-Sender: gene099@racer.site
In-Reply-To: <7v8xcu5ps7.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44497>

Hi,

On Sat, 14 Apr 2007, Junio C Hamano wrote:

> [...] if we really wanted to, we could introduce a way to explicitly say 
> "Even if the contents do not look like text, apply line ending 
> conversion, always", by redefining the meaning of 'crlf' attribute.

I think it might make more sense to introduce a way to say "do not even 
check; I _know_ that I want crlf on these".

It might show performance improvements on large repos, for example.

Ciao,
Dscho
