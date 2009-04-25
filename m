From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Removed redundant static functions such as update_tracking_ref()
 and verify_remote_names() from builtin-send-pack.c, and made the ones in
 transport.c not be static so they can be used instead.
Date: Sat, 25 Apr 2009 11:18:33 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904251115550.10279@pacific.mpi-cbg.de>
References: <1240546432-26212-1-git-send-email-andy@petdance.com> <20090424210418.GC13561@coredump.intra.peff.net> <99B4BF12-01B9-4A68-B2E0-EF5DF2595FF0@petdance.com> <alpine.DEB.1.00.0904250206250.10279@pacific.mpi-cbg.de>
 <4B2541E8-7A27-45D5-B77D-AE93C0430EA8@petdance.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Andy Lester <andy@petdance.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 11:21:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lxe4U-0003wy-QP
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 11:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036AbZDYJS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 05:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752556AbZDYJS1
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 05:18:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:54336 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751892AbZDYJS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 05:18:26 -0400
Received: (qmail invoked by alias); 25 Apr 2009 09:18:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 25 Apr 2009 11:18:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/FzOg2dEHF9FLXvHpCD7OhNx1lQwf4ekslo45Ys8
	hQxMAui3GyPL3h
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4B2541E8-7A27-45D5-B77D-AE93C0430EA8@petdance.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117540>

Hi,

On Fri, 24 Apr 2009, Andy Lester wrote:

> On Apr 24, 2009, at 7:07 PM, Johannes Schindelin wrote:
> 
> >I dunno.  The most important part of CodingGuidelines is this:
> >
> > As for more concrete guidelines, just imitate the existing code
> > (this is a good guideline, no matter which project you are
> > contributing to).
> >
> >(And of course, this holds for the style of commit messages, too.)
> 
> 
> Would you rather I not bother?  Far be it from me to try to force myself on
> any project.

Sorry, Andy, I forgot to add the

Disclaimer: if you are offended by constructive criticism, or likely to
answer with insults to the comments I offer, please stop reading this mail
now (and please do not answer my mail, either). :-)

Still with me?  Good.  Nice to meet you.

Just for the record: responding to a patch is my strongest way of saying
that I appreciate your work.

The thing with SubmittingPatches is: I think it is already too long for 
people to quickly read and get stuff done.

But hey, I was wrong before, and I will be wrong again.  That's why I 
offered my opinion, and I _can_ be convinced of another opinion.

Ciao,
Dscho
