From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] diff: --abbrev option
Date: Sun, 18 Dec 2005 01:17:56 +0100
Message-ID: <20051218001756.GS22159@pasky.or.cz>
References: <7v3bks12n6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 18 01:19:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnmFd-0006SX-3I
	for gcvg-git@gmane.org; Sun, 18 Dec 2005 01:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVLRASA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Dec 2005 19:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVLRASA
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Dec 2005 19:18:00 -0500
Received: from w241.dkm.cz ([62.24.88.241]:29140 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964974AbVLRAR7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Dec 2005 19:17:59 -0500
Received: (qmail 7502 invoked by uid 2001); 18 Dec 2005 01:17:56 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bks12n6.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13781>

Dear diary, on Sat, Dec 17, 2005 at 10:41:49AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> When I show transcripts to explain how something works, I often
> find myself hand-editing the diff-raw output to shorten various
> object names in the output.
> 
> This adds --abbrev option to the diff family, which shortens
> diff-raw output and diff-tree commit id headers.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> ---
> 
>  * Earlier I announced that I have this toy in proposed updates
>    without actually showing the code, so here it is.  I have
>    added code to find unique abbreviation as well.  It is
>    primarily useful to quote things in e-mail, like this:
> 
>       $ git-rev-parse master | git-diff-tree --pretty -r --abbrev --stdin
>       diff-tree 01385e2... (from 6922471...)
>       Author: Junio C Hamano <junkio@cox.net>
>       Date:   Fri Dec 16 23:12:33 2005 -0800
> 
>           Comment fixes.
> 
>           Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
>       :100755 100755 0266f46... b0e54ed... M	git-branch.sh
>       :100755 100755 f241d4b... 36308d2... M	git-checkout.sh

  I think the '...' is just distracting. It makes cut'n'paste more
difficult, and it's usually fairly obvious that this is start of a hash,
and that the hash might not be complete.

  I was actually thinking to by default trim all the hashes Cogito show
to 12 or 16 characters. Seven still seems dangerously low to me, though;
it would be nice if the number of characters to trim would be
configurable (unless I've missed that).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
