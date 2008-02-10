From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] New commit object headers: note headers
Date: Sun, 10 Feb 2008 01:08:32 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802100106330.11591@racer.site>
References: <200802091746.09102.jnareb@gmail.com> <fcaeb9bf0802090950l27aa247ei5d067e0f24fcade0@mail.gmail.com> <7vlk5tetaa.fsf@gitster.siamese.dyndns.org> <200802100026.39340.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 02:09:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO0h6-0005wd-Lu
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 02:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880AbYBJBIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 20:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755449AbYBJBIb
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 20:08:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:37145 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753936AbYBJBIa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 20:08:30 -0500
Received: (qmail invoked by alias); 10 Feb 2008 01:08:28 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp028) with SMTP; 10 Feb 2008 02:08:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19MyehW24BMsa3MZcskQF+CUIpfd9oR32rAprLp5B
	jcvYwidU+Q+WsY
X-X-Sender: gene099@racer.site
In-Reply-To: <200802100026.39340.jnareb@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73280>

Hi,

On Sun, 10 Feb 2008, Jakub Narebski wrote:

> Still I think it is would be nice to have original commit id in a header 
> when importing from foreign SCM. First, it would not pollute commit 
> message, which would be identical with the original commit message 
> (which allows easy two-way interaction). Second, it is much easier and 
> much less error prone to extract it by machine.

I cannot agree to either reason.  It is _not_ a git specific header, so it 
does not belong in the commit header.

Also, I find it does not clutter the commit message _at all_, but adds 
information that the user might find useful.

Lastly, I cannot see _any_ reason why it should be _easier_ or _less error 
prone_ to put an "original commit id" into the commit header than into the 
commit body.

Ciao,
Dscho
