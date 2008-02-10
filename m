From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Minor annoyance with git push
Date: Sun, 10 Feb 2008 12:21:09 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802101220360.11591@racer.site>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <46a038f90802072050s46ffe305mcffffa068511e3b8@mail.gmail.com> <7vwspfkhxm.fsf@gitster.siamese.dyndns.org> <3AA71024-080B-4252-8416-82AE38A4498E@zib.de>
 <7vd4r55vcs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 13:21:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOBBp-0008QT-7M
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 13:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684AbYBJMVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 07:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753660AbYBJMVJ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 07:21:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:44713 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753524AbYBJMVI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 07:21:08 -0500
Received: (qmail invoked by alias); 10 Feb 2008 12:21:06 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp021) with SMTP; 10 Feb 2008 13:21:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+PV9EhOd+PH6P0bqQyFXLRI7XV2PaCA6dPIcMeXf
	uqO3ZwakQr5z2D
X-X-Sender: gene099@racer.site
In-Reply-To: <7vd4r55vcs.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73343>

Hi,

On Sat, 9 Feb 2008, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
> 
> > On Feb 8, 2008, at 8:48 AM, Junio C Hamano wrote:
> >
> >> Perhaps it might make sense to have a checkout hook that notices
> >> the branch that is being checked out is meant to build on top of
> >> a corresponding remote tracking branch, and performs the
> >> necessary fast-forward when that is the case.
> >
> > Or just print a warning that there are new commits on the
> > tracked branch and leave the decision how to proceed to
> > the user?
> 
> Yeah, that would be even safer.  And I do not mind if the "git
> checkout" learned to do so natively without needing of such a
> hook.

Heh, should be easier when we have builtin git-checkout... which reminds 
me that I have a patch series to review.  ;-)

Ciao,
Dscho
