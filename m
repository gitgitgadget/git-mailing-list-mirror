From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sun, 21 Oct 2007 10:08:13 +0400
Message-ID: <20071021060813.GK20588@dpotapov.dyndns.org>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com> <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com> <Pine.LNX.4.64.0710130130380.25221@racer.site> <1192827476.4522.93.camel@cacharro.xalalinux.org> <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de> <4719E69B.3020906@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Federico Mena Quintero <federico@novell.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Oct 21 08:08:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjTzC-00084a-B5
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 08:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbXJUGIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 02:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbXJUGIQ
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 02:08:16 -0400
Received: from smtp06.mtu.ru ([62.5.255.53]:50151 "EHLO smtp06.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbXJUGIP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 02:08:15 -0400
Received: from potapov.private (ppp85-141-188-192.pppoe.mtu-net.ru [85.141.188.192])
	by smtp06.mtu.ru (Postfix) with ESMTP id 552C57D0DE8;
	Sun, 21 Oct 2007 10:08:13 +0400 (MSD)
Received: from dpotapov by potapov.private with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1IjTyv-0007K4-4Q; Sun, 21 Oct 2007 10:08:13 +0400
Content-Disposition: inline
In-Reply-To: <4719E69B.3020906@op5.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61881>

On Sat, Oct 20, 2007 at 01:29:31PM +0200, Andreas Ericsson wrote:
> Steffen Prohaska wrote:
> >
> >plumbing: should be hidden from the 'normal' user. Porcelain
> >  should be sufficient for every standard task.
> >
> 
> Agreed. /usr/libexec/git/ seems to me to be the ideal spot for
> it.

/usr/libexec is against the Filesystem Hierarchy Standard (FHS).
It is better to use /usr/lib/git/ for that.

Dmitry
