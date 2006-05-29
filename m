From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/4] tests: Remove heredoc usage inside quotes
Date: Sun, 28 May 2006 22:30:17 -0700
Message-ID: <20060529053017.GC24077@localdomain>
References: <11486091783542-git-send-email-normalperson@yhbt.net> <11486091783808-git-send-email-normalperson@yhbt.net> <20060526122231.GB5372@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 07:30:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkaKg-0002qn-E7
	for gcvg-git@gmane.org; Mon, 29 May 2006 07:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWE2FaU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 01:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWE2FaU
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 01:30:20 -0400
Received: from hand.yhbt.net ([66.150.188.102]:13995 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751201AbWE2FaT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 01:30:19 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 070927DC020;
	Sun, 28 May 2006 22:30:17 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 28 May 2006 22:30:17 -0700
To: Herbert Xu <herbert@gondor.apana.org.au>
Content-Disposition: inline
In-Reply-To: <20060526122231.GB5372@gondor.apana.org.au>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20920>

Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Thu, May 25, 2006 at 07:06:16PM -0700, Eric Wong wrote:
> > The use of heredoc inside quoted strings doesn't seem to be
> > supported by dash.  pdksh seems to handle it fine, however.
> 
> This is a bug in dash and should be fixed there instead.
> Thanks for drawing my attention to it.

No problem.  I think these dash bugs should be fixed in dash, but
continue to be worked around in git as old versions of dash will
probably continue to exist for a long time.

-- 
Eric Wong
