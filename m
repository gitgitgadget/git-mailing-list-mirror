From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Teach 'git pull' about --rebase
Date: Wed, 28 Nov 2007 22:02:30 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711282202120.27959@racer.site>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site>
 <alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org>
 <Pine.LNX.4.64.0710260007450.4362@racer.site> <7v3avy21il.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0710261047450.4362@racer.site> <7v3aurcjpq.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0711281307420.27959@racer.site> <27E5EF3C-19EF-441C-BB12-0F5B29BEAEDB@midwinter.com>
 <Pine.LNX.4.64.0711282039430.27959@racer.site>
 <8c5c35580711281310h8764a33pba48e65010abf859@mail.gmail.com>
 <7vhcj63uhw.fsf@gitster.siamese.dyndns.org> <474DE4D5.6020407@freescale.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 23:03:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxUzq-0005GM-DC
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 23:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756592AbXK1WCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 17:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758154AbXK1WCq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 17:02:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:55138 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755672AbXK1WCq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 17:02:46 -0500
Received: (qmail invoked by alias); 28 Nov 2007 22:02:44 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 28 Nov 2007 23:02:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18YoxEDM14YV2HY0GKvvWXOXW6Ry+8GX49Dmro07C
	4yUh2W3/fouAHU
X-X-Sender: gene099@racer.site
In-Reply-To: <474DE4D5.6020407@freescale.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66437>

Hi,

On Wed, 28 Nov 2007, Jon Loeliger wrote:

> Junio C Hamano wrote:
> 
> > Maybe not make this part of git-pull at all?  merge and rebase have
> > totally different impact on the resulting history, so perhaps a separate
> > command that is a shorthand for "git fetch && git rebase" may help
> > unconfuse the users.
> 
> At long last, we can revive "git update"!

No, we cannot.  By now, too many aliases are called "update".

Ciao,
Dscho
