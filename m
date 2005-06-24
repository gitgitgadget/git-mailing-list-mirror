From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Fri, 24 Jun 2005 09:39:52 -0400
Message-ID: <20050624133952.GB7445@thunk.org>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz> <20050624130604.GK17715@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, mercurial@selenic.com,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 24 15:37:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DloMe-0004tw-6T
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 15:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVFXNm5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 09:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVFXNm5
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 09:42:57 -0400
Received: from thunk.org ([69.25.196.29]:6061 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262423AbVFXNkM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 09:40:12 -0400
Received: from root (helo=think.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 3.35 #1 (Debian))
	id 1DloPR-0000nW-00; Fri, 24 Jun 2005 09:39:53 -0400
Received: from tytso by think.thunk.org with local (Exim 4.51)
	id 1DloPQ-0003zU-Th; Fri, 24 Jun 2005 09:39:52 -0400
To: Andrea Arcangeli <andrea@suse.de>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrea Arcangeli <andrea@suse.de>, Petr Baudis <pasky@ucw.cz>,
	mercurial@selenic.com, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050624130604.GK17715@g5.random>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 24, 2005 at 03:06:04PM +0200, Andrea Arcangeli wrote:
> On Fri, Jun 24, 2005 at 08:41:01AM +0200, Petr Baudis wrote:
> > Cool. Except where the concepts are just different, Cogito mostly
> > appears at least equally simple to use as Mercurial. Yes, some features
> > are missing yet. I hope to fix that soon. :-)
> 
> The user interface and network protocol isn't the big deal, the big deal
> is the more efficient on-disk storage format IMHO.

E2fsprogs with the full revision history imported into git is 100
megs, and that's with deltas.  E2fsprogs imported into Mercurial is 17
megs (and actually, the imported repository was just a tad bit smaller
than e2fsprogs' BK repository).

Which do you think is going to be faster to operate from a cold start
using 4200 rpm laptop drives?  :-)

						- Ted
