From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Summary of core GIT while you are away.
Date: Thu, 26 May 2005 02:44:11 +0200
Message-ID: <20050526004411.GA12360@vrfy.org>
References: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, pasky@ucw.cz,
	braddr@puremagic.com, nico@cam.org, david@dgreaves.com,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 02:43:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db6Sf-0005RR-U9
	for gcvg-git@gmane.org; Thu, 26 May 2005 02:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVEZAoS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 20:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVEZAoS
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 20:44:18 -0400
Received: from soundwarez.org ([217.160.171.123]:38830 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261626AbVEZAoP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 20:44:15 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 32E5E39E20; Thu, 26 May 2005 02:44:11 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 16, 2005 at 09:10:10AM -0700, Linus Torvalds wrote:
> 
> The only thing I personally
> think sucks is the author/committer matching of git-rev-list/tree, since
> it would seem like somebody might well like to match on an arbitrary part
> of a commit, and special-casing author/committer seems somewhat broken. 

> I personally suspect that both git-rev-list and git-rev-tree should have
> an alternate output format that could be more easily grepped by subsequent
> commands. For example, right now git-rev-list just outputs a list of
> commit ID's, and it might make sense to have a flag to just append the
> commit message to the output, and zero-terminate it (and if the commit
> message has a NUL byte in it, just truncate it at that point).
> 
> Then you could just do
> 
> 	git-rev-list -v --header HEAD | grep -z 'author[^\n]*Linus'
> 
> to tell it to do the "verbose" thing (only showing the header of the 
> commit, not the whole message), and grep for "Linus" in the author line.

What happened to that idea? That's not already working in some other way I
missed, right? The pickaxe stuff is nice and was easy to call from the cgi,
but searching in commit messages would be nice too.
If it's not going to happen in the git-binaries, I may do it just in the
cgi itself.

Kay
