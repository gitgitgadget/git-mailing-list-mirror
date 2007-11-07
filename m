From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] some shell portability fixes
Date: Wed, 7 Nov 2007 15:37:01 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711071536180.4362@racer.site>
References: <20071106201518.GA6361@ins.uni-bonn.de>  <7v8x5bgl04.fsf@gitster.siamese.dyndns.org>
  <20071106210210.GA32159@glandium.org>  <Pine.LNX.4.64.0711062324590.4362@racer.site>
  <e2b179460711070617h7e9af64egcde5122808a4d924@mail.gmail.com> 
 <Pine.LNX.4.64.0711071446190.4362@racer.site>
 <e2b179460711070730w4ca95989y14872665ddc8bfca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 16:37:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipmy3-00063s-Lr
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 16:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbXKGPhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 10:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752447AbXKGPhJ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 10:37:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:40197 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752273AbXKGPhH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 10:37:07 -0500
Received: (qmail invoked by alias); 07 Nov 2007 15:37:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp020) with SMTP; 07 Nov 2007 16:37:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18rQL0KtKwrWJYIIi/TBNzaeUt8nE/emrUdVWxoYT
	UMElvpBgduXPxL
X-X-Sender: gene099@racer.site
In-Reply-To: <e2b179460711070730w4ca95989y14872665ddc8bfca@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63827>

Hi,

On Wed, 7 Nov 2007, Mike Ralphson wrote:

> On Nov 7, 2007 2:47 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > I am not sure if the GNU tools are installed in the same place on all 
> > AIX boxen...
> 
> Well let's say the patch would arrive earlier if it was based on the
> shipped Makefile rather than the unholy abomination that is
> autoconf... If the GNU tools have been installed via the IBM AIX
> Toolbox for Linux Applications[1] then they'll be installed in
> /opt/freeware/bin and /usr/linux/bin will be a set of symlinks to
> them.

I guess Makefile is the better place, then.  You are the expert on AIX.

Ciao,
Dscho
