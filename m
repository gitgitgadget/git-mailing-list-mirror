From: Jon Loeliger <jdl@freescale.com>
Subject: Re: git bisect enhancements?
Date: Wed, 30 Nov 2005 16:07:09 -0600
Message-ID: <1133388429.30767.37.camel@cashmere.sps.mot.com>
References: <7vu0dtokqp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 30 23:09:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eha7A-0005r0-Te
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 23:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbVK3WHq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 17:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVK3WHq
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 17:07:46 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:17310 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1750955AbVK3WHp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 17:07:45 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id jAUMHTgo007576;
	Wed, 30 Nov 2005 15:17:29 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id jAUMDutg004019;
	Wed, 30 Nov 2005 16:13:56 -0600 (CST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0dtokqp.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13021>

On Wed, 2005-11-30 at 16:04, Junio C Hamano wrote:
> Jon Loeliger <jdl@freescale.com> writes:
> 
> > ...  I want to "bump" the bisect point
> > up two commits and _then_ build.
> >
> > So, I'm proposing something like:
> >
> >     $ git bisect bump +<n>
> >     $ git bisect bump -<n>
> >
> > To move the bisection point "up" or "down" a commit chain.
> 
> Hmph.  Doesn't "bisect good" or "bisect bad" let you explicitly
> say which one is good or bad, instead of just taking what it
> suggests as the next midpoint?

Sure.  But I'm proposing to alter the new bisection
middle point.  I don't know its status yet.  I am
just angling on hedging my bets of a "good midpoint"
choice by finding something that is likely to be
more stable than the proposed midpoint.

jdl
