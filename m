From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/2] t7001: add test for git-mv dir1 dir2/
Date: Fri, 28 Jul 2006 17:47:13 +0200
Message-ID: <20060728154713.GP13776@pasky.or.cz>
References: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de> <200607262039.25155.Josef.Weidendorfer@gmx.de> <20060728013038.GH13776@pasky.or.cz> <7vvepimoxr.fsf@assigned-by-dhcp.cox.net> <20060728025619.GK13776@pasky.or.cz> <7vr706mj0u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 28 17:47:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6UYa-0008QA-NK
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 17:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbWG1PrQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 11:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161164AbWG1PrQ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 11:47:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13710 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161124AbWG1PrP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 11:47:15 -0400
Received: (qmail 396 invoked by uid 2001); 28 Jul 2006 17:47:13 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr706mj0u.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24394>

Dear diary, on Fri, Jul 28, 2006 at 06:48:49AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> > Well, at once? I can do (iv) by adding --index but that contradicts (v).
> > But maybe I'm missing something.
> 
> What should the semantics of such operation be?  Apply to index
> on paths that are clean while leave the index entries untouched
> for paths that are dirty?  What should happen on renamed paths
> that are dirty?

Keep the original sha1 but change the name. If an entry with the new
name already exists, we might just leave the index alone and create a
.rej file. (Alternatively we might create two stages in the index file
but we can't do that in case of regular rejects so I'd rather stay
consistent.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
