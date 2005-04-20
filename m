From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Possible problem with git-pasky-0.6.2 (patch: **** Only garbage was found in the patch input.)I
Date: Thu, 21 Apr 2005 01:12:12 +0200
Message-ID: <20050420231212.GN19112@pasky.ji.cz>
References: <200504201706.09656.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 01:08:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOOJ1-0004uD-1r
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 01:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVDTXM2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 19:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVDTXM2
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 19:12:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36320 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261830AbVDTXMP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 19:12:15 -0400
Received: (qmail 12595 invoked by uid 2001); 20 Apr 2005 23:12:12 -0000
To: Steven Cole <elenstev@mesatop.com>
Content-Disposition: inline
In-Reply-To: <200504201706.09656.elenstev@mesatop.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 21, 2005 at 01:06:09AM CEST, I got a letter
where Steven Cole <elenstev@mesatop.com> told me that...
> After getting the latest tarball, and make, make install:
> 
> Tree change: 55f9d5042603fff4ddfaf4e5f004d2995286d6d3:a46844fcb6afef1f7a2d93f391c82f08ea322221
> *100755->100755 blob    a78cf8ccab98861ef7aecb4cb5a79e47d3a84b67->74b4083d67eda87d88a6f92c6c66877bba8bda8a     gitcancel.sh
> Tracked branch, applying changes...
> Fast-forwarding 55f9d5042603fff4ddfaf4e5f004d2995286d6d3 -> a46844fcb6afef1f7a2d93f391c82f08ea322221
>         on top of 55f9d5042603fff4ddfaf4e5f004d2995286d6d3...
> patch: **** Only garbage was found in the patch input.
> 
> This may be a harmless message, but I thought I'd bring it to your attention.

This _is_ weird. What does

	$ git diff -r 55f9d5042603fff4ddfaf4e5f004d2995286d6d3:a46844fcb6afef1f7a2d93f391c82f08ea32222

tell you? What if you feed it to patch -p1? What if you feed it to git
apply?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
