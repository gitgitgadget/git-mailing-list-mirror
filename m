From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 21:19:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710152117290.25221@racer.site>
References: <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net>
 <Pine.LNX.4.64.0710150217120.25221@racer.site> <20071015175606.GE2966@steel.home>
 <4713B367.52CEC7E2@dessent.net> <Pine.LNX.4.64.0710151938300.25221@racer.site>
 <4713BA89.633B86F2@dessent.net> <20071015194214.GC15541@steel.home>
 <4713C81F.A75FEFC2@dessent.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, Eli Zaretskii <eliz@gnu.org>,
	ae@op5.se, tsuna@lrde.epita.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 23:12:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhWQC-0007zt-Hp
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 22:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757627AbXJOUUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 16:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934117AbXJOUUD
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 16:20:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:51834 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757627AbXJOUUA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 16:20:00 -0400
Received: (qmail invoked by alias); 15 Oct 2007 20:19:56 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp029) with SMTP; 15 Oct 2007 22:19:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ixQZPO0sixadYOJGVfNsbqRwfcwSfcU1cL+Y0y6
	y9rIV6X0ofcJPs
X-X-Sender: gene099@racer.site
In-Reply-To: <4713C81F.A75FEFC2@dessent.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61038>

Hi,

On Mon, 15 Oct 2007, Brian Dessent wrote:

> Well, instead of using an MSYS build of Perl there's always ActiveState 
> Perl.

No, but thanks no.  You haven't been around long enough on this list to 
count the issues, but it is known that ActiveState Perl is close to 
Malbolge.

>  I think you may be stuck on the shell though -- I don't know of any 
> ports of bash that aren't MSYS or Cygwin based.  However I do think 
> there's a native port of zsh out there by the GnuWin32 project, which 
> when renamed as just "/bin/sh" might be suitable, but only if these 
> scripts don't use bash-isms.  I have not tried this zsh myself and 
> speed/compatibility wise I'm not sure it's up to snuff.

There is a port of BusyBox' dash, which is nearing completion.  Once 
Nguyen says it is ready enough, we will try to integrate it into msysGit.

Ciao,
Dscho
