From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to change a submodue as a subdirectory?
Date: Thu, 15 Nov 2007 06:16:12 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711150614380.4362@racer.site>
References: <46dff0320711140637s51e1368fv3f632b6f04d093d5@mail.gmail.com> 
 <20071114202651.GC3973@steel.home> <46dff0320711142136r2c70d698vd380c02188f95507@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 07:16:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsY1w-00056v-7h
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 07:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760942AbXKOGQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 01:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbXKOGQd
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 01:16:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:45927 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762457AbXKOGQb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 01:16:31 -0500
Received: (qmail invoked by alias); 15 Nov 2007 06:16:29 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp012) with SMTP; 15 Nov 2007 07:16:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/CTY0DAFPC8f2mSnfLOGAxzEjiIsYgSDOykVTJLI
	TSpYCQAUkHJ5aV
X-X-Sender: gene099@racer.site
In-Reply-To: <46dff0320711142136r2c70d698vd380c02188f95507@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65064>

Hi,

On Thu, 15 Nov 2007, Ping Yin wrote:

> On Nov 15, 2007 4:26 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
> > Ping Yin, Wed, Nov 14, 2007 15:37:57 +0100:
> > > I have a super project superA, and a submodue subB. Now i decide to
> > > switch subB from submodule to sub directory. Any good way to do that
> > > and not losing any history?
> >
> > $ mv subB sub
> > $ git add sub
> > $ git update-index --force-remove subB
> > $ git commit
> >
> > Which history were you afraid of losing?
> >
> I want to keep the history of the submodule

Provided you do not kill the repository of the submodule (you have some 
public repo for that, right?) you will not lose anything, since the 
history of the superproject has pointers to the submodule.

But I guess that you want something different... You probably want to 
rewrite history as if the submodule had not been a submodule at all, 
right?

Ciao,
Dscho
