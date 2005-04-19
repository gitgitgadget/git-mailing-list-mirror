From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Re-done kernel archive - real one?
Date: Tue, 19 Apr 2005 08:27:56 +0100
Message-ID: <20050419082756.A13105@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org> <20050417231959.A30656@flint.arm.linux.org.uk> <20050417235136.B30656@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org> <20050418102332.A21081@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504180802060.7211@ppc970.osdl.org> <20050418225356.B16789@flint.arm.linux.org.uk> <20050418224852.GM5554@pasky.ji.cz> <20050418235951.D16789@flint.arm.linux.org.uk> <20050418230941.GN5554@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 09:24:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNn5f-0000hO-Ko
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 09:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVDSH2K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 03:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVDSH2K
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 03:28:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31761 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261369AbVDSH2A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 03:28:00 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DNn9J-0001Yz-Jk; Tue, 19 Apr 2005 08:27:58 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DNn9I-0003Rw-D8; Tue, 19 Apr 2005 08:27:56 +0100
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050418230941.GN5554@pasky.ji.cz>; from pasky@ucw.cz on Tue, Apr 19, 2005 at 01:09:42AM +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2005 at 01:09:42AM +0200, Petr Baudis wrote:
> > Essentially, with BK, at 7am localtime each morning, I'd:
> > 
> > - update my baseline linux 2.6 tree
> > - for each working tree which may be pulled from
> >   - if the baseline is a superset
> >     - update working tree from baseline
> > 
> > The net result is that my workflow consisted entirely of:
> > 
> > 1. commit whatever into working tree
> > 2. test
> > 3. send linus a pull request
> > 4. repeat next day
> > 
> > The tree resynchronisation happened completely and entirely in the
> > background with no user intervention required at all.
> 
> And in the case of conflicts...?

If the baseline is a superset of the working tree, there will never be
any conflicts.  Note that as I said above, this is a condition on doing
the pull in the first place.

How we determine that with git is another matter though. 8)

-- 
Russell King

