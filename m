From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pager: use an environment variable for pager_in_use
Date: Fri, 16 Feb 2007 20:06:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702162004590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070216151925.GA28974@moooo.ath.cx> <20070216155658.GB7183@coredump.intra.peff.net>
 <20070216182231.GA31676@moooo.ath.cx> <Pine.LNX.4.63.0702161934230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070216185653.GA10308@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 20:06:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI8Pm-0006yT-LW
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 20:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946053AbXBPTGf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 14:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946056AbXBPTGe
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 14:06:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:41969 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1946053AbXBPTGe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 14:06:34 -0500
Received: (qmail invoked by alias); 16 Feb 2007 19:06:32 -0000
X-Provags-ID: V01U2FsdGVkX1+xBWZq98mxiVC5LYG5CItbL69C1JxMO9rQOsV3qG
	G4hg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070216185653.GA10308@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39940>

Hi,

On Fri, 16 Feb 2007, Matthias Lederhofer wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > +int pager_in_use = getenv("GIT_PAGER_IN_USE");
> test.c:3: error: initializer element is not constant

Sorry.

Still, it feels wrong to use two system calls when you need none.

How about working on making status and commit a builtin instead? This 
would not only solve your issue, but portability issues as well.

Ciao,
Dscho
