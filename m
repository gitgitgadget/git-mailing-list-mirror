From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 22/40] Windows: Implement asynchronous functions as
 threads.
Date: Fri, 29 Feb 2008 10:26:31 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802291023060.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-23-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281525510.22527@racer.site> <47C6F40A.4010703@comcast.net> <alpine.LSU.1.00.0802290122110.22527@racer.site>
 <47C76407.3090804@comcast.net> <alpine.LSU.1.00.0802290150440.22527@racer.site> <47C77720.2080405@comcast.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Paul Franz <thefranz@comcast.net>
X-From: git-owner@vger.kernel.org Fri Feb 29 11:27:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV2Sv-0001HB-Or
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 11:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203AbYB2K1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 05:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755091AbYB2K1I
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 05:27:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:37771 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754366AbYB2K1G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 05:27:06 -0500
Received: (qmail invoked by alias); 29 Feb 2008 10:27:04 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp005) with SMTP; 29 Feb 2008 11:27:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19uNL04NzhukNSLKyfiqIyfIt+pVg222vx+dyhlJc
	JGIslxLZlcRmCg
X-X-Sender: gene099@racer.site
In-Reply-To: <47C77720.2080405@comcast.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75519>

Hi,

On Thu, 28 Feb 2008, Paul Franz wrote:

> Johannes Schindelin wrote:
> 
> > [top-posting?]
> 
> Is there something wrong with it?

My favourite way to describe it (a quote):

+A: Because it messes up the order in which people normally read text.
+Q: Why is top-posting such a bad thing?
+A: Top-posting.
+Q: What is the most annoying thing on usenet and in e-mail?

> > The problems with Git and Windows are not network related.  They are 
> > with Windows' pitiful performance when it comes to spawn processes.
>
> Which makes me believe that it sounds like git depends on spawning 
> processes being cheap.

Yes, like everything that relies on being scriptable.

> > IMO your efforts to help Git on Windows would be better spent on the 
> > msysGit list, where you would learn about the real issues we face.
> 
> Excuse my ignorance, could you tell me where the mysGit list is, so that 
> I can subscribe?

It is referenced right on the first page on

	http://msysgit.googlecode.com/

under the keyword "Groups:".

Hth,
Dscho

