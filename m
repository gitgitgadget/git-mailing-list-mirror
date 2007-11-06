From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-rev-list diff options broken
Date: Tue, 6 Nov 2007 23:55:28 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711062354070.4362@racer.site>
References: <f329bf540711061414k1627521bvaf4a7a06460cc3fd@mail.gmail.com> 
 <Pine.LNX.4.64.0711062330220.4362@racer.site>
 <f329bf540711061538l4cdef27co2cb42a9938b2e325@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Wed Nov 07 00:56:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpYHg-00053S-Eo
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 00:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129AbXKFX40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 18:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753502AbXKFX40
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 18:56:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:48188 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751079AbXKFX4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 18:56:25 -0500
Received: (qmail invoked by alias); 06 Nov 2007 23:56:23 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp004) with SMTP; 07 Nov 2007 00:56:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18UgkRMcjIUDn6BD1qfBetenz+xXqHGTJ0ECmubSm
	yZRPT6EKhJ8PpP
X-X-Sender: gene099@racer.site
In-Reply-To: <f329bf540711061538l4cdef27co2cb42a9938b2e325@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63755>

Hi,

On Tue, 6 Nov 2007, Han-Wen Nienhuys wrote:

> 2007/11/6, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> 
> > Probably you want to use "git log".
> >
> > "git blame -L 585,589 builtin-rev-list.c" indicates that 8c1f0b44(Fix 
> > up rev-list option parsing) was responsible, which in turn indicates 
> > that it was intentional.
> 
> OK. So the man page needs fixing, right?

I guess.  Although it seems a bit involved, since the diff-formats.txt are 
not included by git-rev-list.txt itself, but by pretty-formats.txt.

Ciao,
Dscho
