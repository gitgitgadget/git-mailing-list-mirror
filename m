From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Mon, 2 May 2005 22:54:18 +0200
Message-ID: <20050502205418.GA12409@mars.ravnborg.org>
References: <20050430025211.GP17379@opteron.random> <42764C0C.8030604@tmr.com> <Pine.LNX.4.58.0505020921080.3594@ppc970.osdl.org> <20050502171802.GA28045@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 02 22:52:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DShs6-0006Hp-PR
	for gcvg-git@gmane.org; Mon, 02 May 2005 22:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVEBUzj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 16:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVEBUzj
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 16:55:39 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:7448 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261745AbVEBUxG
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 May 2005 16:53:06 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepb.post.tele.dk (Postfix) with ESMTP id 6E86C5EE023;
	Mon,  2 May 2005 22:53:02 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id BABA96AC01D; Mon,  2 May 2005 22:54:18 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>,
	Bill Davidsen <davidsen@tmr.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050502171802.GA28045@nevyn.them.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 02, 2005 at 01:18:02PM -0400, Daniel Jacobowitz wrote:
> > 	#!/bin/sh
> > 	exec perl perlscript.pl "$@"
> > 
> > instead.
> 
> Do you know any vaguely Unix-like system where #!/usr/bin/env does not
> work?  I don't; I've used it on Solaris, HP-UX, OSF/1...

I had to pull out a call to env from kbuild due to strange errors in
some mandrake? based system.
I never tracked it down fully at that time, I just realised that two
different programs named env was present, and the less common one made
the linux kernel build fail. env was not called with any path in that
example so that may have cured it.

	Sam
