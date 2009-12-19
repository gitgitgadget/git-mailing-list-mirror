From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] read-tree: at least one tree-ish argument is
 required
Date: Sat, 19 Dec 2009 11:56:35 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912191155360.4985@pacific.mpi-cbg.de>
References: <4B274BDE.8000504@viscovery.net> <fabb9a1e0912181137t1265f86cs9e02019da136a0a@mail.gmail.com> <7veimsvz8a.fsf@alter.siamese.dyndns.org> <200912182304.27656.j.sixt@viscovery.net> <m3d42cc4i8.fsf@localhost.localdomain> <7vr5qrsv4g.fsf@alter.siamese.dyndns.org>
 <20091219122509.6117@nanako3.lavabit.com> <7veimrmv3r.fsf@alter.siamese.dyndns.org> <7vfx77lg2s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 11:51:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLwuh-0007WF-0O
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 11:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbZLSKvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 05:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbZLSKvu
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 05:51:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:35052 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750719AbZLSKvt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 05:51:49 -0500
Received: (qmail invoked by alias); 19 Dec 2009 10:51:47 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 19 Dec 2009 11:51:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Ee95oPvvELzYz7i+AObFx/n3YcCat7EkTOQ/how
	lOTmhhqb64EUTf
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vfx77lg2s.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135472>

Hi,

On Fri, 18 Dec 2009, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > As read-tree is a very basic and low-level Porcelain, if somebody were 
> > using it to empty the index in an existing script, this change would 
> > appear as a regression and hopefully will be caught eventually, and 
> > updating such a script can be made reasonably easy if we want to be 
> > helpful (the error message can suggest running "rm $GIT_DIR/index", 
> > for example).
> 
> IOW, I would prefer to queue something like this in the upcoming 
> version, and then later make it die().  I do not think anybody relies on 
> it, but we have been wrong before.  If the warning doesn't trigger for 
> anybody, that is also fine as well.

I fully expect it not to trigger for anybody (except maybe you, if you 
have hidden a script somewhere that uses read-tree to empty the index), 
because at least for this developer, the standard way of emptying the 
index is simply "rm .git/index".

Ciao,
Dscho
