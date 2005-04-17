From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Merge with git-pasky II.
Date: Mon, 18 Apr 2005 08:12:32 +1000
Organization: Core
Message-ID: <E1DNI0G-0000bo-00@gondolin.me.apana.org.au>
References: <Pine.LNX.4.58.0504171014430.7211@ppc970.osdl.org>
Cc: mingo@elte.hu, pasky@ucw.cz, simon@himi.org,
	david.lang@digitalinsight.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 00:10:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNHyh-0000Rk-Fh
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 00:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVDQWOm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 18:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVDQWOm
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 18:14:42 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:58122 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261504AbVDQWOk
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 18:14:40 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 3.35 #1 (Debian))
	id 1DNI1W-0006xv-00; Mon, 18 Apr 2005 08:13:50 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1DNI0G-0000bo-00; Mon, 18 Apr 2005 08:12:32 +1000
To: torvalds@osdl.org (Linus Torvalds)
In-Reply-To: <Pine.LNX.4.58.0504171014430.7211@ppc970.osdl.org>
X-Newsgroups: apana.lists.os.linux.git
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> 
> If we want to have any kind of confidence that the hash is reall
> yunbreakable, we should make it not just longer than 160 bits, we should
> make sure that it's two or more hashes, and that they are based on totally
> different principles.

Sorry, it has already been shown that combining two difference hashes
doesn't necessarily provide the security that you would hope.

I think what hasn't been discussed here is the cost of actually doing
the comparisons.  In other words, what is the minimum number of
comparisons we can get away and still deal with hash collisions
successfully?

Once we know what the cost is then we can decide whether it's worthwhile
considering the odds involved.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
