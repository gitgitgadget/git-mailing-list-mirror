From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Teach git push .git/branches shorthand
Date: Mon, 8 Aug 2005 18:22:24 +0200
Message-ID: <200508081822.24582.Josef.Weidendorfer@gmx.de>
References: <7viryhgdo5.fsf@assigned-by-dhcp.cox.net> <200508081225.59949.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.63.0508081234300.32668@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 08 18:24:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2APJ-0000wD-EB
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 18:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVHHQXK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 12:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbVHHQXK
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 12:23:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:13964 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932104AbVHHQXK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2005 12:23:10 -0400
Received: (qmail invoked by alias); 08 Aug 2005 16:23:03 -0000
Received: from a172.tum.vpn.lrz-muenchen.de (EHLO a172.tum.vpn.lrz-muenchen.de) [129.187.51.172]
  by mail.gmx.net (mp019) with SMTP; 08 Aug 2005 18:23:03 +0200
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <Pine.LNX.4.63.0508081234300.32668@wgmdd8.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Monday 08 August 2005 12:36, Johannes Schindelin wrote:
> Hi,
>
> On Mon, 8 Aug 2005, Josef Weidendorfer wrote:
> > Your example defaults to the master head.
>
> My point being that I still can say
>
> 	git pull x some_non_default_head
>
> with a file "x" in .git/branches.

Is this currently possible?

My understanding of .git/branches was that Cogito uses this as mapping of 
remote branches/heads to local branches/refs, and not to store shortcuts for 
remote git repositories.
IMHO, the above usage is a kind of "type mismatch", as the "x" already 
contains the branch.

But perhaps for git it is enough to only have a directory of shortcuts for 
remote repositories, to be found in .git/remotes?

And cogito can use its own subdirectory for remote/local head mappings. This 
mapping even could use the shortcuts from .git/remotes.

> Anyway, I don't care much either way, if 
> it be "remotes/" or "remoterefs/" or
> "magic_mapping_for_remote_repositories/" or even "repositories/".

Me either.

Josef

>
> Ciao,
> Dscho
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
