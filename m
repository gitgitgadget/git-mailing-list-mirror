From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Worrisome bug trend
Date: Tue, 27 Feb 2007 21:00:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272057220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vodnfg4sy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:01:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM8VX-0007n3-4b
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbXB0UA4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752522AbXB0UA4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:00:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:51304 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752521AbXB0UA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:00:56 -0500
Received: (qmail invoked by alias); 27 Feb 2007 20:00:54 -0000
X-Provags-ID: V01U2FsdGVkX1/7slZ9zS77Oq+r2YFaKFRF5/j2fL3BstVhPNeHTV
	lmlg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vodnfg4sy.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40778>

Hi,

On Tue, 27 Feb 2007, Junio C Hamano wrote:

> I was reviewing the bugs we fixed since v1.5.0 and noticed almost all of 
> them are ancient ones.  We do have small number of bugs introduced by 
> recently added commands and options, but I see quite a few that are from 
> 2005.

I tend to agree with all the answers that this trend is to be expected.

Especially since we seem to attract more and more users who are unable or 
unwilling to fix the bugs themselves (up until recently, most bug reports 
seemed to me to be accompanied by patches).

So, it does not appear worrisome to me.

However, I would like to see people thinking about how to teach "sparse" 
to catch those kind of errors so that we can actually learn in an 
efficient way from our mistakes.

For example, I refuse to believe that an error like checking int against 
ssize_t cannot be found by "sparse".

Ciao,
Dscho
