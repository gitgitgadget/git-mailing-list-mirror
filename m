From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: test suite fails if sh != bash || tar != GNU tar
Date: Wed, 11 Jul 2007 03:49:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707110347580.4047@racer.site>
References: <7154c5c60707101939sc921b07wef1d14f85086947d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Frech <nimblemachines@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 04:57:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8SOI-0004fZ-2V
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 04:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667AbXGKC5T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 22:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754555AbXGKC5T
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 22:57:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:57259 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753814AbXGKC5S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 22:57:18 -0400
Received: (qmail invoked by alias); 11 Jul 2007 02:57:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 11 Jul 2007 04:57:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/jCgwhWzPjIqZ+HE03ABv5mQyEd/7gXLo6yfXj4p
	ywaR3bP9W9WppD
X-X-Sender: gene099@racer.site
In-Reply-To: <7154c5c60707101939sc921b07wef1d14f85086947d@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52130>

Hi,

On Tue, 10 Jul 2007, David Frech wrote:

> Anyone running Linux or Mac OSX won't see these problems, because on 
> both platforms /bin/sh == bash and tar == GNU tar.

Actually, Ubuntu seems to ship with dash as the default shell, and we had 
quite some fallout from that change.

As for GNU tar, I think that this is easily fixable if you have access to 
non-GNU tar.  We do not use tar _ever_, except for the test suite, to 
verify that things are working as expected.

If you could put in some time to make the tests work, that would be 
awesome.

Ciao,
Dscho
