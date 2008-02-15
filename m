From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bisect view: check for MinGW32 and MacOSX in addition
 to X11
Date: Fri, 15 Feb 2008 10:51:15 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802151050340.30505@racer.site>
References: <alpine.LSU.1.00.0802141228300.30505@racer.site> <Pine.LNX.4.64.0802151038520.18292@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Feb 15 11:52:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPyAp-0001N6-Eq
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 11:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765422AbYBOKvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 05:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762577AbYBOKvV
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 05:51:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:43770 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759311AbYBOKvU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 05:51:20 -0500
Received: (qmail invoked by alias); 15 Feb 2008 10:51:18 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp024) with SMTP; 15 Feb 2008 11:51:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+biqslPUubnp4J1Gk7QWjbcPb9cVrKm5e3ryZ+xD
	QuB/SY+lszzmIx
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0802151038520.18292@ds9.cixit.se>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73952>

Hi,

On Fri, 15 Feb 2008, Peter Karlsson wrote:

> Johannes Schindelin:
> 
> > When deciding if gitk or git-log should be used to visualize the 
> > current state, the environment variable DISPLAY was checked.  Now, we 
> > check MSYSTEM (for MinGW32/MSys) and SECURITYSESSIONID (for MacOSX) in 
> > addition.
> 
> That was quick! I haven't tried it, but I guess it should solve the 
> problem I was seeing.

Can you please test?  The we could at least add a "Tested-by:" to the 
commit message.

Thanks,
Dscho
