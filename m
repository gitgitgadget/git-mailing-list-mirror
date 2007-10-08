From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] rev-list: implement --bisect-all
Date: Mon, 8 Oct 2007 04:44:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710080442420.4174@racer.site>
References: <20071008053438.6a829b91.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 05:44:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IejXq-0002Sc-NI
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 05:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbXJHDo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 23:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbXJHDo1
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 23:44:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:40764 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751851AbXJHDo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 23:44:27 -0400
Received: (qmail invoked by alias); 08 Oct 2007 03:44:24 -0000
Received: from unknown (EHLO [172.17.38.182]) [38.99.84.33]
  by mail.gmx.net (mp030) with SMTP; 08 Oct 2007 05:44:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18jTc97V0YjzbQLsa5rL+LL0cg2UD81HKjCMMvncG
	wKodEDtJRxNPrW
X-X-Sender: gene099@racer.site
In-Reply-To: <20071008053438.6a829b91.chriscool@tuxfamily.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60283>

Hi,

On Mon, 8 Oct 2007, Christian Couder wrote:

> This option makes it possible to see all the potential bisection points. 
> The best ones are displayed first.

Would it not be better to pass --bisect-vars a list of commits that we do 
not want to see?  It could then mark them as "DUNNO", and still just 
output a single commit.

IMHO such a logic does not belong into a shell script, but into the C 
core.

Ciao,
Dscho
