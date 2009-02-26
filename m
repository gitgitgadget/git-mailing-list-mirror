From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] clone: ignore --depth when cloning locally (implicitly
 --local)
Date: Thu, 26 Feb 2009 23:55:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902262352380.10279@pacific.mpi-cbg.de>
References: <cover.1235672273u.git.johannes.schindelin@gmx.de> <1f63785d96d243ff19a063f684abbbe46cafc075.1235672273u.git.johannes.schindelin@gmx.de> <7v8wnsrf55.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 23:56:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcp9F-00042C-1D
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 23:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381AbZBZWy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 17:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754263AbZBZWy1
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 17:54:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:46112 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753844AbZBZWy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 17:54:27 -0500
Received: (qmail invoked by alias); 26 Feb 2009 22:54:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 26 Feb 2009 23:54:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+PWodySt2PavZK96haCWX640pSfVld7yXN/H1DyD
	95E4szEAJsGe9h
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v8wnsrf55.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111609>

Hi,

On Thu, 26 Feb 2009, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > When cloning locally, we default to --local, as it makes the whole
> > operation fast and efficient.
> >
> > As the most common intent of cloning with a --depth parameter is to
> > save space, and --local saves space more than --depth ever can,
> > warn the user and ignore the --depth parameter when cloning locally.
> >
> > Should --depth be desired, the user can always force proper cloning
> > by using a file:// URL.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Makes sense.  I'm inclined to apply this as a "fix" before 1.6.2, but I
> cannot exactly say what we are fixing.  User's expectations?

It seems somebody mentioned on IRC that --depth with --no-local will not 
work as expected, but was not willing to write to the list, or for that 
matter, do anything else.

So given that level of enthusiasm for _supporting_ this feature, I am 
inclined to postpone the patch, or drop it altogether.

I mean, I tried to be a good netizen and not let a patch I started go 
stale, but it is not my itch, and if those whose itch it is do not care, 
maybe I shouldn't, either.

Ciao,
Dscho
