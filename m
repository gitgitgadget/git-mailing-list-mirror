From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] hg-to-git: add --verbose option
Date: Mon, 26 May 2008 14:14:49 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805261414140.30431@racer>
References: <alpine.DEB.1.00.0805261344420.30431@racer> <200805261509.49841.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Stelian Pop <stelian@popies.net>,
	gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 26 15:15:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0cY3-0008En-Uq
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 15:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbYEZNOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 09:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbYEZNOp
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 09:14:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:53435 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751269AbYEZNOo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 09:14:44 -0400
Received: (qmail invoked by alias); 26 May 2008 13:14:42 -0000
Received: from R4980.r.pppool.de (EHLO racer.local) [89.54.73.128]
  by mail.gmx.net (mp031) with SMTP; 26 May 2008 15:14:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180AZ1wCYw0kby/PkfUZQgp8i9wG/nxW/kthgzDbT
	nR+ZnsNK4xlfaf
X-X-Sender: gene099@racer
In-Reply-To: <200805261509.49841.johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82930>

Hi,

On Mon, 26 May 2008, Johan Herland wrote:

> On Monday 26 May 2008, Johannes Schindelin wrote:
>
> > @@ -75,15 +76,18 @@ def getgitenv(user, date):
> >
> >  state = ''
> >  opt_nrepack = 0
> > +verbose = ''
> 
> Maybe this should be
> 	verbose = false
> since it indicates your intent to exclusively use this variable as a
> boolean.

Now, that is not even funny, as that was my initial version, and Python 
complained about not knowing "false".

Ciao,
Dscho
