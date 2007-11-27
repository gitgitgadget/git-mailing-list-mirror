From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Tue, 27 Nov 2007 11:39:32 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711271136050.27959@racer.site>
References: <200711252248.27904.jnareb@gmail.com> <fiet88$68n$1@ger.gmane.org>
 <e5bfff550711261125i92fb057i85d7217b18cd495d@mail.gmail.com>
 <20071127012013.GG14735@spearce.org> <fifstd$ilj$1@ger.gmane.org>
 <20071127015833.GL14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 12:39:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwynE-0002lX-RY
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 12:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170AbXK0Lji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 06:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753656AbXK0Lji
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 06:39:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:35543 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753436AbXK0Lji (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 06:39:38 -0500
Received: (qmail invoked by alias); 27 Nov 2007 11:39:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 27 Nov 2007 12:39:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Lo2gcN6xL1wnYGZJXSgqDO91fZLPlujvQ5SHdwW
	4UzgkKTnpm76vt
X-X-Sender: gene099@racer.site
In-Reply-To: <20071127015833.GL14735@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66194>

Hi,

On Mon, 26 Nov 2007, Shawn O. Pearce wrote:

> Actually I might revisit this XUL concept using an HTTP server and AJAX.  
> I could actually link the damn HTTP server against libgit.a (Junio will 
> hate me).  If the server dies XUL can notice it and simply restart it.

But if you can restart the HTTP server via XUL, you can start other git 
programs directly.

What you'd have to do is (urgh) write a wrapper via start_command() 
which would recognize that the second process die()d.

All in all, I think if you want to switch from Tcl/Tk to another language 
for git-gui, for the sake of attracting more developers, it might be wiser 
to go Java than XUL.

Ciao,
Dscho
