From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb: fix spelling errors in comments
Date: Sun, 27 Sep 2009 04:35:07 -0400
Message-ID: <20090927083507.GA25891@coredump.intra.peff.net>
References: <1254007953-1961-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Sep 27 10:35:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrpE8-0000ef-G9
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 10:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbZI0IfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 04:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753576AbZI0IfI
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 04:35:08 -0400
Received: from peff.net ([208.65.91.99]:38722 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753571AbZI0IfG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 04:35:06 -0400
Received: (qmail 18953 invoked by uid 107); 27 Sep 2009 08:38:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 27 Sep 2009 04:38:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Sep 2009 04:35:07 -0400
Content-Disposition: inline
In-Reply-To: <1254007953-1961-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129202>

On Sun, Sep 27, 2009 at 01:32:33AM +0200, Miklos Vajna wrote:

> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>  gitweb/gitweb.perl |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> The plural form of "id" is "ids", not "id's", right?

It is a matter of some debate, actually. As an abbreviation, it should
rightly be "ID", and therefore "IDs". Most style manuals indicate that
no apostrophe should be used these days, unless it is an abbreviation
separated by dots (e.g., "I.D.'s").

Some disagree, and some indicate that you should use an apostrophe where
it may be visually more clear (for example, in single-letter
abbreviations like "A's").

There is a nice summary of some style guides here:

  http://answers.google.com/answers/threadview?id=499296

Honestly, for such an informal bit of text as a code comment, I'm not
sure it is worth nit-picking the grammar (e.g., we should be
writing SHA-1 everywhere, and we obviously don't). I'll let Shawn decide
whether he wants to apply or not.

-Peff
