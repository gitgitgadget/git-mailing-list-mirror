From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Mon, 17 Aug 2009 21:53:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>  <1250525103-5184-2-git-send-email-lznuaa@gmail.com>  <1250525103-5184-3-git-send-email-lznuaa@gmail.com>  <1250525103-5184-4-git-send-email-lznuaa@gmail.com>  <1250525103-5184-5-git-send-email-lznuaa@gmail.com>
  <4A899495.8050902@gnu.org> <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-830258759-1250538835=:8306"
Cc: Paolo Bonzini <bonzini@gnu.org>, Frank Li <lznuaa@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:53:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md8Gb-0004D9-Ks
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 21:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654AbZHQTxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 15:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756503AbZHQTxH
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 15:53:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:46671 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755914AbZHQTxG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 15:53:06 -0400
Received: (qmail invoked by alias); 17 Aug 2009 19:53:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp044) with SMTP; 17 Aug 2009 21:53:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18AReNB6TAA7ZzbQhSXCRkJMbE1p2eKNB5C0dahrP
	GU7aaPc0UUxlgW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126266>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-830258759-1250538835=:8306
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 17 Aug 2009, Erik Faye-Lund wrote:

> On Mon, Aug 17, 2009 at 7:34 PM, Paolo Bonzini<bonzini@gnu.org> wrote:
> > Also, a cleaner XML without verbosities like
> >
> > +                       <Tool
> > +                               Name="VCMIDLTool"
> > +                       />
> >
> > would make the patch easier to review.
> 
> ...but will it make it more annoying to maintain in the long run? It 
> might be painful to work with a mixture of hand-written and 
> msdev-written XML. Of course, if we get some scripts in place to 
> generate the vcproj-files this might not be a problem...

I think the killer argument against such a script (I actually though of 
that myself, but decided against it for that very reason) is that the 
result is to be used by Microsoft Visual Studio users, who do not 
typically have a scripting language, and who would not want to use it 
anyway.

Of course, we could have a script that verifies that the .vcproj files 
contain reference the appropriate files (which it would know about by 
being called from the Makefile and being passed the file names), maybe 
even be able to edit the .vcproj file if it is missing some.  Should not 
be too hard in Perl.

Ciao,
Dscho

--8323328-830258759-1250538835=:8306--
