From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 2 Aug 2007 13:21:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708021320560.14781@racer.site>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
 <vpqhcni47ek.fsf@bauges.imag.fr> <7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net>
 <7v1wemxnkk.fsf@assigned-by-dhcp.cox.net> <vpqzm1a2l72.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 02 14:21:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGZgk-0006Hv-Ig
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 14:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752AbXHBMV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 08:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754773AbXHBMVz
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 08:21:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:59901 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754723AbXHBMVy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 08:21:54 -0400
Received: (qmail invoked by alias); 02 Aug 2007 12:21:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 02 Aug 2007 14:21:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+w65EDvyew/9B76yxMAxHcCk0Co6Ow9+rRYzse14
	LYAiuxAQ8d6ilT
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqzm1a2l72.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54545>

Hi,

On Thu, 2 Aug 2007, Matthieu Moy wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Quite honestly, a script that indiscriminately touches everybody
> > but only modifies a few is simply broken.  Think about "make".
> > "git diff" reporting many cache-dirty files is simply reminding
> > you the brokenness of such a script.
> 
> I wouldn't call this "broken", but clearly suboptimal, yes. But for an
> occasionnal one-liner (perl -pi -e ... or so), I lose less time
> recompiling extra-files than I would writting a cleaner script. "make"
> has no way to detect the absence of modification, while git has.

_You_ can afford compiling them extra-files.

That is _exactly_ what Junio meant by "corner case".

Ciao,
Dscho
