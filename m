From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Git.pm: better error message
Date: Mon, 14 Jun 2010 05:20:25 -0400
Message-ID: <20100614092024.GA7854@sigill.intra.peff.net>
References: <1276477222-21465-1-git-send-email-book@cpan.org>
 <20100614071046.GA5639@sigill.intra.peff.net>
 <20100614091916.GB31387@swoosh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Philippe Bruhat (BooK)" <book@cpan.org>
X-From: git-owner@vger.kernel.org Mon Jun 14 11:20:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO5qL-0002PZ-Jn
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 11:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755754Ab0FNJU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 05:20:28 -0400
Received: from peff.net ([208.65.91.99]:36052 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755756Ab0FNJU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 05:20:28 -0400
Received: (qmail 17047 invoked by uid 107); 14 Jun 2010 09:20:40 -0000
Received: from adsl-99-133-187-56.dsl.bltnin.sbcglobal.net (HELO sigill.intra.peff.net) (99.133.187.56)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 14 Jun 2010 05:20:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jun 2010 05:20:25 -0400
Content-Disposition: inline
In-Reply-To: <20100614091916.GB31387@swoosh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149088>

On Mon, Jun 14, 2010 at 11:19:16AM +0200, Philippe Bruhat (BooK) wrote:

> Come to think of it, it probably makes sense: -d probably depends on stat
> to get the information about the file, and that fails harder when the
> file in question doesn't exists.

Yeah, that makes sense to me.

> I guess the best would be to put the directory name in the error message
> (always interesting information), and keep $! in case it was set by an
> harder error.

Agreed.

-Peff
