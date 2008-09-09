From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/7] prefix discovery at runtime (on Windows)
Date: Tue, 9 Sep 2008 16:49:19 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0809091648130.13830@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1218977083-14526-1-git-send-email-prohaska@zib.de> <7v3al35xmy.fsf@gitster.siamese.dyndns.org> <7vprnedzgc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 16:48:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd4Se-0007Ag-GN
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 16:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979AbYIIOnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 10:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbYIIOnt
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 10:43:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:51569 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751442AbYIIOns (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 10:43:48 -0400
Received: (qmail invoked by alias); 09 Sep 2008 14:43:47 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp045) with SMTP; 09 Sep 2008 16:43:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+HxHFiHpaHmOTJVKvKDoHtBw+3r3jLmGI4HwLLad
	J42k2OxJCFQCt6
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7vprnedzgc.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95389>

Hi,

On Mon, 8 Sep 2008, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Steffen Prohaska <prohaska@zib.de> writes:
> >
> >> Apologies for proposing such large changes that late in the release 
> >> cycle. Maybe we want to postpone the series until 1.6.0.1 or even 
> >> 1.6.1.
> >
> > Well, from the cursory look, it does not seem to be 1.6.0.1 material, 
> > even though it is possible to fork a topic at 1.6.0 and use the 
> > changes in 'next', then 'master', and eventually to 'maint' to produce 
> > 1.6.0.X, if all of this hapapens before 1.6.1.
> >
> > I wouldn't mind at all if the binary distribution on Windows is based 
> > on "git.git plus port specific patchset that will eventually be sent 
> > upstream" like it used to be.  In fact it might even be preferrable, 
> > as I won't be testing ports to that platform myself anyway.
> 
> If the depth difference between /usr/libexec/git-cat-file and /bin/git 
> is the major source of this headache, I do not think it is unreasonable 
> for the mingw git port to use "gitexecdir=$(bindir)" layout by default.  
> After all, Windows users do not really care where bulk of things are, as 
> long as they see one single clickable icon on the desktop, don't they?

I think the main point is that we could (finally!) adopt a saner default 
on Unix: instead of hardcoding an absolute exec path, a relative would do.  
So I'd like to see this supported for Linux...

Ciao,
Dscho
