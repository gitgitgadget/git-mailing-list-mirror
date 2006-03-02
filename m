From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: windows problems summary
Date: Thu, 2 Mar 2006 18:33:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603021833360.31727@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0603020649u99a2035i3b8adde8ddce9410@mail.gmail.com> 
 <Pine.LNX.4.63.0603021636020.30490@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0603020833j214556bek887c53a3ef43fd58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 02 18:34:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FErgt-00087n-Q6
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 18:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWCBRdu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 12:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWCBRdt
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 12:33:49 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:3751 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932300AbWCBRds (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 12:33:48 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id E56831AD5;
	Thu,  2 Mar 2006 18:33:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id D7C2B5C87;
	Thu,  2 Mar 2006 18:33:47 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id C57BF1AD5;
	Thu,  2 Mar 2006 18:33:47 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0603020833j214556bek887c53a3ef43fd58@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17098>

Hi,

On Thu, 2 Mar 2006, Alex Riesen wrote:

> On 3/2/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > > 1. opened and mmaped files can't be removed or renamed
> > >   (caused workaround with reading index in memory)
> >
> > It was not the locking which caused the workaround. It was the
> > not-working. (I still have to find a Windows machine where git-whatchanged
> > does not segfault without NO_MMAP.)
> 
> me too. It crashes everywhere here.
> 
> > > 4. non-unix permissions model
> > >   (breaks x-attr)
> > > 5. real slow filesystems and caching
> > >   (makes everything slow. I noticed I'm trying to avoid git status!).
> > >   Caused workaround with manual checkout)
> > > 6. real slow program startup
> > >   (makes everything slow, eventually may cause everything being put
> > >   in one super-executable, just to avoid spawning new processes,
> > >   with all associated problems. Makes scripting harder)
> >
> > Except for (4), these issues should be resolvable by the libifying effort.
> >
> 
> How can it help with 5? Less accesses to index?

Exactly.

Ciao,
Dscho
