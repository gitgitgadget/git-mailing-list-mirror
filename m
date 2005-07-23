From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Deb Packaging fixes: Build against Mozilla libs for Debian, conflict with "git"
Date: Sat, 23 Jul 2005 15:23:35 -0400
Message-ID: <20050723192335.GA24071@mythryan2.michonline.com>
References: <20050723073707.GA3255@mythryan2.michonline.com> <Pine.LNX.4.58.0507230921320.6074@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Sebastian Kuzminsky <seb@highlab.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 21:24:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwPbd-00071O-7f
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 21:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVGWTXo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 15:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVGWTXn
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 15:23:43 -0400
Received: from mail.autoweb.net ([198.172.237.26]:56500 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261483AbVGWTXi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2005 15:23:38 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DwPay-0003A2-79; Sat, 23 Jul 2005 15:23:36 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DwPjN-0000o5-00; Sat, 23 Jul 2005 15:32:17 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DwPax-0000nI-G5; Sat, 23 Jul 2005 15:23:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507230921320.6074@g5.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 23, 2005 at 09:24:33AM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 23 Jul 2005, Ryan Anderson wrote:
> > 
> >     * Compile against the unencumbered Mozilla SHA1 code, instead of
> >       the iffy OpenSSL code.  This makes it easier to get the package
> >       included for distribution with Debian.
> 
> Note that this is just not true.
> 
> We still use openssl for the bignum stuff in epoch.c, so using the mozilla
> SHA1 libraries just doesn't make any difference at all from an openssl 
> standpoint. You'd have to disable the "--merge-order" flag entirely to get 
> rid of the openssl dependency, methinks.

I think that's going a bit far for the purpose of this packaging.

I reworked the comments in the changelog to make it clear that the
elimination of OpenSSL is not complete, and also address the comments
Junio made.

I'll reply to this email with that updated patch, but I've got this and
all the other pending Debian packaging fixes in
rsync://h4x0r5.com/git-ryan.git/

-- 

Ryan Anderson
  sometimes Pug Majere
