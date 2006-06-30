From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Creating diff from 2.6.16 from cryptodev-2.6 git tree
Date: Fri, 30 Jun 2006 12:32:28 +1000
Message-ID: <20060630023228.GA28850@gondor.apana.org.au>
References: <44A47BE0.9060504@logix.cz> <20060630013627.GA27527@gondor.apana.org.au> <Pine.LNX.4.64.0606291904250.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Ludvig <michal@logix.cz>, linux-crypto@vger.kernel.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 04:33:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw8pD-0007PX-LR
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 04:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWF3Cdj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 22:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWF3Cdj
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 22:33:39 -0400
Received: from [64.62.148.172] ([64.62.148.172]:3590 "EHLO arnor.apana.org.au")
	by vger.kernel.org with ESMTP id S1751423AbWF3Cdi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 22:33:38 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by arnor.apana.org.au with esmtp (Exim 4.50 #1 (Debian))
	id 1Fw8o5-00008H-Te; Fri, 30 Jun 2006 12:32:33 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1Fw8o0-0007W3-00; Fri, 30 Jun 2006 12:32:28 +1000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606291904250.12404@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22948>

On Thu, Jun 29, 2006 at 07:25:01PM -0700, Linus Torvalds wrote:
> 
> The easiest by far is if you only care about a certain sub-directory. 
> Then, assuming the branch "crypto" is the top-most commit of the cryptodev 
> repo, just do
> 
> 	git diff v2.6.16..crypto -- crypto/

Yes, you should always do something like this when backporting to make
sure that you haven't missed patches merged in ways that you didn't
anticipate.

Although I'm not aware of any such patches in the time frame that Michal
has in mind.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
