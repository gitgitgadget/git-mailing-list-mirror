From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Mon, 25 Aug 2008 20:19:49 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	users@kernel.org
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 20:16:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXgbY-0004qh-2W
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 20:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbYHYSOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 14:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbYHYSOs
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 14:14:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:37517 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751241AbYHYSOr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 14:14:47 -0400
Received: (qmail invoked by alias); 25 Aug 2008 18:14:45 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp009) with SMTP; 25 Aug 2008 20:14:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19iiSd5OOtiYe0FfNo6Zl8plBlQI3Fd7ttU82zpJB
	XxVcJjbF6n4vdU
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1219664940.9583.42.camel@pmac.infradead.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93651>

Hi,

On Mon, 25 Aug 2008, David Woodhouse wrote:

> On Sat, 2008-08-23 at 20:33 -0700, Junio C Hamano wrote:
> > 
> > There is one alternative, and one augmentation:
> > 
> >  (A) We do not do anything.
> > 
> >  (B) In addition to the main transition plan, outside git, prepare an
> >      optional "git-old-style" package that installs many "git-foo" 
> >      wrappers in $PATH (i.e. /usr/bin).  Each of them exec "git foo". 
> >      People who like the dashed form can keep typing "git-foo", even 
> >      though that will cost them two exec()s.
> 
>   (C) Just don't do it. Leave the git-foo commands as they were. They
>       weren't actually hurting anyone, and you don't actually _gain_
>       anything by removing them.

Umm.  What exactly makes you feel you should ignore the discussions we had 
around the issues on the git and msysgit mailing list?

Ciao,
Dscho
