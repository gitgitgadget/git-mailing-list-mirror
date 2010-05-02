From: Jeff King <peff@peff.net>
Subject: Re: RFD: tables in documentation
Date: Sun, 2 May 2010 01:06:22 -0400
Message-ID: <20100502050622.GF14776@coredump.intra.peff.net>
References: <4BDC74F3.2020206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun May 02 07:07:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8ROj-0004mW-Bg
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 07:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257Ab0EBFGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 01:06:24 -0400
Received: from peff.net ([208.65.91.99]:57824 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756Ab0EBFGY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 01:06:24 -0400
Received: (qmail 3771 invoked by uid 107); 2 May 2010 05:06:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 02 May 2010 01:06:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 May 2010 01:06:22 -0400
Content-Disposition: inline
In-Reply-To: <4BDC74F3.2020206@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146136>

On Sat, May 01, 2010 at 08:37:39PM +0200, Michael J Gruber wrote:

> Currently, all tables are formatted using indentation by spaces. This
> breaks whenever AsciiDoc's parsing changes.
> 
> Instead, I suggest to use AsciiDoc's table syntax which also produces
> proper tables in the HTML and man output. I formatted the first part of
> the first table in git-read-tree(1) like that so that you can compare
> easily.

Conceptually I am in favor of semantic markup where possible. I find the
resulting manpage a little harder to read, though. Is it possible for us
to style it a bit more (e.g., such a simple table looks better, IMHO,
without ascii-art borders).

> I put it up at http://repo.or.cz/w/git/mjg.git/commit/table-example for
> your viewing pleasure. I'd say it looks great even in links (but not in
> lynx). It also shows a problem of xmlto with multiple rowspans (the xml
> is correct, .1 apparently not), which could be circumvented easily by
> repeating those cells.

Did you put the source up anywhere? I didn't see it, but it would be
interesting to see how painful it is to write.

-Peff
