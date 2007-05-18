From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Extra columns in blame
Date: Fri, 18 May 2007 14:01:01 -0700
Message-ID: <7vy7jl4zjm.fsf@assigned-by-dhcp.cox.net>
References: <20070518191725.10460.83338.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 18 23:01:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp9ZU-0004xY-3e
	for gcvg-git@gmane.org; Fri, 18 May 2007 23:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbXERVBE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 17:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754072AbXERVBD
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 17:01:03 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:62411 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742AbXERVBD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 17:01:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070518210102.LXCC19731.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 18 May 2007 17:01:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0l111X0031kojtg0000000; Fri, 18 May 2007 17:01:01 -0400
In-Reply-To: <20070518191725.10460.83338.stgit@rover> (Petr Baudis's message
	of "Fri, 18 May 2007 21:17:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47658>

Good job, except that I think you should also show the filename
especially as you seem to run with -C (I haven't looked at the
code yet, though).

E.g.

http://repo.or.cz/w/linux-2.6.git?a=blame_incremental;f=block/ll_rw_blk.c;h=6b5173ac81313d8adb5c1d7b521559f565bb209b;hb=347b4599dd6ffef27e18c227532d1ec66556000b

the first few hunks that came from 1da177e4 are from a different
file, drivers/block/ll_rw_blk.c.

Also the incremental thing using JavaScript does not seem to
work for me incrementally for some reason, although if I wait
long enough I get the fully blamed picture that seems to match
nonincremental one.  While I am waiting, the browser goes silent
and does not even let me switch to other tabs, so it is not all
that useful to me in its current shape.
