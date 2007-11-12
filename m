From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git config error message
Date: Mon, 12 Nov 2007 22:24:54 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711122224190.4362@racer.site>
References: <9e4733910711120735p653c643eveb44627bf4532b1a@mail.gmail.com>
 <20071112222317.GF2918@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 23:25:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irhii-0007Wu-64
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 23:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500AbXKLWZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 17:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755756AbXKLWZL
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 17:25:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:42478 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755117AbXKLWZK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 17:25:10 -0500
Received: (qmail invoked by alias); 12 Nov 2007 22:25:08 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp005) with SMTP; 12 Nov 2007 23:25:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+t8hMwcxytpsNbjzM9iKjGswAWSgH3wZpyCcvtHU
	42zS1ffyKaI8Hk
X-X-Sender: gene099@racer.site
In-Reply-To: <20071112222317.GF2918@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64724>

Hi,

On Mon, 12 Nov 2007, Alex Riesen wrote:

> Jon Smirl, Mon, Nov 12, 2007 16:35:07 +0100:
> > I'm not in a git repo, this error message is misleading.
> > 
> > jonsmirl@terra:~/foo$ git config remote.origin.url
> > http://git.digispeaker.com/projects/digispeaker-kernel.git
> > could not lock config file
> > 
> 
> Cygwin or any crashes in this repo lately?
> If cygwin, than we probably have a file handle leak in config code.

He said that he's not in a git repo.  Thus, .git/config does not exist, 
and is not lockable, since not even .git/ exists.

Ciao,
Dscho
