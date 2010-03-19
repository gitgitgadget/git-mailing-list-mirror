From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Fri, 19 Mar 2010 22:00:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003192159300.7596@pacific.mpi-cbg.de>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com> <32541b131003191132y119037f8rae598d0037786703@mail.gmail.com> <20100319205301.GA15053@progeny.tock>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1899968212-1269032435=:7596"
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 21:59:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsjHt-0000BK-1L
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 21:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647Ab0CSU7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 16:59:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:54379 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751604Ab0CSU7E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 16:59:04 -0400
Received: (qmail invoked by alias); 19 Mar 2010 20:59:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 19 Mar 2010 21:59:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/CY0cTgynCl8td6MMfh1dZul7xtBE7yOREBYMsog
	SIviuJAaFkA2/f
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100319205301.GA15053@progeny.tock>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142647>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1899968212-1269032435=:7596
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 19 Mar 2010, Jonathan Nieder wrote:

> Avery Pennarun wrote:
> > On Fri, Mar 19, 2010 at 1:18 PM, Ramkumar Ramachandra
> 
> >> The following resources are relevant to the project:
> >> 1. git_remote_helpers/git/git.py is a minimalistic remote helper
> >> written by Sverre. I plan to extend this as much as possible before
> >> rewriting it in C.
> >
> > Are you sure you really want to rewrite git-svn in C?  svn is so slow
> > that interpreted vs. native performance is unlikely to be an issue.
> > git-svn is probably not going to be needed on embedded systems where
> > installing python or perl is a problem.  And managing the data
> > structures in a high-level language should be a lot easier.
> 
> Hmm.  Sverre discussed why this is more about a redesign of svn
> interop support than a C reimplementation of git-svn.  I wouldn’t mind
> if at the end of the summer, all we have is some working Python code.
> Still, it would have to be rewritten in C or Perl before msysgit could
> use it unless some hero packages a Python interpreter for them.

It's not about packaging the interpreter. It is about _compiling_ it, so 
that we can also compile native extensions for performance.

Last time I tried to compile Python with MSys, I gave up. After a full 
week of trying.

Ciao,
Dscho

--8323328-1899968212-1269032435=:7596--
