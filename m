From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] Avoid using dc in git-count-objects
Date: Fri, 28 Oct 2005 13:20:15 +1000
Organization: Core
Message-ID: <E1EVKmt-0003xn-00@gondolin.me.apana.org.au>
References: <Pine.LNX.4.64.0510270801560.4664@g5.osdl.org>
Cc: smurf@smurf.noris.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 05:22:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVKoS-0006qY-CO
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 05:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbVJ1DVp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 23:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbVJ1DVp
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 23:21:45 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:15370 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S965076AbVJ1DVo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 23:21:44 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 3.36 #1 (Debian))
	id 1EVKmw-0000Lc-00; Fri, 28 Oct 2005 13:20:20 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1EVKmt-0003xn-00; Fri, 28 Oct 2005 13:20:15 +1000
To: torvalds@osdl.org (Linus Torvalds)
In-Reply-To: <Pine.LNX.4.64.0510270801560.4664@g5.osdl.org>
X-Newsgroups: apana.lists.os.linux.git
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10751>

Linus Torvalds <torvalds@osdl.org> wrote:
> 
> Oh - there's another similarity between $(..) and $((..)). They're both 
> POSIX 1003.2 standard features, so any "modern" shell should support them. 
> Although in practice I don't know if that means anything else than ksh 
> (where both syntaxes came from, actually).

There is also dash (http://gondor.apana.org.au/~herbert/dash/).
It complies with POSIX, is less than half the size of pdksh (83960 bytes
currently on i386), and is faster than pdksh.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
