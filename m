From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: prevent filters from reading from stdin
Date: Tue, 5 Jun 2007 17:10:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706051704170.4046@racer.site>
References: <20070605141208.GA23605@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 18:12:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvbe2-0003O6-Mp
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 18:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbXFEQMV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 12:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbXFEQMV
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 12:12:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:42814 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932433AbXFEQMU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 12:12:20 -0400
Received: (qmail invoked by alias); 05 Jun 2007 16:12:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 05 Jun 2007 18:12:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18FfgUYKawFDj7SbL9bl27rilo0GN7ZyaSAyXwlxB
	gTXkE/KhtgGbs/
X-X-Sender: gene099@racer.site
In-Reply-To: <20070605141208.GA23605@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49202>

Hi,

On Tue, 5 Jun 2007, Matthias Lederhofer wrote:

> stdin is the list of commits when the env, tree and index
> filter are executed.  The filters are not supposed to read
> anything from stdin so the best is to give them /dev/null
> for reading.

ACK. After chatting with Matthias on IRC, I agree that there is more 
damage than benefit from being able to (accidentally) take stdin in these 
filters.

Ciao,
Dscho
