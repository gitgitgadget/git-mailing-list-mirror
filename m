From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t9001: set TERM=dumb to prevent ANSI output
Date: Fri, 7 Mar 2008 12:41:39 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803071240590.19395@racer.site>
References: <alpine.LSU.1.00.0803061752340.3941@racer.site> <7vmypb8muj.fsf@gitster.siamese.dyndns.org> <200803070541.15793.chriscool@tuxfamily.org> <7v7igf5cpk.fsf@gitster.siamese.dyndns.org> <7vskz33vow.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 12:42:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXayJ-0002jO-7B
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 12:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893AbYCGLll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 06:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756589AbYCGLll
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 06:41:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:59659 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753043AbYCGLlk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 06:41:40 -0500
Received: (qmail invoked by alias); 07 Mar 2008 11:41:38 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp011) with SMTP; 07 Mar 2008 12:41:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/eFywg+Yfeg+enajhvWUSivnrtOU8rlBYksqRMCr
	iG0YozAvx/IfyJ
X-X-Sender: gene099@racer.site
In-Reply-To: <7vskz33vow.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76477>

Hi,

On Thu, 6 Mar 2008, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Christian Couder <chriscool@tuxfamily.org> writes:
> > ...
> >> This may not work well with colored output.
> >> In test-lib.sh line 62 there is :
> >>
> >> [ "x$TERM" != "xdumb" ] &&
> >> 	[ -t 1 ] &&
> >> 	tput bold >/dev/null 2>&1 &&
> >> 	tput setaf 1 >/dev/null 2>&1 &&
> >> 	tput sgr0 >/dev/null 2>&1 &&
> >> 	color=t
> >
> > Ahh.  Sorry about that.
> 
> Ahem, third time lucky.

Well, with this:

>  t/test-lib.sh |   24 +++++++++++++++++-------

I think it is no longer worth it _not_ to special-case it.  IOW I'd prefer 
my original patch for simplicity.

Ciao,
Dscho
