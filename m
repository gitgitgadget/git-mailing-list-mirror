From: Paul Mackerras <paulus@samba.org>
Subject: Re: [GITK PATCH] gitk: add menuitem for file checkout from
 selected or parent commit
Date: Sun, 12 Dec 2010 10:23:24 +1100
Message-ID: <20101211232324.GB3788@brick.ozlabs.ibm.com>
References: <20100928200344.GA12843@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Dec 12 00:24:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRYnL-0002Pz-OB
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 00:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216Ab0LKXX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Dec 2010 18:23:57 -0500
Received: from ozlabs.org ([203.10.76.45]:35798 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712Ab0LKXX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Dec 2010 18:23:57 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 292CAB70A7; Sun, 12 Dec 2010 10:23:56 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <20100928200344.GA12843@book.hvoigt.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163465>

On Tue, Sep 28, 2010 at 10:03:45PM +0200, Heiko Voigt wrote:

> This is useful if a user wants to checkout a file from a certain
> commit. This is equivalent to
> 
>   git checkout $commit $file
> 
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>

Thanks for the patch.  However, the commit message doesn't mention
that the patch also adds the 'checkout from parent' menu item or why
that's a useful thing to have.  I like the 'checkout from this commit'
thing but I don't immediately see why checking out from the first
parent is so useful that we have to have it as a menu item, but
checking out from other parents of a merge isn't.

Also, don't bother updating the po files.  The translators generally
prefer it if we don't.

Paul.
