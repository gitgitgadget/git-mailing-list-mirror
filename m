From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pager: use an environment variable for pager_in_use
Date: Fri, 16 Feb 2007 19:35:37 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702161934230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070216151925.GA28974@moooo.ath.cx> <20070216155658.GB7183@coredump.intra.peff.net>
 <20070216182231.GA31676@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 19:35:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI7vw-0008EK-8M
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 19:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946190AbXBPSfm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 13:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946208AbXBPSfm
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 13:35:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:47222 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1946190AbXBPSfl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 13:35:41 -0500
Received: (qmail invoked by alias); 16 Feb 2007 18:35:40 -0000
X-Provags-ID: V01U2FsdGVkX18QsHQAi5wQ/FvhTWkSBfn2kFu3Q2W6lXj9AwHtmS
	gCrQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070216182231.GA31676@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39938>

Hi,

On Fri, 16 Feb 2007, Matthias Lederhofer wrote:

> When running a shell script the value of pager_in_use is
> lost for later processes.  Therefore pager_in_use is
> replaced by the environment variable GIT_PAGER_IN_USE.

Am I the only one who finds it ugly to set an environment variable for use 
in the same program?

> -int pager_in_use;

How about

+int pager_in_use = getenv("GIT_PAGER_IN_USE");

???

Ciao,
Dscho
