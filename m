From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 3/4] t5500-fetch-pack: remove local (bashism) usage.
Date: Mon, 29 May 2006 17:31:37 +1000
Message-ID: <20060529073137.GB22452@gondor.apana.org.au>
References: <11486091783808-git-send-email-normalperson@yhbt.net> <11486091793385-git-send-email-normalperson@yhbt.net> <20060526122317.GC5372@gondor.apana.org.au> <20060529052828.GB24077@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 09:31:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkcEA-0005dq-L2
	for gcvg-git@gmane.org; Mon, 29 May 2006 09:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWE2Hbs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 03:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWE2Hbs
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 03:31:48 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:23560 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750746AbWE2Hbr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 03:31:47 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by arnor.apana.org.au with esmtp (Exim 4.50 #1 (Debian))
	id 1FkcE2-0006lS-Hh; Mon, 29 May 2006 17:31:42 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1FkcDx-0005s0-00; Mon, 29 May 2006 17:31:37 +1000
To: Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <20060529052828.GB24077@localdomain>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20932>

On Sun, May 28, 2006 at 10:28:28PM -0700, Eric Wong wrote:
>
> Cool.  Hmm... pdksh seems to support it here (Debian sid).  I'm pretty
> sure local is not part of the POSIX spec, though; and I have seen
> /bin/sh that don't support it.

It is true that the current POSIX spec does not specify it.  However,
all useful POSIX-compliant shells on Linux (i.e., excluding those
shells that exist only to test POSIX compliance) support it and it
is used by a large corpus of existing Linux scripts.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
