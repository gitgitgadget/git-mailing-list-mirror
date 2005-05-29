From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: change of git-diff-tree and symlinks
Date: Sun, 29 May 2005 17:06:56 +0200
Message-ID: <20050529150656.GA27127@vrfy.org>
References: <20050525111711.GA27492@vrfy.org> <4299CED5.5070508@roemling.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 17:05:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcPLP-0006Nl-MJ
	for gcvg-git@gmane.org; Sun, 29 May 2005 17:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVE2PHK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 11:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVE2PHK
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 11:07:10 -0400
Received: from soundwarez.org ([217.160.171.123]:14569 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261335AbVE2PHB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 11:07:01 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id B8D5A3AA52; Sun, 29 May 2005 17:06:56 +0200 (CEST)
To: Jochen Roemling <jochen@roemling.net>
Content-Disposition: inline
In-Reply-To: <4299CED5.5070508@roemling.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 29, 2005 at 04:16:53PM +0200, Jochen Roemling wrote:
> I'm planning to use cogito/git for tracking development of my (PHP 
> based) website. Although this is the first time in my life I'm using 
> something that smells like a SCM, it seems to work great. The only thing 
> lacking is a working gitweb installation.
> I downloaded the gitweb.cgi script from 
> kernel.org/pub/software/scm/gitweb, but it dates already May 23rd.
> 
> In your mail below from May 25 you state that there have been quite some 
> changes to git-diff-tree:
> 
> Kay Sievers wrote:
> >
> >The new one shows simply nothing.
> >Shouldn't it print the mode changes like the old one?
> >
> and that might be the reason why I'm getting "nothing" when I'm clicking 
> on a "commitdiff" link.

The kernel.org servers use Cogito which needs a new release. So the
version on kernel.org is always a working version with the current
release of Cogito as long as we don't get a git-core to provide the
binaries.

> After investigating further, I found out that the object type ("blob" in 
> the example above) is no longer printed by git-diff-tree.

The format has changed, just get the latest version of gitweb from my box
instead.

> Also there is a new parameter '-p' that allows the output of a patch 
> directly instead of creating it with the help of temporary files as you 
> do it in gitweb.

Sure, gitweb did the diffs before git was able to do that. And it does
not really matter who is creating the temp-files, the cgi or the
git-binaries. :)
If things are stable some day, I may switch that over and maybe even
support the nice rename detection.

> Could you please post a downloadable current release of gitweb to 
> kernel.org that works with the current git? If not, please tell me what 
> git release is installed at kernel.org so that I can use that branch to 
> get it to work with gitweb.

My latest version is here:
  ftp://ehlo.org/gitweb.cgi

> And as a last side note it would be helpfull if you could include a 
> release number in the gitweb footer as you did in the very beginning so 
> that we know if something changed and there is new stuff to explore...

It is in the html-source, right at the top.

Thanks,
Kay
