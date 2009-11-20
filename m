From: Jeff King <peff@peff.net>
Subject: Re: Default history simplification
Date: Fri, 20 Nov 2009 09:41:46 -0500
Message-ID: <20091120144146.GC5419@coredump.intra.peff.net>
References: <ae09c2a40911191530y626dd035q90de0212e0b4b6d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Tommy Wang <subscription@august8.net>
X-From: git-owner@vger.kernel.org Fri Nov 20 15:42:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBUgR-0000do-Mq
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 15:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbZKTOln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 09:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbZKTOln
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 09:41:43 -0500
Received: from peff.net ([208.65.91.99]:43402 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752717AbZKTOln (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 09:41:43 -0500
Received: (qmail 25773 invoked by uid 107); 20 Nov 2009 14:45:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Nov 2009 09:45:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Nov 2009 09:41:46 -0500
Content-Disposition: inline
In-Reply-To: <ae09c2a40911191530y626dd035q90de0212e0b4b6d8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133350>

On Thu, Nov 19, 2009 at 05:30:43PM -0600, Tommy Wang wrote:

> I'm working on a small perl script that needs to reproduce the results
> of the default git history simplification used by log & rev-list when
> a list of paths is given.  It is important that I reproduce its
> results exactly.  I would love to simply use the rev-list built-in to
> do my work for me; but I fear that I may have much too many path
> limiters than the linux command-line can handle (which if I'm correct,
> can only take so many arguments).

FYI, Junio just posted a patch for handling pathspec limiting over
--stdin, which would solve this problem for you.

  http://article.gmane.org/gmane.comp.version-control.git/133333

-Peff
