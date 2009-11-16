From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] rebase: refuse to rebase with -s ours
Date: Mon, 16 Nov 2009 22:25:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911162213590.4985@pacific.mpi-cbg.de>
References: <cover.1258309432.git.trast@student.ethz.ch> <efd7770d166a97481e8e31e407b9c2da02a341e5.1258309432.git.trast@student.ethz.ch> <alpine.DEB.1.00.0911161333470.4985@pacific.mpi-cbg.de> <7vpr7ip7ji.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 22:21:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA91F-0007TB-2T
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 22:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbZKPVVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 16:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbZKPVVc
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 16:21:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:33791 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750911AbZKPVVb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 16:21:31 -0500
Received: (qmail invoked by alias); 16 Nov 2009 21:21:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp057) with SMTP; 16 Nov 2009 22:21:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/q4PIB6yLq4APqllgeRB/qJ3SN1/huStuNXtD1Fx
	DCaPf9xzwiXbUQ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vpr7ip7ji.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133025>

Hi,

On Mon, 16 Nov 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sun, 15 Nov 2009, Thomas Rast wrote:
> >
> >> Using the "ours" strategy with rebase just discards all changes, 
> >> turning <branch> into <upstream> (or <newbase> if given).  This is 
> >> unlikely to be what the user wants, so simply refuse to do it.
> 
> > Besides, I find it rather arbitrary that the "ours" strategy is 
> > refused, but none of the user-provided merge strategies.  IOW 
> > disallowing "ours" may very well foster unreasonable expectations.
> 
> I cannot read this quite clearly.

I meant the following: if "rebase -s ours" refuses to run, but my boss has 
written this cunning merge strategy "superduper" which is equally unlikely 
to yield a sensible result, "rebase -s superduper" should still refuse to 
run, no?

Now, this scenario might be too rare to take care of, but maybe it shows 
that we have a design flaw here?

Ciao,
Dscho

P.S.: Please note that I do not make a case against Thomas' patch series.  
As gitzilla once said "I cannot provide alternative patches, so that's 
that".
