From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Cogito Tutorial If It Helps
Date: Tue, 26 Apr 2005 23:18:35 +0200
Message-ID: <20050426211834.GO13224@pasky.ji.cz>
References: <1114548747.3083.1.camel@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 23:15:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQXNl-0001Pb-DV
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 23:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVDZVSm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 17:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVDZVSm
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 17:18:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56208 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261792AbVDZVSk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 17:18:40 -0400
Received: (qmail 12770 invoked by uid 2001); 26 Apr 2005 21:18:35 -0000
To: James Purser <purserj@ksit.dynalias.com>
Content-Disposition: inline
In-Reply-To: <1114548747.3083.1.camel@kryten>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 26, 2005 at 10:52:27PM CEST, I got a letter
where James Purser <purserj@ksit.dynalias.com> told me that...
> I reworked the previous tutorial to take in the changes in the scripts.
> Will make this a series of tutorials to cover all aspects. Any
> suggestions or hints or spelling corrections would be most welcome.
> 
> http://ksit.dynalias.com/articles.php?s_id=46&art_id=41

Thanks for writing that! :-)

I'd vote for describing the cg-update right near cg-pull, or perhaps
even before cg-update, as the primary method; I think it's commonly what
people really want to do when they do cg-pull anyway.

cg-merge is _not_ like doing cg-diff | cg-patch - that's a dangerous
thought, and not true at all. cg-diff | cg-patch will just apply the
given diff to your working directory, but it won't record any merging
metadata, will often get it very wrong, and you will get to all sorts of
other troubles. Just always use cg-merge. And probably pass it -b only
when you know what are you doing.

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
