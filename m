From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make '!' aliases more useful
Date: Mon, 2 Jul 2007 16:55:24 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707021654450.4071@racer.site>
References: <Pine.LNX.4.64.0707012249590.4438@racer.site> <20070702145549.GB4720@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 02 17:55:35 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5OFQ-0001v9-MT
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 17:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390AbXGBPza (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 11:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754317AbXGBPza
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 11:55:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:58829 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754009AbXGBPz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 11:55:29 -0400
Received: (qmail invoked by alias); 02 Jul 2007 15:55:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 02 Jul 2007 17:55:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+bwdQ7j/yb0fCc4iOn8eDQ891qzODv3k7pVVmzQQ
	UvjIuxLIweVRAT
X-X-Sender: gene099@racer.site
In-Reply-To: <20070702145549.GB4720@thunk.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51377>

Hi,

On Mon, 2 Jul 2007, Theodore Tso wrote:

> On Sun, Jul 01, 2007 at 10:51:58PM +0100, Johannes Schindelin wrote:
> > 
> > When an alias starts with an exclamation mark, the rest is interpreted
> > as a shell command. However, all arguments passed to git used to be
> > ignored.
> > 
> > Now you can have an alias like
> > 
> > 	$ git config alias.e '!echo'
> > 
> > and
> > 
> > 	$ git e Hello World
> > 
> > does what you expect it to do.
> 
> But what if you don't want the argument passed at the end of the
> alias, but somewhere else?  I suspect the better answer would be to
> support $* and $1, $2, $3, et. al interpolation, no?  It was on my
> list of things to do when I had a spare moment, but I never got around
> to it.

There is a point where you do not want to complicate git, but rather write 
a script. This is such a point IMHO.

Ciao,
Dscho
