From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-config: replaces ~/.gitconfig symlink with real file
Date: Tue, 17 Jul 2007 21:48:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707172145590.14781@racer.site>
References: <f158199e0707151427h52da3e38rae3be6e44e27e918@mail.gmail.com>
 <dbfc82860707160237v6772b5b8o541f2045ccd824d5@mail.gmail.com>
 <f158199e0707160433v27fe7073w9c550712c41c32e8@mail.gmail.com>
 <f158199e0707160626j1025ab2cp3339ca6ab91d9af0@mail.gmail.com>
 <Pine.LNX.4.64.0707170834040.14781@racer.site> <m3wswyojj2.fsf@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Fredrik Tolf <fredrik@dolda2000.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 22:49:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAtyZ-00084M-0Y
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 22:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936379AbXGQUsd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 16:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935912AbXGQUsc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 16:48:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:50251 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S936379AbXGQUsb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 16:48:31 -0400
Received: (qmail invoked by alias); 17 Jul 2007 20:48:29 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 17 Jul 2007 22:48:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/1cMIXYO/1jDOjt4XZn3laRPRHzxpmSJZXUUXyCi
	Tv/CVgHAob7BDf
X-X-Sender: gene099@racer.site
In-Reply-To: <m3wswyojj2.fsf@pc7.dolda2000.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52800>

Hi,

On Tue, 17 Jul 2007, Fredrik Tolf wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 16 Jul 2007, Bradford Smith wrote:
> >
> >> So, I guess I need to add a GIT_CONFIG_HOME environment variable.  If I 
> >> get that done, I'll send a patch to the list including doc updates.
> >
> > Alternatively, you could actually not ignore my hint at readlink(2) and 
> > have a proper fix, instead of playing games with environment variables.
> 
> Wouldn't it be nicer to avoid a lot of the complexity in checking 
> symlinks, environment variables and what not, and just overwrite the 
> file in place (with open(..., O_TRUNC | O_CREAT))? Does it happen 
> terribly often that git-config crashes in the middle and leaves the file 
> broken?

No, it does not.  But when it does, I am not only annoyed.  I am PISSED!

The way we do it is the only safe way to do it, and I gladly spend some 
extra cycles for that.  Too often, a small hard disk glitch (or just an 
empty laptop battery!) took some important data into the void.  Too often, 
I _cursed_ at the machine, even if it was the programmers' fault.

Ciao,
Dscho
