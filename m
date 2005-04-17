From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Merge with git-pasky II.
Date: Mon, 18 Apr 2005 01:34:41 +0200
Message-ID: <20050417233441.GU1461@pasky.ji.cz>
References: <E1DNI0G-0000bo-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0504171530150.7211@ppc970.osdl.org> <20050417232905.GA2721@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, mingo@elte.hu, simon@himi.org,
	david.lang@digitalinsight.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 01:31:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNJE5-00067F-8S
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 01:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVDQXeo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 19:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVDQXeo
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 19:34:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57497 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261557AbVDQXen (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 19:34:43 -0400
Received: (qmail 28858 invoked by uid 2001); 17 Apr 2005 23:34:41 -0000
To: Herbert Xu <herbert@gondor.apana.org.au>
Content-Disposition: inline
In-Reply-To: <20050417232905.GA2721@gondor.apana.org.au>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 18, 2005 at 01:29:05AM CEST, I got a letter
where Herbert Xu <herbert@gondor.apana.org.au> told me that...
> I get the feeling that it isn't that bad.  For example, if we did it
> at the points where the blobs actually entered the tree, then the cost
> is always proportional to the change size (the number of new blobs).

No. The collision check is done in the opposite cache - when you want to
write a blob and there is already a file of the same hash in the tree.
So either the blob is already in the database, or you have a collision.

Therefore, the cost is proportional to the size of what stays unchanged.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
