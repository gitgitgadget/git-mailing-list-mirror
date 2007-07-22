From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Sun, 22 Jul 2007 20:24:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707222023360.14781@racer.site>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
 <Pine.LNX.4.64.0707221511410.29679@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 21:24:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICh2u-0004XF-5L
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 21:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762321AbXGVTYo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 15:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762318AbXGVTYo
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 15:24:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:56856 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756508AbXGVTYn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 15:24:43 -0400
Received: (qmail invoked by alias); 22 Jul 2007 19:24:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp013) with SMTP; 22 Jul 2007 21:24:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/SSH8J7LnSvE/J1mxQFrQj8UbsefsM5rBDzhbrb9
	T6KbOrS64Q+sl/
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707221511410.29679@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53303>

Hi,

On Sun, 22 Jul 2007, Daniel Barkalow wrote:

> On Sun, 22 Jul 2007, Johannes Schindelin wrote:
> 
> > A word of warning: switching to _same_ branch that is checked out in
> > the other repository is asking for trouble.  You are really working not
> > only on the same object database, but also the same (i.e. not copied)
> > refs namespace.
> 
> It's probably time to revive Junio's patch for keeping the 
> fully-dereferenced value of HEAD in the index, to make this safer.

Yeah, probably.

Anyway, I will probably run with 'master'+this patch until 1.5.3 is 
released.

Ciao,
Dscho
