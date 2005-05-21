From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] Fix use of wc in t0000-basic
Date: Sat, 21 May 2005 21:01:29 +1000
Message-ID: <20050521110129.GA7924@gondor.apana.org.au>
References: <E1DZRMi-00021X-00@gondolin.me.apana.org.au> <7vhdgwj1ed.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, torvalds@osdl.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 13:07:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZRoz-0002Ow-EL
	for gcvg-git@gmane.org; Sat, 21 May 2005 13:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVEULIH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 07:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVEULIH
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 07:08:07 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:9997 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261727AbVEULIC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 07:08:02 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 3.35 #1 (Debian))
	id 1DZRjX-0004os-00; Sat, 21 May 2005 21:01:31 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1DZRjV-00025v-00; Sat, 21 May 2005 21:01:29 +1000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhdgwj1ed.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, May 21, 2005 at 03:53:30AM -0700, Junio C Hamano wrote:
> >>>>> "HX" == Herbert Xu <herbert@gondor.apana.org.au> writes:
> 
> HX> It's also better to use -eq instead of = since you are comparing
> HX> numbers, not strings.  If you do that you can keep the double
> HX> quotes since the spaces will be removed automatically.
> 
> I remember being burned by busybox "test" which did not ignore
> spaces.  I do not know if the latest one is fixed, though.

Are you sure that it didn't ignore the leading spaces with -eq?
The code in question just calls strtol.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
