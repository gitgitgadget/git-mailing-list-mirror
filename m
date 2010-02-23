From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Explicitly adding ignored files in subdirectories not working
Date: Tue, 23 Feb 2010 23:11:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002232310520.3980@intel-tinevez-2-302>
References: <fabb9a1e1002231307o2c3499e6k3f1026f71a544b16@mail.gmail.com>  <alpine.DEB.1.00.1002232248000.3980@intel-tinevez-2-302> <fabb9a1e1002231358g20ce98fav375e797bd719c793@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 23:11:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk2yU-0007RB-PV
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 23:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324Ab0BWWLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 17:11:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:45695 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754301Ab0BWWLN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 17:11:13 -0500
Received: (qmail invoked by alias); 23 Feb 2010 22:11:11 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 23 Feb 2010 23:11:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18qgERbqr8qAMpCc5Ws/G+grG7owyu3bxcoi+7eLS
	fRXDc+YXcSTmMv
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <fabb9a1e1002231358g20ce98fav375e797bd719c793@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67000000000000004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140853>

Hi,

On Tue, 23 Feb 2010, Sverre Rabbelier wrote:

> On Tue, Feb 23, 2010 at 22:50, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > $ cd Documentation
> > $ touch doc.dep
> > $ git add doc.dep
> > The following paths are ignored by one of your .gitignore files:
> > Documentation/doc.dep
> > Use -f if you really want to add them.
> > fatal: no files added
> 
> Do you have Documentation ignored? It works fine for ignored files,
> files in _ignored directories_ however... :)

Ah, that's what I missed...

Sorry,
Dscho
