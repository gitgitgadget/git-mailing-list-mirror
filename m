From: Jeff King <peff@peff.net>
Subject: Re: git pull --rebase --autostash
Date: Mon, 11 Jan 2016 16:03:34 -0500
Message-ID: <20160111210334.GB14535@sigill.intra.peff.net>
References: <CABKJOiy1+QAgp=_3ofr4CqNH7ZPP_eR4P71yGSgeAYLBz92AZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Federico Bond <federico.bond@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 22:03:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIjd5-0006wh-Ff
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 22:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760426AbcAKVDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 16:03:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:51584 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760328AbcAKVDh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 16:03:37 -0500
Received: (qmail 13810 invoked by uid 102); 11 Jan 2016 21:03:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jan 2016 16:03:37 -0500
Received: (qmail 5350 invoked by uid 107); 11 Jan 2016 21:03:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jan 2016 16:03:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jan 2016 16:03:34 -0500
Content-Disposition: inline
In-Reply-To: <CABKJOiy1+QAgp=_3ofr4CqNH7ZPP_eR4P71yGSgeAYLBz92AZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283717>

On Fri, Jan 08, 2016 at 12:24:09PM -0300, Federico Bond wrote:

> I was looking through the changes in 2.7 and learned about the very
> useful autostash feature of git rebase which was present since git
> 1.8.4.
> 
> I was wondering if there has been discussion about adding the same
> flag(s) for use with git pull --rebase. It seems odd that git pull
> --rebase honors the rebase.autostash config setting but there is no
> way to override it with a flag.
> 
> If you are OK with this, I can work on a patch to add --[no-]autostash
> to git pull.

I don't use either feature myself, but I agree that we generally like to
have matching command line flags to countermand config options.

I seem to recall another thread recently where somebody wanted to pass
an option to rebase via "git pull", but I can't seem to dig it up just
now. Having a generic way to pass such options seems like it could be
useful, though (e.g., "--keep-empty" might be useful).

-Peff
