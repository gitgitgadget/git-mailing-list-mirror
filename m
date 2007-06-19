From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] make dist: include configure script in tarball
Date: Tue, 19 Jun 2007 10:34:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706191033480.4059@racer.site>
References: <20070618213036.GA7222@moooo.ath.cx> <f578a4$6mm$1@sea.gmane.org>
 <Pine.LNX.4.64.0706190203111.4059@racer.site> <7v1wg8y8ja.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 11:34:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0a6I-00014s-8D
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 11:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbXFSJeM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 05:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbXFSJeM
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 05:34:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:40323 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751069AbXFSJeL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 05:34:11 -0400
Received: (qmail invoked by alias); 19 Jun 2007 09:34:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 19 Jun 2007 11:34:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18lqcFomasl9YJEDjK4PVdVDE4UBw09vifnNiC+Ot
	QgNbv/PviZY3qw
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1wg8y8ja.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50461>

Hi,

On Mon, 18 Jun 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 19 Jun 2007, Jakub Narebski wrote:
> >
> >> Matthias Lederhofer wrote:
> >> 
> >> > +dist: git.spec git-archive configure
> >> 
> >> Ack. This way you don't need autoconf to ./configure install.
> >
> > ... but you force our good maintainer to have it installed...
> 
> Which is fine by me.

Good. That was the kind of Ack I was waiting for.

> I was wondering why this wish did not surface much earlier myself.

When I was trying to be lazy, and ran configure myself on some machine 
(sorry, don't remember which one, might well be a MinGW setup), it did not 
work. So I did not push for it.

> Not that I'd use "./configure" myself nor help debugging the 
> autoconf-generated shell scripts ;-).

I fully understand.

Ciao,
Dscho
