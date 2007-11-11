From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: (no subject)
Date: Sun, 11 Nov 2007 15:22:56 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711111520260.4362@racer.site>
References: <Pine.LNX.4.64.0711111359590.9401@castor.milkiway.cos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 16:23:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrEeq-0007cy-D8
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 16:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160AbXKKPXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 10:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754786AbXKKPXK
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 10:23:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:39420 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754307AbXKKPXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 10:23:09 -0500
Received: (qmail invoked by alias); 11 Nov 2007 15:23:06 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp031) with SMTP; 11 Nov 2007 16:23:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184tToVgbU4TaZ3vXgx1swwCShMFZTkcTM6iVe5kI
	Ese/aflaA0nTYi
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711111359590.9401@castor.milkiway.cos>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64469>

Hi,

On Sun, 11 Nov 2007, Michael Dressel wrote:

> 
> >Michael Dressel wrote:
> >Ok nice. Another thing is that git-push will push all the tracking 
> >branches in refs/remotes/origin. 
> 
> I learned that I only have to edit the .git/config file to avoid that 
> git-push pushes everything. 

It is documented that you can use "git push origin <branchname>".

> [remote "origin1"]
>         url = /home/repo/src
>         fetch = +refs/heads/master:refs/remotes/origin/master
>         push = +refs/heads/master:refs/heads/master

With "push", it is not necessary to specify the ":<target>".

Also, if "master" is unambiguous, you can write just "master" instead of 
"refs/heads/master".

Furthermore, I suggest not forcing (that's  what "+" does) the push, since 
it is quite possible that you push something old in the wrong direction.  

Hth,
Dscho
