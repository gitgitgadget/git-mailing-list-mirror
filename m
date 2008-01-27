From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Is there a reason to keep walker.c ?
Date: Sun, 27 Jan 2008 20:46:59 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801272045490.23907@racer.site>
References: <20080127204535.GA4702@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Jan 27 21:47:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJEPt-0007nh-GL
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 21:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbYA0UrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 15:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753890AbYA0UrS
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 15:47:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:60015 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753912AbYA0UrR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 15:47:17 -0500
Received: (qmail invoked by alias); 27 Jan 2008 20:47:16 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp047) with SMTP; 27 Jan 2008 21:47:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18jzAlEw/4jqPsQ+3uQLotQRpygeBC1cg2r2DwuMT
	7ztiefZQFPWoHL
X-X-Sender: gene099@racer.site
In-Reply-To: <20080127204535.GA4702@glandium.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71830>

Hi,

On Sun, 27 Jan 2008, Mike Hommey wrote:

> While working on the http code refactoring, I got to wonder if the 
> walker.c "wrapper", that is only used for the http transport, is still 
> worth keeping. If there are plans for others transport to use this code, 
> obviously, it would be worth keeping, but on the contrary, I think it 
> would simplify the http transport code even more. What do you think ?

Really, I was waiting for somebody needing ftp and/or sftp support badly 
enough, so let's keep it.

I mean, one of those guys asking for ftp push support _got_ to just start 
scratching that itch, right?

Ciao,
Dscho
