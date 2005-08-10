From: Mitchell Blank Jr <mitch@sfgoth.com>
Subject: Re: gitweb - feature request
Date: Wed, 10 Aug 2005 01:31:13 -0700
Message-ID: <20050810083113.GN49964@gaz.sfgoth.com>
References: <20050809193104.GA10858@mars.ravnborg.org> <20050809195818.GA19284@vrfy.org> <1123653220.1183.26.camel@azathoth.hellion.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 10 10:26:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2ltb-0005Wa-MO
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 10:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbVHJIYy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 04:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbVHJIYy
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 04:24:54 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:34783 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S964983AbVHJIYx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2005 04:24:53 -0400
Received: from gaz.sfgoth.com (localhost.sfgoth.com [127.0.0.1])
	by gaz.sfgoth.com (8.12.10/8.12.10) with ESMTP id j7A8VEi0094983;
	Wed, 10 Aug 2005 01:31:14 -0700 (PDT)
	(envelope-from mitch@gaz.sfgoth.com)
Received: (from mitch@localhost)
	by gaz.sfgoth.com (8.12.10/8.12.6/Submit) id j7A8VDvW094982;
	Wed, 10 Aug 2005 01:31:13 -0700 (PDT)
	(envelope-from mitch)
To: Ian Campbell <ijc@hellion.org.uk>
Content-Disposition: inline
In-Reply-To: <1123653220.1183.26.camel@azathoth.hellion.org.uk>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Wed, 10 Aug 2005 01:31:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ian Campbell wrote:
> I used to subscribe to the kernel RSS feed (using blam) but I found I
> was only getting the most recent 20 commits, which wasn't much good when
> a big batch went in because I would miss some.

Yes, I have that problem too.  It appears to be just the way that gitweb
works - look at the "git_rss" function in the source:
  ftp://ftp.kernel.org/pub/software/scm/gitweb/gitweb.cgi

Kay -- is there any chance of fixing this?  I love reading the kernel
commits via RSS but this makes it a lot less usable than it could be.
Really it should return all commits within, say, the last 36 hours so as
long as your aggregator polls reasonably often you won't miss anyhing.

The other thing on my wishlish is diffstat -- sometimes the commit messages
can be a little ambiguous and just adding what files were changed would
help alot.  For commits that touch a large number of files maybe it could
just show the files that changed the most like:

   net/bar.c              |  412 ++++++++++++-----
   drivers/char/foo.c     |  354 +-------------
   arch/baz/boot.S        |   99 ++++----
   [16 other files changed]

Other than that though I really love gitweb and the RSS support is a
great touch.  It really makes tracking kernel commits painless.

-Mitch
