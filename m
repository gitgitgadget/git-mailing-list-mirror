From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb - feature request
Date: Fri, 12 Aug 2005 22:33:22 +0200
Message-ID: <20050812203322.GB9696@vrfy.org>
References: <20050809193104.GA10858@mars.ravnborg.org> <20050809195818.GA19284@vrfy.org> <1123653220.1183.26.camel@azathoth.hellion.org.uk> <20050810083113.GN49964@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ian Campbell <ijc@hellion.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 22:34:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3gDW-0003hc-7Y
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 22:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVHLUdX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 16:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVHLUdX
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 16:33:23 -0400
Received: from soundwarez.org ([217.160.171.123]:55965 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1750810AbVHLUdX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 16:33:23 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 4DA83574FD; Fri, 12 Aug 2005 22:33:22 +0200 (CEST)
To: Mitchell Blank Jr <mitch@sfgoth.com>
Content-Disposition: inline
In-Reply-To: <20050810083113.GN49964@gaz.sfgoth.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 10, 2005 at 01:31:13AM -0700, Mitchell Blank Jr wrote:
> Ian Campbell wrote:
> > I used to subscribe to the kernel RSS feed (using blam) but I found I
> > was only getting the most recent 20 commits, which wasn't much good when
> > a big batch went in because I would miss some.
> 
> Yes, I have that problem too.  It appears to be just the way that gitweb
> works - look at the "git_rss" function in the source:
>   ftp://ftp.kernel.org/pub/software/scm/gitweb/gitweb.cgi
> 
> Kay -- is there any chance of fixing this?  I love reading the kernel
> commits via RSS but this makes it a lot less usable than it could be.
> Really it should return all commits within, say, the last 36 hours so as
> long as your aggregator polls reasonably often you won't miss anyhing.

It's 30 now and up to 150 if they are not older than 48 hours.
We can change the numbers, if you hava a better idea...

> The other thing on my wishlish is diffstat -- sometimes the commit messages
> can be a little ambiguous and just adding what files were changed would
> help alot.  For commits that touch a large number of files maybe it could
> just show the files that changed the most like:

For now it just lists all changed files to the log message, similar to the
"commit" view. Is that ok, or do we really need the diffstat, It may be
a bit expensive to generate it for all the commits with every RSS request...

Thanks,
Kay
