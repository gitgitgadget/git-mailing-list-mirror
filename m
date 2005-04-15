From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: write-tree is pasky-0.4
Date: Fri, 15 Apr 2005 16:58:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504151617170.27637@cag.csail.mit.edu>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
 <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz>
 <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <20050414193507.GA22699@pasky.ji.cz>
 <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net> <20050414233159.GX22699@pasky.ji.cz>
 <7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net> <20050414223039.GB28082@64m.dyndns.org>
 <7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net> <20050415062807.GA29841@64m.dyndns.org>
 <7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net> <7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org> <7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 22:56:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMXqC-0006So-EG
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 22:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVDOU6f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 16:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVDOU6f
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 16:58:35 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:9664 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261969AbVDOU6c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 16:58:32 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DMXtM-0000Sm-00; Fri, 15 Apr 2005 16:58:20 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 15 Apr 2005, Junio C Hamano wrote:

> to yours is no problem for me.  Currently I see your HEAD is at
> 461aef08823a18a6c69d472499ef5257f8c7f6c8, so I will generate a
> set of patches against it.

Have you considered using an s/key-like system to make these hashes more 
human-readable?  Using the S/Key translation (11-bit chunks map to a 1-4 
letter word), Linus' HEAD is at:
   WOW-SCAN-NAVE-AUK-JILL-BASH-HI-LACE-LID-RIDE-RUSE-LINE-GLEE-WICK-A
...which is a little longer, but speaking of branch "wow-scan" (which 
gives 22 bits of disambiguation) is probably less error-prone than 
discussing branch '461...' (only 12 bits).

You could supercharge this algorithm by using (say) 
/usr/dict/american-english-large (>2^17 words; 160 bits of hash = 10 
dictionary words), or mixing upper and lower case (likely to reduce the 15 
word s/key phrase to ~11 words) to give something like
    RiDe-Rift-rIMe-rOSy-ScaR-sCat-ShiN-sIde-Sine-seeK-TIEd-TINT
My personal feeling is that case is likely to be dropped in casual 
conversation, so speaking of branch 'wow', 'wow-scan', or 'wow-scan-nave' 
is likely to be significantly more useful than trying to pronounce 
mixed-cased versions of these.

This is obviously a cogito issue, rather than a git-fs thing.
  --scott

[More info is in RFCs 2289 and 1760, although all I'm really using from 
these is the word dictionary in the appendix.]
     http://www.faqs.org/rfcs/rfc1760.html
     http://www.faqs.org/rfcs/rfc2289.html

SKIMMER MKOFTEN Ft. Bragg Sabana Seca ESMERALDITE NORAD HTAUTOMAT 
radar interception Pakistan BOND Kennedy postcard corporate globalization
                          ( http://cscott.net/ )
