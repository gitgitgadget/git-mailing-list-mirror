From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 2/4] tests: Remove heredoc usage inside quotes
Date: Fri, 26 May 2006 22:22:31 +1000
Message-ID: <20060526122231.GB5372@gondor.apana.org.au>
References: <11486091783542-git-send-email-normalperson@yhbt.net> <11486091783808-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 14:23:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjbLF-0001HT-6w
	for gcvg-git@gmane.org; Fri, 26 May 2006 14:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWEZMWq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 08:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWEZMWq
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 08:22:46 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:12037 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932392AbWEZMWp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 08:22:45 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by arnor.apana.org.au with esmtp (Exim 4.50 #1 (Debian))
	id 1FjbKv-0002aE-IY; Fri, 26 May 2006 22:22:37 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1FjbKp-0001lA-00; Fri, 26 May 2006 22:22:31 +1000
To: Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <11486091783808-git-send-email-normalperson@yhbt.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20807>

On Thu, May 25, 2006 at 07:06:16PM -0700, Eric Wong wrote:
> The use of heredoc inside quoted strings doesn't seem to be
> supported by dash.  pdksh seems to handle it fine, however.

This is a bug in dash and should be fixed there instead.
Thanks for drawing my attention to it.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
