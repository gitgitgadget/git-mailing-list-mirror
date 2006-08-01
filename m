From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: setting up git-cvsserver
Date: Tue, 1 Aug 2006 18:23:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608011822080.17230@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060801154906.GA18772@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 18:24:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7x20-0006Mk-Hj
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 18:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWHAQXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 12:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWHAQXl
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 12:23:41 -0400
Received: from mail.gmx.net ([213.165.64.21]:60887 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750803AbWHAQXk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Aug 2006 12:23:40 -0400
Received: (qmail invoked by alias); 01 Aug 2006 16:23:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 01 Aug 2006 18:23:39 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20060801154906.GA18772@informatik.uni-freiburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24604>

Hi,

On Tue, 1 Aug 2006, Uwe Zeisberger wrote:

> I cannot checkout a git repo via cvs, I think the only problem is, that
> I don't know how to specify the CVSROOT:
> 
> fs-n1:~# grep git- /etc/inetd.conf 
> 2402    stream  tcp     nowait  root    /usr/local/sbin/git-cvsserver pserver

>From Documentation/git-cvsserver.txt:

-- snip --
Note: In some cases, you need to pass the 'pserver' argument twice for
git-cvsserver to see it. So the line would look like

------
   cvspserver stream tcp nowait nobody git-cvsserver pserver pserver
-- snap --

So, maybe this solves your problem?

OTOH it might be cleverer to use SSH transport to begin with.

Hth,
Dscho
