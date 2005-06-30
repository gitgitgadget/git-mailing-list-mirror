From: Sven Verdoolaege <skimo@liacs.nl>
Subject: Re: [PATCH] cvsimport: rewritten in Perl
Date: Thu, 30 Jun 2005 21:38:25 +0200
Message-ID: <20050630193825.GA17345@pc117b.liacs.nl>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 21:33:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do4m1-00031v-Pw
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 21:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbVF3Tjk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 15:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbVF3Tjj
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 15:39:39 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:44009 "EHLO rhodium.liacs.nl")
	by vger.kernel.org with ESMTP id S263019AbVF3TjW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 15:39:22 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id j5UJcP8B011413;
	Thu, 30 Jun 2005 21:38:30 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id C98B16FEA; Thu, 30 Jun 2005 21:38:25 +0200 (CEST)
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20050630161043.GR10850@kiste.smurf.noris.de>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2005 at 06:10:43PM +0200, Matthias Urlichs wrote:
> I'll find it. However, you don't actually need to re-import your
> existing CVS->GIT trees; as long as the dates and the branch names
> match, my script will continue where the other left off.

That seems to work, once I figured out I had to pass in the "-o master"
option (as cvs2git didn't create an "origin" branch).

If you don't, you get a rather cryptic message:
usage: git-read-tree (<sha> | -m [-u] <sha1> [<sha2> [<sha3>]])
read-tree failed: 256

You probably want to check whether the origin branch actually
exists.

Apparently you also need to pass the '-x' option to cvsps.
Otherwise, it won't look at anything new.

It would also be nice if the user could pass extra options
to cvsps (notably '-z').

skimo
