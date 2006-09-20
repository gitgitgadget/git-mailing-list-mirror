From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 23:27:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609202325510.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060920080308.673a1e93@localhost.localdomain>
 <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz>
 <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org>
 <Pine.LNX.4.63.0609202304270.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060920212101.GA24415@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 23:27:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ9bA-0007wl-18
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 23:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWITV1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 17:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWITV1N
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 17:27:13 -0400
Received: from mail.gmx.de ([213.165.64.20]:47320 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932127AbWITV1L (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 17:27:11 -0400
Received: (qmail invoked by alias); 20 Sep 2006 21:27:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 20 Sep 2006 23:27:10 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060920212101.GA24415@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27406>

Hi,

On Wed, 20 Sep 2006, Shawn Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Another, even more serious problems with rebasing: You can introduce a bug 
> > by rebasing. Meaning: git-rebase can succeed, even compilation is fine, 
> > but the sum of your patches, and the patches you are rebasing on, is 
> > buggy. And there is _no_ way to bisect this, since the "good" version can 
> > be gone for good.
> 
> True, however one would hope that you tested the commit before you
> rebased it and found it to working.  And bisect should point at the
> new version of that commit as the break.  And then you can debug
> it there.

You misunderstood me. You can _introduce_ a bug by rebasing. _After_ 
testing that everything is fine. You can even test the rebased branch and 
miss the bug, since your original tests were more thorough.

Ciao,
Dscho
