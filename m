From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Replace rebase with filtering
Date: Tue, 16 Jan 2007 12:18:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701161216440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45AC3B5D.6080700@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 12:18:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6mKk-00075w-PH
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 12:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbXAPLSX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 06:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbXAPLSX
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 06:18:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:57376 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750913AbXAPLSW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 06:18:22 -0500
Received: (qmail invoked by alias); 16 Jan 2007 11:18:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 16 Jan 2007 12:18:21 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Steven Grimm <koreth@midwinter.com>
In-Reply-To: <45AC3B5D.6080700@midwinter.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36930>

Hi,

On Mon, 15 Jan 2007, Steven Grimm wrote:

> Ideally, we'd rebase the integration area against changes pulled from 
> master, then each dev repository would rebase against the changes from 
> the integration area. That would keep our histories nice and clean as we 
> pull changes down from the external repository.
> 
> But of course rebase will get confused and we'll end up re-applying 
> changes in the dev sandboxes as soon as there are any existing change in 
> the integration repo when we pull changes from master, because rebase 
> will turn those existing changes into new revisions that don't match any 
> previously known ones in the dev repositories.

I had the impression that the use of "--ignore-if-in-upstream" in 
git-rebase avoids exactly this case: re-applying changes which are already 
in upstream.

Doesn't it work that way?

Ciao,
Dscho
