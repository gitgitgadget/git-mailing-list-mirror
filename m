From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-svn: fix dcommit clobbering upstream when committing
 multiple changes
Date: Sat, 1 Sep 2007 02:32:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709010232260.28586@racer.site>
References: <Pine.LNX.4.64.0708312200480.28586@racer.site>
 <20070831221814.GB31033@untitled> <Pine.LNX.4.64.0709010017250.28586@racer.site>
 <20070831234854.GA6451@mimvista.com> <20070901002501.GA11591@mimvista.com>
 <20070901011612.GA3407@untitled>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Sep 01 03:33:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRHrG-00031x-U1
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 03:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbXIABdD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 21:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbXIABdB
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 21:33:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:37013 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751150AbXIABdA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 21:33:00 -0400
Received: (qmail invoked by alias); 01 Sep 2007 01:32:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp021) with SMTP; 01 Sep 2007 03:32:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/WARoD5uXWzU+A3PfEzwfaNPo5ATLlXGaeLIX3RT
	QahkSrSYwvYsrc
X-X-Sender: gene099@racer.site
In-Reply-To: <20070901011612.GA3407@untitled>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57243>

Hi,

On Fri, 31 Aug 2007, Eric Wong wrote:

> Although dcommit could detect if the first commit in the series
> would conflict with the HEAD revision in SVN, it could not
> detect conflicts in further commits it made.
> 
> Now we rebase each uncommitted change after each revision is
> committed to SVN to ensure that we are up-to-date.  git-rebase
> will bail out on conflict errors if our next change cannot be
> applied and committed to SVN cleanly, preventing accidental
> clobbering of changes on the SVN-side.

Thanks for the quick fix; will play with it on Sunday...

Ciao,
Dscho
