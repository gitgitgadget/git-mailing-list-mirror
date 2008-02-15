From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bisect view: check for MinGW32 and MacOSX in addition
 to X11
Date: Fri, 15 Feb 2008 12:50:50 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802151249290.30505@racer.site>
References: <alpine.LSU.1.00.0802141228300.30505@racer.site> <Pine.LNX.4.64.0802151038520.18292@ds9.cixit.se> <alpine.LSU.1.00.0802151050340.30505@racer.site> <Pine.LNX.4.64.0802151346000.18292@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Feb 15 13:51:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ02M-0008I3-Dg
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 13:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538AbYBOMuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 07:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754430AbYBOMuz
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 07:50:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:43848 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754272AbYBOMuy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 07:50:54 -0500
Received: (qmail invoked by alias); 15 Feb 2008 12:50:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 15 Feb 2008 13:50:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xVk5Ze4MxYle1w0hHZedTOKDHLvIWv3ubGEeoqz
	6Xr1u3fZ2BoMwI
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0802151346000.18292@ds9.cixit.se>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73955>

Hi,

On Fri, 15 Feb 2008, Peter Karlsson wrote:

> Johannes Schindelin:
> 
> > Can you please test?  The we could at least add a "Tested-by:" to the 
> > commit message.
> 
> When starting from the "Git bash" shell, it works.

Great.

> When starting from a Cygwin prompt, it does not work ($MSYSTEM is not 
> set).

That is expected.  You _can_ ssh into Cygwin, so we need a way to tell if 
this is a desktop session or a terminal session.  If you have ideas how to 
tell that, please tell me.

Ciao,
Dscho
