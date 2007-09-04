From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Tue, 4 Sep 2007 03:21:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709040319360.28586@racer.site>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com>
 <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com>
 <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@eudaptics.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 04:22:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISO3W-0002Rb-Mo
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 04:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbXIDCWO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 22:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbXIDCWO
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 22:22:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:33748 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751166AbXIDCWN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 22:22:13 -0400
Received: (qmail invoked by alias); 04 Sep 2007 02:22:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp003) with SMTP; 04 Sep 2007 04:22:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18bWBpl2Q4bRKywxjSE2YyJXKuN3mxtv83paiH6a4
	XPQXQ5b6jyY6+6
X-X-Sender: gene099@racer.site
In-Reply-To: <46DC5ED4.8050202@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57512>

Hi,

On Mon, 3 Sep 2007, Marius Storm-Olsen wrote:

> Johannes Schindelin wrote:
> > To make it easier on others, I just uploaded it into the "teststat"
> > branch on 4msysgit.git (subject to removal in a few days).
> 
> Ok, I've updated the patch in the 4msysgit.git repo, 'teststat' branch.
> RFC, and please test.

I'm too tired for more, but the first test which fails (consistently) is 
t4200 here:

* FAIL 17: young records still live
	test -f .git/rr-cache/08f6c39f296af7e0dd1b3b7d8bba18d0365f605f/preimage
&& test -f .git/rr-cache/4000000000000000000000000000000000000000/preimage

Ciao,
Dscho
