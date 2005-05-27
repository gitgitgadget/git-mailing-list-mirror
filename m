From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Summary of core GIT while you are away.
Date: Fri, 27 May 2005 02:22:25 +0200
Message-ID: <20050527002225.GB9858@vrfy.org>
References: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org> <20050526004411.GA12360@vrfy.org> <Pine.LNX.4.58.0505251826460.2307@ppc970.osdl.org> <20050526202712.GA6024@vrfy.org> <7vy8a18w1e.fsf@assigned-by-dhcp.cox.net> <20050526235944.GB6215@vrfy.org> <7vfyw98qvp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, pasky@ucw.cz,
	braddr@puremagic.com, nico@cam.org, david@dgreaves.com,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 02:21:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbSaf-0003ur-HT
	for gcvg-git@gmane.org; Fri, 27 May 2005 02:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVE0AWd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 20:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVE0AWd
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 20:22:33 -0400
Received: from soundwarez.org ([217.160.171.123]:25552 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261712AbVE0AW3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2005 20:22:29 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 92CA03A4EE; Fri, 27 May 2005 02:22:25 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyw98qvp.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 26, 2005 at 05:16:42PM -0700, Junio C Hamano wrote:
> >>>>> "KS" == Kay Sievers <kay.sievers@vrfy.org> writes:
> 
> KS> On Thu, May 26, 2005 at 03:25:17PM -0700, Junio C Hamano wrote:
> >> >>>>> "KS" == Kay Sievers <kay.sievers@vrfy.org> writes:
> >> 
> KS> Nice, thanks. Here is a very first try. It searches the commit messages
> KS> and uses pickaxe to search in the file content:
> KS> http://ehlo.org/~kay/gitweb.cgi?p=git/git.git;a=search;s=symlink
> >> 
> >> Nice, thanks for using pickaxe ;-).  One request, knowing well
> >> that what you have on ehlo is your first cut.
> 
> KS> Yeah, I like it a lot. Nice work.
> 
> KS> Any idea, what's the reason, it doesn't find anything here in the
> KS> kernel tree:
> KS>   git-rev-list HEAD | git-diff-tree -S'TIMEOUT' --stdin
> 
> Dies this work for you?  Notice "-r".
> 
> git-rev-list HEAD | git-diff-tree -r -S'TIMEOUT' --stdin

Yes, works perfect! Sorry, I need to get used to repositories with subdirectories. :)

Thanks,
Kay
