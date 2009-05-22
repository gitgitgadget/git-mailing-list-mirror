From: Jeff King <peff@peff.net>
Subject: Re: Getting Commits from One Repository to Another
Date: Fri, 22 May 2009 03:26:06 -0400
Message-ID: <20090522072606.GA1409@coredump.intra.peff.net>
References: <7D9240D0-C8BA-40C6-A89E-8BC7E08B1163@gmail.com> <20090521040451.GC8091@sigill.intra.peff.net> <vpq8wkq95uu.fsf@bauges.imag.fr> <loom.20090521T200115-589@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ryan <duderino.lebowski@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 09:26:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7P8z-0001qH-C1
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 09:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbZEVH0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 03:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbZEVH0I
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 03:26:08 -0400
Received: from peff.net ([208.65.91.99]:36958 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834AbZEVH0H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 03:26:07 -0400
Received: (qmail 16951 invoked by uid 107); 22 May 2009 07:26:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 22 May 2009 03:26:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 22 May 2009 03:26:06 -0400
Content-Disposition: inline
In-Reply-To: <loom.20090521T200115-589@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119715>

On Thu, May 21, 2009 at 08:08:01PM +0000, Ryan wrote:

> Thanks to both of you for your help. I tried Peff's suggestion last
> night, and could not get it to work. Matthieu is correct that the
> public repo was not a clone but a fresh import. Furthermore, I
> discovered that work had been done between the last pull from private
> the the import into public. (Ugh!)

Ah, OK, I missed that when reading your initial report. Matthieu's
suggestion is the correct one, then.

> Anyway, before I saw Matthieu's post (away from internet, which is so
> rare these days), I managed to succeed by using git format-patch on
> the commits that I needed, and then used git am on the private repo.
> There was one conflict, but I was able to resolve it.
> 
> Hopefully I'm not faced with this problem again, but if so, I'll try
> Mattieu's suggestion.

Actually, you will find that "git rebase" is basically "format-patch |
am" under the hood, so you more or less did the same thing (but calling
rebase probably would have been a little more convenient).

-Peff
