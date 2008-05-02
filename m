From: Jeff King <peff@peff.net>
Subject: Re: To page or not to page
Date: Fri, 2 May 2008 08:36:56 -0400
Message-ID: <20080502123656.GA2680@sigill.intra.peff.net>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net> <7vlk2txn8n.fsf@gitster.siamese.dyndns.org> <8C3474E2-3A4F-44E8-B301-C36939C7BA11@sb.org> <807E185B-BEE5-4AAF-8DF4-EE597681D61C@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri May 02 14:37:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JruWG-0004Ta-Ow
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 14:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759390AbYEBMg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 08:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757705AbYEBMg5
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 08:36:57 -0400
Received: from peff.net ([208.65.91.99]:2230 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756840AbYEBMg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 08:36:56 -0400
Received: (qmail 30468 invoked by uid 111); 2 May 2008 12:36:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 02 May 2008 08:36:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 May 2008 08:36:56 -0400
Content-Disposition: inline
In-Reply-To: <807E185B-BEE5-4AAF-8DF4-EE597681D61C@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80983>

On Fri, May 02, 2008 at 12:34:10PM +0200, Wincent Colaiuta wrote:

> But evidently given that there has been so much backlash against the  
> patch the only way to keep everyone happy will be to make this  
> configurable.

Agreed.

But I wonder why there seems to be such a split between people who
clearly have short git-status output, and those who have long git-status
output.

I keep my "untracked files" list tidy. IOW, I always get:

  $ git status
  # On branch master
  nothing to commit (working directory clean)

and if I don't, then I should be taking some action to commit things,
clean them up, or add them to my .git/info/exclude file. Do other people
generally carry around a lot of cruft that "git status" reports?

-Peff
