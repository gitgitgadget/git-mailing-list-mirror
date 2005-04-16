From: Christopher Li <git@chrisli.org>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 12:26:32 -0400
Message-ID: <20050416162632.GA3309@64m.dyndns.org>
References: <20050416131528.GB19908@elte.hu> <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org> <7vmzry7ev5.fsf@assigned-by-dhcp.cox.net> <42615B00.6090106@timesys.com> <7v8y3i7cn9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Taht <mike.taht@timesys.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 21:34:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMt3V-0000Jv-V7
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 21:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbVDPThT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 15:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVDPThT
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 15:37:19 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:13985 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262740AbVDPThC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 15:37:02 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (rwcrmhc13) with ESMTP
          id <2005041619365401500nmqg6e>; Sat, 16 Apr 2005 19:36:59 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id 9B8693F1EF; Sat, 16 Apr 2005 12:26:32 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8y3i7cn9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

We can just have a baseline file contain all the commit objects.
Then have the git "download on demand". The problem with diff
package  is that I it is harder to merge with more than one diff.

I bet 90% of the time people sync to the repository head first
want to check out the last bits. And maybe reading some change
log to see what is changed.

So having all the commit object, the user will able to see
what is change and which version he we like to check out.

Then he can issue a command "download me all the objects is needed
for checkout the this commit". Download of demand should be
even better.

Chris


On Sat, Apr 16, 2005 at 12:19:22PM -0700, Junio C Hamano wrote:
> >>>>> "MT" == Mike Taht <mike.taht@timesys.com> writes:
> 
> MT> alternatively, "git-archive-torrent" to create a list of files for a
> MT> bittorrent feed....
> 
> That is certainly good for establishing the baseline, but you
> still need to leverage the inherent delta-compressibility
> between related blobs/trees by also doing something like what I
> described as "diff package", don't you?
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
