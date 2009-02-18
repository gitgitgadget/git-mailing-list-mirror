From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Introduce the function strip_path_suffix()
Date: Thu, 19 Feb 2009 00:18:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902190017460.10279@pacific.mpi-cbg.de>
References: <cover.1234969572u.git.johannes.schindelin@gmx.de> <7b5ee74d497bbb7144b8683725cd83c8bbd33f9a.1234969572u.git.johannes.schindelin@gmx.de> <499C63E7.5040306@kdbg.org> <alpine.DEB.1.00.0902182211550.10279@pacific.mpi-cbg.de>
 <499C8B44.1020106@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 00:18:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZvgl-0006lC-HU
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 00:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbZBRXRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 18:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753271AbZBRXRS
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 18:17:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:44695 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752609AbZBRXRS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 18:17:18 -0500
Received: (qmail invoked by alias); 18 Feb 2009 23:17:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp054) with SMTP; 19 Feb 2009 00:17:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18q/uJsVjsq6jmjQv1QdywEB9/Mh7mLeBcOeXPhlM
	ADNDDeH+jVERds
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <499C8B44.1020106@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110592>

Hi,

On Wed, 18 Feb 2009, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > On Wed, 18 Feb 2009, Johannes Sixt wrote:
> > > Johannes Schindelin schrieb:
> > > >  strip_path_suffix("C:\\msysgit/\\libexec\\git-core",
> > > >   "libexec///git-core", &prefix)
> > > >
> > > > will set prefix to "C:\\msysgit" and return 0.
> > > But you implemented it so that prefix is actually "C:\\msysgit/\\"
> > > (unless, of course, I'm reading the code wrong).
> > 
> > This is supposed to handle that case:
> > 
> >  *prefix = xstrndup(path, chomp_trailing_dir_sep(path, path_len));
> 
> Ah, I missed that final call of chomp_trailing_dir_sep.

I have to admit that I was aware of the fact that it is easy to miss, but 
could not find a better way to present it.

Ciao,
Dscho
