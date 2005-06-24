From: Christopher Li <hg@chrisli.org>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Fri, 24 Jun 2005 08:38:19 -0400
Message-ID: <20050624123819.GD9519@64m.dyndns.org>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Mackall <mpm@selenic.com>, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
X-From: git-owner@vger.kernel.org Fri Jun 24 17:48:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlqPE-0005bv-Np
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 17:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbVFXPxP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 11:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbVFXPxP
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 11:53:15 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:34558 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263100AbVFXPuX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2005 11:50:23 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (sccrmhc12) with ESMTP
          id <2005062415502301200hckmge>; Fri, 24 Jun 2005 15:50:23 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id 289263F17F; Fri, 24 Jun 2005 08:38:19 -0400 (EDT)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050624064101.GB14292@pasky.ji.cz>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 24, 2005 at 08:41:01AM +0200, Petr Baudis wrote:
> > 5.1) undo the last commit or pull
> > 
> > $ hg undo
> 
> $ cg-admin-uncommit
> 
> Note that you should never do this if you already pushed the changes
> out, or someone might get them. (That holds for regular Git too.) See
> 
> $ cg-help cg-admin-uncommit   # (or cg-admin-uncommit --help)
> 
> for details. (That's another Cogito's cool feature. Handy docs! ;-)
> 

Does it still works if the last commit was interrupted  or due to error for some
reason?  Undo pull is pretty cool because you might pull a lot of commit
in one blow. Get rid of commit one by one is going to be painful. Some times
the object you pull has more than one chain of history it will be very nasty
if you want to clean it up.

Mercurial's undo is taking a snapshot of all the changed file's repo file length
at every commit or pull.  It just truncate the file to original size and undo 
is done.

Chris

