From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Merge with git-pasky II.
Date: Mon, 18 Apr 2005 02:55:29 +0200
Message-ID: <20050418005529.GF1461@pasky.ji.cz>
References: <E1DNI0G-0000bo-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0504171530150.7211@ppc970.osdl.org> <20050417232905.GA2721@gondor.apana.org.au> <20050417233441.GU1461@pasky.ji.cz> <20050418004906.GA3132@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, mingo@elte.hu, simon@himi.org,
	david.lang@digitalinsight.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 02:52:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNKUP-0002tR-KG
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 02:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVDRAzf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 20:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVDRAzf
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 20:55:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17819 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261380AbVDRAza (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 20:55:30 -0400
Received: (qmail 3768 invoked by uid 2001); 18 Apr 2005 00:55:29 -0000
To: Herbert Xu <herbert@gondor.apana.org.au>
Content-Disposition: inline
In-Reply-To: <20050418004906.GA3132@gondor.apana.org.au>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 18, 2005 at 02:49:06AM CEST, I got a letter
where Herbert Xu <herbert@gondor.apana.org.au> told me that...
> Therefore the only conclusion I can draw is that we're only calling
> update-cache on the set of changed files, or at most a small superset
> of them.  In that case, the cost of the collision check *is* proportional
> to the size of the change.

Yes, of course, sorry for the confusion.  We only consider files you
either specify manually or which have their stat metadata changed
relative to the directory cache. (That is from the git-pasky
perspective; from the plumbing perspective, the user just does
update-cache on whatever he picks.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
