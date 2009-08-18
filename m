From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: [PATCH 02/11] Fix declare variable at mid of
 function
Date: Tue, 18 Aug 2009 11:34:06 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908181132470.4680@intel-tinevez-2-302>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>  <1250524872-5148-2-git-send-email-lznuaa@gmail.com>  <alpine.DEB.1.00.0908171827040.4991@intel-tinevez-2-302> <3f4fd2640908170934w4c48ada1o66745f845ecb7d49@mail.gmail.com>
 <alpine.DEB.1.00.0908172134150.8306@pacific.mpi-cbg.de> <4A8A3ADE.9010703@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Reece Dunn <msclrhd@googlemail.com>, Frank Li <lznuaa@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 11:34:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdL58-0005bg-8t
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 11:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755017AbZHRJeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 05:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754949AbZHRJeI
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 05:34:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:35484 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754767AbZHRJeG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 05:34:06 -0400
Received: (qmail invoked by alias); 18 Aug 2009 09:34:07 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp064) with SMTP; 18 Aug 2009 11:34:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18RcP8F+kkR8KK605u+nMQGYbCNGAA8Q3IZe96gaH
	h65i/CLtJO4Xau
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4A8A3ADE.9010703@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126361>

Hi,

On Tue, 18 Aug 2009, Marius Storm-Olsen wrote:

> Johannes Schindelin said the following on 17.08.2009 21:36:
> 
> > On Mon, 17 Aug 2009, Reece Dunn wrote:
> > 
> > > 2009/8/17 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > >
> > > > On Tue, 18 Aug 2009, Frank Li wrote:
> > > >
> > > > > Some compiler such as MSVC can't support declear variable at mid of
> > > > > funtion at c file.
> > > > Please wrap your commit messages after 76 characters.
> > > >
> > > > > Signed-off-by: Frank Li <lznuaa@gmail.com>
> > > > > ---
> > > > How about this instead?
> > > >
> > > >        Avoid declaration after instruction
> > > >
> > > >        Microsoft Visual C++ does not understand this C99 style.
> > > >
> > > > ?
> > > >
> > > > The patch itself is good.
> > > Shouldn't GCC be changed to use -std=c89 as well to pick up errors for
> > > compilers that don't support c99 (like the Microsoft Visual C++ C
> > > compiler)?
> > 
> > Hmm.  I played with the thought of adding -Werror -Wno-pointer-to-int-cast
> > -Wold-style-definition -Wdeclaration-after-statement like Junio described in
> > one of his mails for MinGW (as we _know_ what compiler we have there).
> > 
> > Dunno.
> 
> IMO it would be a good change. We should  not have any of those anyways..

Okay, I will wait for Frank's updates (just fetched tgit.git and it still 
contains the old branch), merge the early part and add the compiler flags.

Ciao,
Dscho
