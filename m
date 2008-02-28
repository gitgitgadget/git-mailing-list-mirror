From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/40] Add target architecture MinGW.
Date: Thu, 28 Feb 2008 14:56:24 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802281455440.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281159550.22527@racer.site> <47C6AFA4.9040304@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 15:58:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUkCz-0004NP-MG
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 15:58:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337AbYB1O5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 09:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759218AbYB1O5A
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 09:57:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:40242 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758238AbYB1O44 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 09:56:56 -0500
Received: (qmail invoked by alias); 28 Feb 2008 14:56:54 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 28 Feb 2008 15:56:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18JdKBnjdcJ3KkU3PZ4o6RL5egBeF5KgX02NsoRcu
	Kvbu8jiMzh9JDH
X-X-Sender: gene099@racer.site
In-Reply-To: <47C6AFA4.9040304@gnu.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75403>

Hi,

On Thu, 28 Feb 2008, Paolo Bonzini wrote:

> Johannes Schindelin wrote:
> 
> > On Wed, 27 Feb 2008, Johannes Sixt wrote:
> > 
> > > +int gettimeofday(struct timeval *tv, void *tz)
> > > +{
> > > +	return 0;
> > > +}
> > 
> > Should it not return -1, for failure?  (I know, I know, probably a few
> > programs do not work, then, but it is not correct that it succeeded.)
> 
> FWIW, this is overwritten by later patches in the series anyway.

Yes, I know that.  But the whole point of having a nice patch series is to 
have proper revisions, and IMO returning 0 here is not correct.

Ciao,
Dscho
