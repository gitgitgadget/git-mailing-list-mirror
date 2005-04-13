From: Christopher Li <git@chrisli.org>
Subject: Re: Merge with git-pasky II.
Date: Wed, 13 Apr 2005 17:25:46 -0400
Message-ID: <20050413212546.GA17236@64m.dyndns.org>
References: <20050414002902.GU25711@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 02:32:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLsHe-0005y5-Lg
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 02:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVDNAfw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 20:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVDNAfw
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 20:35:52 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:61666 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261369AbVDNAfo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2005 20:35:44 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (rwcrmhc14) with ESMTP
          id <2005041400354201400hhaibe>; Thu, 14 Apr 2005 00:35:42 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id 2F9903F1EF; Wed, 13 Apr 2005 17:25:47 -0400 (EDT)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050414002902.GU25711@pasky.ji.cz>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

While you are there, do you mind to move the shell script
to a sub directory? Let's try how rename works.

Chris

On Thu, Apr 14, 2005 at 02:29:02AM +0200, Petr Baudis wrote:
>   Hello Linus,
> 
>   I think my tree should be ready for merging with you. It is the final
> tree and I've already switched my main branch for it, so it's what
> people doing git pull are getting for some time already.
> 
>   Its main contents are all of my shell scripts. Apart of that, some
> tiny fixes scattered all around can be found there, as well as some
> patches which went through the mailing list. My last merge with you
> concerned your commit 39021759c903a943a33a28cfbd5070d36d851581.
> 
>   It's again
> 
> 	rsync://pasky.or.cz/git/
> 
> this time my HEAD is fba83970090ef54c6eb86dcc2c2d5087af5ac637.
> 
>   Note that my rsync tree still contains even my old branch; I thought
> I'd leave it around in the public objects database for some time, shall
> anyone want to have a look at the history of some of the scripts. But if
> you want it gone, tell me and I will prune it (and perhaps offer it in
> /git-old/ or whatever). I'm using the following:
> 
> 	fsck-cache --unreachable $(commit-id) | grep unreachable \
> 		| cut -d ' ' -f 2 | sed 's/^\(..\)/.git\/objects\/\1\//' \
> 		| xargs rm
> 
>   Thanks,
> 
> -- 
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
