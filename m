From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] MinGW: Use pid_t more consequently, introduce uid_t
  for greater compatibility
Date: Thu, 31 Dec 2009 15:20:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912311518560.4985@pacific.mpi-cbg.de>
References: <hhbldr$di8$1@ger.gmane.org> <4B3A7000.4050308@kdbg.org> <bdca99240912291649h1c727072q3b1e4099cab426df@mail.gmail.com> <4B3CAC2D.5050500@kdbg.org> <alpine.DEB.1.00.0912311511350.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Dec 31 15:16:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQLnu-0003W4-GF
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 15:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbZLaOPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 09:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752392AbZLaOPA
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 09:15:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:34922 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752388AbZLaOO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 09:14:59 -0500
Received: (qmail invoked by alias); 31 Dec 2009 14:14:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp072) with SMTP; 31 Dec 2009 15:14:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/pHm9dqeTpRiz0r7IVC0/gs3QEF4VFHXe5CFEujV
	ll2SWwSOkb0oFk
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0912311511350.4985@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135952>

Hi,

On Thu, 31 Dec 2009, Johannes Schindelin wrote:

> On Thu, 31 Dec 2009, Johannes Sixt wrote:
> 
> > Sebastian Schuberth schrieb:
> > > On Tue, Dec 29, 2009 at 22:09, Johannes Sixt <j6t@kdbg.org> wrote:
> > > 
> > > > > MinGW: Use pid_t more consequently, introduce uid_t for greater 
> > > > > compatibility
> > > > Why this? Compatibility with what? What's the problem with the 
> > > > status quo?
> > > 
> > > I wanted to include Hany's Dos2Unix tool (hd2u) into msysGit.
> > 
> > We have dos2unix. What's wrong with it?
> 
> hd2u can handle mixed line endings, and it has a dry run mode IIUC.

Having said that, I strongly feel this issue is over-discussed.  We'll 
just carry the necessary patches in 4msysgit.git and you can do what you 
want.

Ciao,
Dscho
