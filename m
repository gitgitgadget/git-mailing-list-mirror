From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: multiple checked out branches
Date: Wed, 1 Aug 2007 23:39:47 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708012338250.14781@racer.site>
References: <20070801220435.GA19226@raptus.dandreoli.com> <20070801223430.GC2911@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Domenico Andreoli <cavokz@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 00:40:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGMrZ-0000hX-Mx
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 00:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbXHAWkP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 18:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbXHAWkO
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 18:40:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:59374 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752564AbXHAWkN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 18:40:13 -0400
Received: (qmail invoked by alias); 01 Aug 2007 22:40:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 02 Aug 2007 00:40:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5IMBPZpL56PHNcJHSWE7YSlRU0bY0ZJ3di9LvVX
	2mpO7ozHJSVbXz
X-X-Sender: gene099@racer.site
In-Reply-To: <20070801223430.GC2911@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54493>

Hi,

On Thu, 2 Aug 2007, Alex Riesen wrote:

> Domenico Andreoli, Thu, Aug 02, 2007 00:04:35 +0200:
> > 
> >   I would like to contemporaneously work with multiple branches out of
> > the same git repository. This does not work out of the box.
> > 
> > So I prepare multiple copies of the same repository, every one will have
> > its own checked out branch but I want to share most of their .git subdir.
> > 
> > I surely want to share the object db, the local and remote refs.
> > This way it is enough to make a round of fetches/merges/pushes to have
> > all the shared-repositories up to date.
> > 
> > I expect to do the trick with some symlinks but I am not an expert of
> > git internals. Which traps are waiting me? Any hint? Thank you.
> > 
> 
> No traps. Supported. See for "git clone -s" and "git clone -l"

That is not completely what is wanted, AFAIU:  "git clone -s" and "git 
clone -l" allow for unsynchronised branches.  For example, when you 
committed to branch "foo" in the cloned repo, branch "foo" in the original 
repo will be older until you push.

Ciao,
Dscho
