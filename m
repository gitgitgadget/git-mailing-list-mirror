From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Temporary directories getting errantly added into trees
Date: Thu, 22 Nov 2007 11:30:40 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711221129170.27959@racer.site>
References: <4744FCD9.7020102@vilain.net>  <Pine.LNX.4.64.0711221052280.27959@racer.site>
 <46a038f90711220301o1cbb16b7g79eea541f8ca5e58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>, Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:31:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvAGs-000248-GL
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbXKVLap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbXKVLap
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:30:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:59854 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751676AbXKVLao (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 06:30:44 -0500
Received: (qmail invoked by alias); 22 Nov 2007 11:30:42 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp051) with SMTP; 22 Nov 2007 12:30:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Yi3hCKe2Y+wToTAHsAljzujOK+Vqgfj4gm5D7f0
	h/UB2YHRRH0Fd3
X-X-Sender: gene099@racer.site
In-Reply-To: <46a038f90711220301o1cbb16b7g79eea541f8ca5e58@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65800>

Hi,

On Fri, 23 Nov 2007, Martin Langhoff wrote:

> On Nov 22, 2007 11:55 PM, Johannes Schindelin
> 
> > ... And indeed, I see no reason why a tool should access .dotest, 
> > except for accessing .dotest/patch, and then it will be very obvious 
> > where it fails.
> 
> when it comes to .dotest/patch, it must be reasonably accessible. When 
> git-am refuses to apply a patch, and I am resolving things by hand, I 
> need it pretty handy. I also sometimes edit .dotest/msg-clean.

Maybe install a .dotest/ symlink for a few "git eons", i.e. some 6 months?

Although this will not work on Windows, I see not much problems in it, 
since Windows users are not big in scripting (at least the git 
type) anyway.

Ciao,
Dscho
