From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: ref name troubles, was Re: [PATCH v2] Introduce %<branch> as
 shortcut to the tracked branch
Date: Fri, 20 Mar 2009 10:30:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903201029290.10279@pacific.mpi-cbg.de>
References: <200903181448.50706.agruen@suse.de> <20090318182603.GM8940@machine.or.cz> <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de> <7vr60ubgul.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> <20090320004029.GX23521@spearce.org> <20090320060545.GB27008@coredump.intra.peff.net>
 <7vprgc4r6h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 10:30:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkb3i-0005aA-JU
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 10:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbZCTJ2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 05:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbZCTJ2f
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 05:28:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:57515 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751898AbZCTJ2e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 05:28:34 -0400
Received: (qmail invoked by alias); 20 Mar 2009 09:28:31 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 20 Mar 2009 10:28:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18zqDoL6oczhDaEFnMlZjNyWnUoXwBCiSyXQODMCv
	dFs4QLAMLw4NvQ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vprgc4r6h.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113922>

Hi,

On Thu, 19 Mar 2009, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Mar 19, 2009 at 05:40:29PM -0700, Shawn O. Pearce wrote:
> >
> >> So yea, you can create a branch named "foo@{1}".
> >
> > But you can't actually refer to it:
> >
> >   $ git branch foo@{1}
> >   $ git show foo@{1} --
> >   fatal: bad revision 'foo@{1}'
> >
> > which implies that nobody is actually using it for anything.
> 
> I think you are right.  It is just "git branch" and perhaps "git
> update-ref" are too loose in enforcing what can be created.

"git branch" I agree with, but not "git update-ref".  As plumbing, the 
latter should be much more allowing, feeding rope aplenty (but also 
allowing cool tricks we do not think about yet).

Ciao,
Dscho
