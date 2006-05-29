From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 3/4] t5500-fetch-pack: remove local (bashism) usage.
Date: Sun, 28 May 2006 22:28:28 -0700
Message-ID: <20060529052828.GB24077@localdomain>
References: <11486091783808-git-send-email-normalperson@yhbt.net> <11486091793385-git-send-email-normalperson@yhbt.net> <20060526122317.GC5372@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 07:28:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkaIq-0002ca-JM
	for gcvg-git@gmane.org; Mon, 29 May 2006 07:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWE2F2a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 01:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWE2F2a
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 01:28:30 -0400
Received: from hand.yhbt.net ([66.150.188.102]:10667 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751189AbWE2F23 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 01:28:29 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 6134E7DC005;
	Sun, 28 May 2006 22:28:28 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 28 May 2006 22:28:28 -0700
To: Herbert Xu <herbert@gondor.apana.org.au>
Content-Disposition: inline
In-Reply-To: <20060526122317.GC5372@gondor.apana.org.au>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20918>

Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Thu, May 25, 2006 at 07:06:17PM -0700, Eric Wong wrote:
> > None of the variables seem to conflict, so local was unnecessary.
> 
> BTW, dash supports (and has always supported) local which is a quite
> useful feature.

Cool.  Hmm... pdksh seems to support it here (Debian sid).  I'm pretty
sure local is not part of the POSIX spec, though; and I have seen
/bin/sh that don't support it.

-- 
Eric Wong
