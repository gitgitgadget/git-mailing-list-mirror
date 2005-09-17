From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb search in multi-headed tree
Date: Sat, 17 Sep 2005 03:22:38 +0200
Message-ID: <20050917012238.GA29720@vrfy.org>
References: <20050912181101.GA22221@vrfy.org> <12c511ca0509160839391ea012@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 17 03:23:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGRPf-00031Q-7b
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 03:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVIQBWk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 21:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVIQBWk
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 21:22:40 -0400
Received: from soundwarez.org ([217.160.171.123]:20714 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1750805AbVIQBWk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 21:22:40 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 1E1EE1A41; Sat, 17 Sep 2005 03:22:39 +0200 (CEST)
To: Tony Luck <tony.luck@gmail.com>
Content-Disposition: inline
In-Reply-To: <12c511ca0509160839391ea012@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8748>

On Fri, Sep 16, 2005 at 08:39:20AM -0700, Tony Luck wrote:
> Kay,
> 
> My tree on kernel.org (.../aegl/linux-2.6.git) has two branches in
> refs/heads: release
> and test.  The HEAD symlink points to the release branch.
> 
> It seems that a search traverses from HEAD to root, so can only find
> things in the
> release branch.  I tried clicking on the "test" branch link at the
> foot of the top-level
> page before doing the search ... but it still seems to search from HEAD.
> 
> Any syntax I'm missing for this search?

You can only append "&h=test" to the search url now. I will change that
with the next version of gitweb to let the search follow the current $hash.

Thanks,
Kay
