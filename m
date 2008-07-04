From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 1/4] Add git-sequencer shell prototype
Date: Fri, 4 Jul 2008 03:11:51 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807040309580.2849@eeepc-johanness>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807031142540.9925@racer> <1214879914-17866-1-git-send-email-s-beyer@gmx.net>
 <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <20080703210950.GC6677@leksak.fem-net> <alpine.DEB.1.00.0807040138090.2849@eeepc-johanness> <20080704010616.GH6677@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 04 03:13:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEZrI-0001aW-6f
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 03:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758103AbYGDBME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 21:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758037AbYGDBME
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 21:12:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:47445 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755632AbYGDBLx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 21:11:53 -0400
Received: (qmail invoked by alias); 04 Jul 2008 01:11:51 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp018) with SMTP; 04 Jul 2008 03:11:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18jBoZr4nsjwnfpV8wRtXpHeGwHkW3HGC+WVDlZLV
	QlzKvdH5bNO6i8
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080704010616.GH6677@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87354>

Hi,

On Fri, 4 Jul 2008, Stephan Beyer wrote:

> Johannes Schindelin wrote:
>
> > and you can easily abort a rebase if you explicitely asked for an 
> > invalid strategy.
> 
> Aborting after fixing a lot of conflicts in the sequencer process is 
> really annoying.

I think it should use rerere (if activated, which I have given up 
advocating to be the default).

> So I've chosen to never abort automatically.

Who said anything about automatically?  Of _course_, the user has to abort 
it.  Or try to continue with "git sequencer --continue -s ours".

Ciao,
Dscho
