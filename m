From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Initialize notes trees if %N is used and no
 --show-notes given
Date: Tue, 6 Apr 2010 12:22:40 -0400
Message-ID: <20100406162240.GA5294@coredump.intra.peff.net>
References: <20100405115548.GA19971@macbook.lan.lan>
 <201004061127.01471.trast@student.ethz.ch>
 <20100406111904.GA46425@macbook.lan.lan>
 <201004061352.21945.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Gilger <heipei@hackvalue.de>, Git ML <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Apr 06 18:23:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzBYT-0005kJ-66
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 18:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177Ab0DFQXC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 12:23:02 -0400
Received: from peff.net ([208.65.91.99]:42322 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018Ab0DFQXA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 12:23:00 -0400
Received: (qmail 25670 invoked by uid 107); 6 Apr 2010 16:23:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 06 Apr 2010 12:23:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Apr 2010 12:22:40 -0400
Content-Disposition: inline
In-Reply-To: <201004061352.21945.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144153>

On Tue, Apr 06, 2010 at 01:52:21PM +0200, Thomas Rast wrote:

> > I'd really like %N to do the initialization. There is no other
> > placeholder which requires an extra option to work, if I see it
> > correctly.
> 
> %g[dDs] expand to nothing unless the log command walks reflogs, so
> there is some precedent.

%d loads decorations on demand, so there is some precedent the other
%way, too. I don't personally have a preference, though.

-Peff
