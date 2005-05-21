From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix use of wc in t0000-basic
Date: Sat, 21 May 2005 10:24:57 -0700
Message-ID: <7vd5rkij9y.fsf@assigned-by-dhcp.cox.net>
References: <E1DZRMi-00021X-00@gondolin.me.apana.org.au>
	<7vhdgwj1ed.fsf@assigned-by-dhcp.cox.net>
	<20050521110129.GA7924@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, torvalds@osdl.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 19:24:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZXhh-0007xU-DU
	for gcvg-git@gmane.org; Sat, 21 May 2005 19:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVEURZE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 13:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVEURZE
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 13:25:04 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:23258 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261755AbVEURY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 13:24:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521172458.KSAH7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 13:24:58 -0400
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <20050521110129.GA7924@gondor.apana.org.au> (Herbert Xu's
 message of "Sat, 21 May 2005 21:01:29 +1000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "HX" == Herbert Xu <herbert@gondor.apana.org.au> writes:

HX> Are you sure that it didn't ignore the leading spaces with -eq?
HX> The code in question just calls strtol.

Sorry, I am not sure whose fault it was, and the recollection
comes from my distant past.  It could have been that the
smallish shell in that semi-embedded environment had an
incompatible built-in "test" command which was burning me, but
I distinctively remember changing many of the vendor supplied
shell script that had:

    if test " $number" -eq 3
    then
        ...

either stripping dq around it or simply removing the space from
there, depending on how that $number was generated.

Since I assume we are only talking about portability across
POSIXy world I do not think this is a big issue.

