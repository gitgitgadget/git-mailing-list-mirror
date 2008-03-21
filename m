From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Easier setup for the vim contribs.
Date: Thu, 20 Mar 2008 21:56:21 -0400
Message-ID: <20080321015621.GC1613@coredump.intra.peff.net>
References: <1206031364.1717.11.camel@omicron.ep.petrobras.com.br> <2008-03-20-17-56-01+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Victor Bogado da Silva Lins <victor@bogado.net>,
	git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 02:57:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcWVG-0004lI-JT
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 02:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbYCUB4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 21:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbYCUB4Z
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 21:56:25 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3728 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491AbYCUB4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 21:56:24 -0400
Received: (qmail 13787 invoked by uid 111); 21 Mar 2008 01:56:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 20 Mar 2008 21:56:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2008 21:56:21 -0400
Content-Disposition: inline
In-Reply-To: <2008-03-20-17-56-01+trackit+sam@rfc1149.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77695>

On Thu, Mar 20, 2008 at 05:56:01PM +0100, Samuel Tardieu wrote:

> Victor> Just copy all files in the vim contrib directory to your .vim
> Victor> and it will configure the syntax.
> 
> Do you know if it has been submitted for inclusion in vim?

No, but there is an alternate and much fancier vim package (which
includes syntax highlighting) that is going to be in vim 7.2:

http://lists.alioth.debian.org/pipermail/pkg-vim-maintainers/2008-February/005169.html

Once that is out, we should probably either remove our contrib/vim or
add a note saying "better stuff is now in 7.2" (for those who are on
older versions). We could also maybe just start pointing people to that
version now:

  http://git.tpope.net/?p=vim-git.git;a=summary

-Peff
