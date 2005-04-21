From: Daniel Jacobowitz <dan@debian.org>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Thu, 21 Apr 2005 00:28:34 -0400
Message-ID: <20050421042833.GA10934@nevyn.them.org>
References: <20050420205633.GC19112@pasky.ji.cz> <20050420211919.GA20129@kroah.com> <20050420215117.GJ19112@pasky.ji.cz> <Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org> <20050420222815.GM19112@pasky.ji.cz> <Pine.LNX.4.58.0504201710500.2344@ppc970.osdl.org> <Pine.LNX.4.58.0504201809170.2344@ppc970.osdl.org> <20050421033526.GA9404@nevyn.them.org> <Pine.LNX.4.58.0504202056310.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Greg KH <greg@kroah.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 06:24:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOTEs-00079D-Jq
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 06:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVDUE2w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 00:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVDUE2w
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 00:28:52 -0400
Received: from nevyn.them.org ([66.93.172.17]:56036 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261212AbVDUE2u (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 00:28:50 -0400
Received: from drow by nevyn.them.org with local (Exim 4.50 #1 (Debian))
	id 1DOTIo-0002rq-N4; Thu, 21 Apr 2005 00:28:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504202056310.2344@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2005 at 09:00:44PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 20 Apr 2005, Daniel Jacobowitz wrote:
> > 
> > My logic: it's a lot more intuitive to say "cg-log | less" to get
> > paginated output than it is to say "cg-log | cat" to get unpaginated
> > output.
> 
> I disagree.
> 
> There is _never_ any valid situation where you do "cg-log" with 
> unpaginated output to a tty.
> 
> In _any_ real system you'll be getting thousands of lines of output. 
> Possibly millions. unpaginated? What the hell are you talking about?

OK, so I'm crazy.  I must have hallucinated doing this sort of thing on
a regular basis... :-) Examples: terminals with good scrollback,
screen, script.  Small repositories.  Irritation at less's habit of
using the alternate xterm buffer, whatever the technical term for that
is.

But hey, you'll use it more often than I will by far.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
