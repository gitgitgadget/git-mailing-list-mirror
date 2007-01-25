From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: .git/info/refs
Date: Fri, 26 Jan 2007 00:33:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701260029580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org>
 <45B7818F.6020805@zytor.com> <7vireuaj9d.fsf@assigned-by-dhcp.cox.net>
 <45B92332.5060206@zytor.com> <7v3b5yai6c.fsf@assigned-by-dhcp.cox.net>
 <45B928AD.50508@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 00:33:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAE6O-0000Ek-O5
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 00:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030497AbXAYXdx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 18:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030501AbXAYXdx
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 18:33:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:35208 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030497AbXAYXdx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 18:33:53 -0500
Received: (qmail invoked by alias); 25 Jan 2007 23:33:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 26 Jan 2007 00:33:51 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45B928AD.50508@zytor.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37779>

Hi,

On Thu, 25 Jan 2007, H. Peter Anvin wrote:

> Junio C Hamano wrote:
>
> > Then that would mean 250 calls to git-for-each-ref, wouldn't it?
> 
> Well, I think it was Johannes that said once for each ref.  But either 
> which way, it's a totally unacceptable load with resulting unacceptable 
> latency.

No. I would never say that you have to run for-each-ref for each ref. 
That's plain stupid.

BTW I take some satisfaction in that you finally agreed (in another email) 
that some post-creation caching is necessary.

I would be even more satisfied if you finally agreed that it is a good 
practice to separate conceptually different things, and not continued ad 
infinitum (and ad nauseam) arguing that .git/info/refs should serve dumb 
transports, and gitweb, and eventually bring peace to everybody on this 
planet.

Ciao,
Dscho
