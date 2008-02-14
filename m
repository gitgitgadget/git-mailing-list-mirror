From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: another git rebase -i problem
Date: Thu, 14 Feb 2008 12:35:56 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802141232070.30505@racer.site>
References: <20080214093730.GA20408@digi.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1013492049-1202992557=:30505"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 13:36:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPdKV-0002B3-GL
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 13:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbYBNMfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 07:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759863AbYBNMfx
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 07:35:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:35313 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758165AbYBNMfw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 07:35:52 -0500
Received: (qmail invoked by alias); 14 Feb 2008 12:35:50 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 14 Feb 2008 13:35:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/hXnBHPf7h4lCcZgqhdBwkrEf3pySBzC8N1V2Pgf
	hoEmBrrjebN6Va
X-X-Sender: gene099@racer.site
In-Reply-To: <20080214093730.GA20408@digi.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73874>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1013492049-1202992557=:30505
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 14 Feb 2008, Uwe Kleine-König wrote:

> After applying the patch below, the test fails. [describes a case where 
> all patches were applied upstream already]

This is by design.  If no patches are to be applied, there is nothing you 
can do interactively.  And git rebase -i should tell you as much:

	Nothing to do

Maybe it should say

	There is nothing you can rebase interactively

But I don't like that.

Alternatively, git rebase -i could reset --hard to upstream, but I don't 
like that either: if I rebase -i, it is because I want to reorder/arrange 
patches.  If there is no patch to be rearranged, I did something wrong.

Ciao,
Dscho


---1463811741-1013492049-1202992557=:30505--
