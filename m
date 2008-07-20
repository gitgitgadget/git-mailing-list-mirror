From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC variant 2 of 2] "needs update" considered harmful
Date: Sun, 20 Jul 2008 14:41:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807201435450.3305@eeepc-johanness>
References: <7vtzelf4mf.fsf@gitster.siamese.dyndns.org> <7v7ibhdmii.fsf@gitster.siamese.dyndns.org> <20080720112957.GE32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Jul 20 14:41:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKYEK-0002KG-NH
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 14:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756684AbYGTMkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 08:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756849AbYGTMkh
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 08:40:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:49263 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754926AbYGTMkg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 08:40:36 -0400
Received: (qmail invoked by alias); 20 Jul 2008 12:40:34 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp045) with SMTP; 20 Jul 2008 14:40:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/pro4jiSjpzrB4h9UDzhDa/IkxPQO4HvzF6tb6eJ
	K51UCy1M18L4Gj
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080720112957.GE32184@machine.or.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89194>

Hi,

On Sun, 20 Jul 2008, Petr Baudis wrote:

> Scripts need to be modified for the reorganization anyway,

No.  They do not, if the 1st variant is applied.

> and I'm not sure if there are any actually depening on this particular 
> string.

That is the question, isn't it?  You would never know.  Many people, 
strange as it sounds, do not write to this list when they encounter 
problems with Git.  They vent on their blogs, not giving us a chance, and 
other people comment "Me too"s.

One of the most important features of Git used to be its scriptability, 
and I think that many hackers just love Git for it, even new hackers.

So it is probably not unheard of that someone wrote an update hook or a 
cronjob using the output of "update-index --refresh".

But those people are probably not on this list, or not following every 
thread, or they even forgot how/that they implemented such a hook/cronjob.

Ergo: we would not know if scripts break.  Until it is too late.

Ciao,
Dscho
