From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Funky] "git -p cmd" inside a bare repository
Date: Fri, 14 Dec 2007 19:44:10 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712141943280.27959@racer.site>
References: <20071129122139.GA11176@laptop> <7vmysexdvw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 20:44:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3GSi-0008SX-N0
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 20:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764784AbXLNToV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 14:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765009AbXLNToV
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 14:44:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:57436 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764784AbXLNToU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 14:44:20 -0500
Received: (qmail invoked by alias); 14 Dec 2007 19:44:18 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 14 Dec 2007 20:44:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18NJPclma0NrPFJn50il9gxKLPHlz6JoEvT3oWsTc
	9CYDDdsX0IXUNC
X-X-Sender: gene099@racer.site
In-Reply-To: <7vmysexdvw.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68333>

Hi,

On Thu, 13 Dec 2007, Junio C Hamano wrote:

> If you have a bare repository and try this there:
> 
> 	$ PAGER=head git show HEAD:gcc/ChangeLog
> 
> it works as expected, but if you explicitly ask for pagination, like
> this:
> 
> 	$ PAGER=head git -p show HEAD:gcc/ChangeLog

I have no time left to work on git for a few days, so I cannot even review 
your patch.  But Jeff's patch being smaller, I could, and AFAICT it solves 
the problem.

Ciao,
Dscho
