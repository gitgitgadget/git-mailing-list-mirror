From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Don't rely on unspecified behavior
Date: Sat, 28 Jul 2007 21:16:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707282115450.14781@racer.site>
References: <20070728173948.GD23337@cip.informatik.uni-erlangen.de>
 <11856471952272-git-send-email-tschwinge@gnu.org> <Pine.LNX.4.64.0707282028130.14781@racer.site>
 <20070728193402.GE23337@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Sat Jul 28 22:16:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEsi3-0003Ex-R3
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 22:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116AbXG1UQR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 16:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755090AbXG1UQR
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 16:16:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:50127 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751901AbXG1UQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 16:16:16 -0400
Received: (qmail invoked by alias); 28 Jul 2007 20:16:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 28 Jul 2007 22:16:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18txrFaeiotRh2WZ8T8Coq4yejqKVsNi5jfq8SrXd
	IYqjxA0acNASSC
X-X-Sender: gene099@racer.site
In-Reply-To: <20070728193402.GE23337@cip.informatik.uni-erlangen.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54059>

Hi,

On Sat, 28 Jul 2007, Thomas Glanzmann wrote:

> > Isn't this the same patch as you sent before?
> 
> > > @@ -74,7 +74,7 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec)
> > > @@ -60,7 +60,7 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec,
>        ~~~~~ ~~~~~                                                                            ~
> 
> The offset of the diff has changed. Not that git couldn't sort it out by
> itself. And the function had one or more parameters less.

Ah.  Thanks for the explanation.

Ciao,
Dscho
