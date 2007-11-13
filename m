From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 16:01:31 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711131600590.4362@racer.site>
References: <874pfq9q8s.fsf@osv.gnss.ru> <fhcdpv$9u3$1@ger.gmane.org>
 <87ve86889o.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 17:02:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IryDH-0003Jy-NH
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 17:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbXKMQBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 11:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752565AbXKMQBv
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 11:01:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:50448 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752102AbXKMQBu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 11:01:50 -0500
Received: (qmail invoked by alias); 13 Nov 2007 16:01:48 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 13 Nov 2007 17:01:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DtgotO5ZDSv3AN3YbNeMTXXQyMTg7QFr1gnZ1NW
	+dqpuTWJCuRpHa
X-X-Sender: gene099@racer.site
In-Reply-To: <87ve86889o.fsf@osv.gnss.ru>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64811>

Hi,

On Tue, 13 Nov 2007, Sergei Organov wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > The wildcard refspec is not documented adequately, so I'm not sure if 
> > adding
> >
> >         fetch = !refs/heads/pu
> >
> > would help, or do you have to replace wildcard refspec by explicit 
> > list of branches you want to fetch.
> 
> Isn't "git branch -d -r" supposed to do whatever magic is required to
> get rid of the remote branch?

But it did!  You explicitely fetched it _again_!

Ciao,
Dscho
