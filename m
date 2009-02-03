From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cvs2git migration - cloning CVS repository
Date: Wed, 4 Feb 2009 00:02:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902040000000.9822@pacific.mpi-cbg.de>
References: <286817520902020624y7f4c2942l34fafc0fe0fa0b48@mail.gmail.com>  <49883C52.3060102@alum.mit.edu>  <alpine.DEB.1.00.0902031348570.6573@intel-tinevez-2-302> <46d6db660902031454r1142082cu739a4d6186bc3d2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Rostislav Svoboda <rostislav.svoboda@gmail.com>,
	git@vger.kernel.org
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 00:03:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUUIT-0008AA-0s
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 00:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbZBCXBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 18:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbZBCXBr
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 18:01:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:49406 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751328AbZBCXBq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 18:01:46 -0500
Received: (qmail invoked by alias); 03 Feb 2009 23:01:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp003) with SMTP; 04 Feb 2009 00:01:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jiJNLl5yjIIVjs3zyig7AqwnapIxITfGaFjoiHS
	PrDImSFurOMlD2
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <46d6db660902031454r1142082cu739a4d6186bc3d2e@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108261>

Hi,

On Tue, 3 Feb 2009, Christian MICHON wrote:

> On Tue, Feb 3, 2009 at 1:55 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Tue, 3 Feb 2009, Michael Haggerty wrote:
> >
> >> If you do not have filesystem access to your CVS repository, you might
> >> be able to clone it using CVSSuck [2,3].
> >
> > A substantially faster option would be to go with cvsclone:
> >
> >        http://samba.org/ftp/tridge/rtc/cvsclone.l
> >
> > (in my case, cvsclone was not only faster, but it actually worked, too,
> > which is more than I could say of CVSSuck).
> >
> 
> fantastic, really! :)
> it saves almost half a day of git-cvsimport on vim7 cvs official repository.
> 
> Dscho rulez... Kudos...

Hey, thanks!

For interested parties, I set up a repository at

	http://repo.or.cz/w/cvsclone.git

Note: this is by no means an official repository, and it contains 
adaptations I needed for a very special case (which cost me 1 week to find 
out what the problem was, and a day to fix, and 2 months later, they 
switched to Subversion ;-)

Ciao,
Dscho
