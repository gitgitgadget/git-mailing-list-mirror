From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 5/6] Make cg-diff use optparse, and add features
Date: Sat, 11 Jun 2005 02:02:55 +0200
Message-ID: <20050611000255.GI22111@pasky.ji.cz>
References: <42A8280A.3070607@gmail.com> <42A826D7.1060507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 01:59:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgtP2-0004gq-N5
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 01:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVFKADO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 20:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVFKADO
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 20:03:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:14752 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261482AbVFKAC6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2005 20:02:58 -0400
Received: (qmail 12461 invoked by uid 2001); 11 Jun 2005 00:02:55 -0000
To: Dan Holmsand <holmsand@gmail.com>
Content-Disposition: inline
In-Reply-To: <42A8280A.3070607@gmail.com> <42A826D7.1060507@gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jun 09, 2005 at 01:24:07PM CEST, I got a letter
where Dan Holmsand <holmsand@gmail.com> told me that...
> This adds some new features to cg-diff:

Dear diary, on Thu, Jun 09, 2005 at 01:29:14PM CEST, I got a letter
where Dan Holmsand <holmsand@gmail.com> told me that...
> This is more or less a rewrite of cg-log, that adds a bunch
> of new features and gives a substantial speedup.

I'm sorry, but those two patches are still way too big and therefore
basically unreviewable. Could you please split them further to a
per-feature patches?

A good place to start would be changing the [PATCH 2/6] color refactor
to actually _replace_ the color stuff of cg-log and cg-diff with the new
common cg-Xlib code - but please don't change the default colors in that
patch yet (that is because you shouldn't assume in your earlier patches
that later patches will be applied, or applied in the form you send
them; I don't know about the less search thing yet, since I didn't test
it, since I don't have a focused patch for it).

Also, if the big changes won't make your further job significantly
easier, it's probably good idea to first do the smaller changes and then
the big ones - I'm more likely to change something, well, big, in the
big patches. ;-)

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
