From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: I'm missing isofs.h
Date: Wed, 27 Apr 2005 12:43:51 -0400
Message-ID: <20050427164351.GA7070@delft.aura.cs.cmu.edu>
References: <20050426214338.32e9ac27.akpm@osdl.org> <20050427125843.GA9454@delft.aura.cs.cmu.edu> <20050427135840.GE3014@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:39:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQpYu-0002Nm-Bu
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 18:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVD0QoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 12:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVD0QoI
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 12:44:08 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:14013 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261312AbVD0Qnw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 12:43:52 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DQpdf-0005iS-00; Wed, 27 Apr 2005 12:43:51 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Andrew Morton <akpm@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050427135840.GE3014@pasky.ji.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2005 at 03:58:41PM +0200, Petr Baudis wrote:
> Dear diary, on Wed, Apr 27, 2005 at 02:58:44PM CEST, I got a letter
> where Jan Harkes <jaharkes@cs.cmu.edu> told me that...
> > On Tue, Apr 26, 2005 at 09:43:38PM -0700, Andrew Morton wrote:
> > > In a current tree, using git-pasky-0.7:
> > 
> > It looks like git-pasky-0.7 doesn't include the following commit, but
> > there are also several other diff and merge related fixes that were
> > added since then.
> 
> Why do you think it doesn't include it? I can see the fix in the code.

I looked through the output of cg-log, which I thought had at least some
ordering, and that commit showed up as more recent than the pasky-0.7
entry. It looks like the same change is also part of pasky-0.7, but with
a different commit-id. Sorry about the confusion.

In any case, when I use
    cg-diff -r a2755a80f40e5794ddc20e00f781af9d6320fafb: | grep isofs.h

the missing file does show up,
    ...
    Index: fs/isofs/isofs.h
    +++ fd1621a8c03331bd78abfe52c8c385977d0a9729/fs/isofs/isofs.h (mode:100644 sha1:9ce7b51fb6141ea6b82d85687d490c74755591fb)
    ...

so either I'm missing some subtle command line error (missing ':' after
the tag-id?) or the problem was fixed by some other change. So I looked
through the logs to see if there was anything obvious and the commit I
mentioned looked promising.

Jan

