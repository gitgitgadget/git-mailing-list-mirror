From: Daniel Jacobowitz <dan@debian.org>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Wed, 20 Apr 2005 23:35:27 -0400
Message-ID: <20050421033526.GA9404@nevyn.them.org>
References: <20050420205633.GC19112@pasky.ji.cz> <20050420211919.GA20129@kroah.com> <20050420215117.GJ19112@pasky.ji.cz> <Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org> <20050420222815.GM19112@pasky.ji.cz> <Pine.LNX.4.58.0504201710500.2344@ppc970.osdl.org> <Pine.LNX.4.58.0504201809170.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Greg KH <greg@kroah.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 05:32:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOSPX-0003Hv-Ev
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 05:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVDUDfl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 23:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVDUDfl
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 23:35:41 -0400
Received: from nevyn.them.org ([66.93.172.17]:57741 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261200AbVDUDfg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 23:35:36 -0400
Received: from drow by nevyn.them.org with local (Exim 4.50 #1 (Debian))
	id 1DOSTP-0002VF-F9; Wed, 20 Apr 2005 23:35:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504201809170.2344@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2005 at 06:12:34PM -0700, Linus Torvalds wrote:
> Here's a slightly updated version.
> 
> It's identical to the previous one, except that it also feeds the result 
> through "| ${PAGER:-less}" which makes it a lot more useful, in my 
> opinion.
> 
> If you redirect the output to a non-tty, both "less" and "more" do the 
> right thing and just feed the output straight through. But if the output 
> is a tty, this makes "git log" a lot more friendly than a quickly 
> scrolling mess..

Personally, I'd rather it didn't do this; bk help does the same thing,
and it drives me crazy.  I guess you have /usr/bin/man for a precedent,
though :-)

My logic: it's a lot more intuitive to say "cg-log | less" to get
paginated output than it is to say "cg-log | cat" to get unpaginated
output.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
