From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] MinGW: Use pid_t more consequently, introduce uid_t
  for greater compatibility
Date: Thu, 31 Dec 2009 15:12:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912311511350.4985@pacific.mpi-cbg.de>
References: <hhbldr$di8$1@ger.gmane.org> <4B3A7000.4050308@kdbg.org> <bdca99240912291649h1c727072q3b1e4099cab426df@mail.gmail.com> <4B3CAC2D.5050500@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Dec 31 15:08:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQLhr-0001D3-CM
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 15:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbZLaOHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 09:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbZLaOHt
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 09:07:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:49846 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751926AbZLaOHt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 09:07:49 -0500
Received: (qmail invoked by alias); 31 Dec 2009 14:07:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 31 Dec 2009 15:07:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7iiVzOXO7csxNMI/SByiacDHqxpZpIBaj53nI7s
	pfMhDgIqkucbSB
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4B3CAC2D.5050500@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135950>

Hi,

On Thu, 31 Dec 2009, Johannes Sixt wrote:

> Sebastian Schuberth schrieb:
> > On Tue, Dec 29, 2009 at 22:09, Johannes Sixt <j6t@kdbg.org> wrote:
> > 
> > > > MinGW: Use pid_t more consequently, introduce uid_t for greater
> > > > compatibility
> > > Why this? Compatibility with what? What's the problem with the status quo?
> > 
> > I wanted to include Hany's Dos2Unix tool (hd2u) into msysGit.
> 
> We have dos2unix. What's wrong with it?

hd2u can handle mixed line endings, and it has a dry run mode IIUC.

Ciao,
Dscho
