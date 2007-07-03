From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] gitk fails with argument that is both existing directory
 and branch name
Date: Tue, 3 Jul 2007 23:44:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707032343160.4071@racer.site>
References: <20070703202301.GA24071@informatik.uni-freiburg.de>
 <Pine.LNX.4.64.0707032248570.4071@racer.site>
 <alpine.LFD.0.98.0707031514160.9434@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Uwe Kleine-K?nig <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 04 00:44:32 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5r6k-0000On-B8
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 00:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbXGCWo1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 18:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbXGCWo1
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 18:44:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:40953 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751075AbXGCWo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 18:44:27 -0400
Received: (qmail invoked by alias); 03 Jul 2007 22:44:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp003) with SMTP; 04 Jul 2007 00:44:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+AjVtFfLyAKemMOlBkzvURAl7EfECtrr+eS1lhlk
	Hp1Id3w8hqcbQK
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.98.0707031514160.9434@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51547>

Hi,

On Tue, 3 Jul 2007, Linus Torvalds wrote:

> On Tue, 3 Jul 2007, Johannes Schindelin wrote:
> 
> > Umm. Why don't you just use gitk linus/master..fixes? This is how we 
> > teach people to use rev-list anyway.
> 
> No, Uwe is right. There's a bug somewhere.

I never questioned that there is a bug. I was only wondering why he used 
that ambiguous way to specify a range, when a range is clearly what he 
wants.

Ah well. I'll look into it.

Ciao,
Dscho
