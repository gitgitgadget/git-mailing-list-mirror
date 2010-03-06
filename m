From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git fast-import/fast-export
Date: Sat, 6 Mar 2010 16:29:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003061623511.7596@pacific.mpi-cbg.de>
References: <fabb9a1e1003060702r671b57f4m9308863f566d5fbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Elijah Newren <newren@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 06 22:27:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No15n-0004YU-Jw
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 21:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753629Ab0CFPWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 10:22:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:44861 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752506Ab0CFPWN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 10:22:13 -0500
Received: (qmail invoked by alias); 06 Mar 2010 15:22:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp020) with SMTP; 06 Mar 2010 16:22:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180WhlInkM0Wq4LlETQTLIcn2pFnO4abKulT/EuCQ
	P4cdDYFFkMSvnW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <fabb9a1e1003060702r671b57f4m9308863f566d5fbd@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.56999999999999995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 6 Mar 2010, Sverre Rabbelier wrote:

> As you can read on the wiki [0] I am hoping to mentor a GSoC student 
> this year to work on git-remote-svn, a remote-helper for svn implemented 
> in C. If successful git will be able to work natively with svn 
> repositories, no offense to Eric, but git-svn is a tad sub-optimal ;). 
> To do this I think the best way to go forward is to implement the helper 
> by hooking up a fast-import/fast-export frontend to libsvn. Since it 
> will be implemented in C (partially for speed, but also so that it will 
> be usable on Windows as well), the current fast-import.c and 
> builtin-fast-export.c could be of great use. Neither files have an 
> explicit license, (although builtin-fast-import.c says copyright by 
> Dscho) which puts them under the GPLv2. The libsvn bindings are apache 
> licensed, so we need something licensed either under the apache license, 
> or something compatible with that.
> 
> So my question, would it be possible to relicense fast-import.c and 
> builtin-fast-export.c under "GPLv2 or later" instead of the current 
> "GPLv2"? That way we can use (parts of) the code in the svn helper, 
> which will (probably) be licensed as "GPLv2 or later" as well.

Sure, as far as my parts go, I am fine even with BSD.

Unfortunately, git shortlog shows 18 different authors for fast-export, 
and blame still shows 17 surviving. I fear you have to ask them all.

The situation is worse with fast-import, with 40 and 36 authors, 
respectively.

Ciao,
