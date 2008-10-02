From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] format-patch: autonumber by default
Date: Thu, 2 Oct 2008 16:03:33 -0400
Message-ID: <20081002200333.GA29303@coredump.intra.peff.net>
References: <48E4D73B.9090508@op5.se> <1222970291-5337-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 22:04:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlUPn-00013T-1V
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 22:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260AbYJBUDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 16:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754257AbYJBUDh
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 16:03:37 -0400
Received: from peff.net ([208.65.91.99]:2053 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753954AbYJBUDg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 16:03:36 -0400
Received: (qmail 29328 invoked by uid 111); 2 Oct 2008 20:03:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 02 Oct 2008 16:03:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Oct 2008 16:03:33 -0400
Content-Disposition: inline
In-Reply-To: <1222970291-5337-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97367>

On Thu, Oct 02, 2008 at 07:58:11PM +0200, Giuseppe Bilotta wrote:

> format-patch is often used for multiple patches at once when sending a
> patchset, in which case we want to number the patches; on the other
> hand, single-patches are not usually expected to be numbered.
> 
> The typical behavior expected by format-patch is therefore the one
> obtained by enabling autonumber, which should thus be the default.

I personally do not agree with this default. My usual use of
format-patch is to dump a cluster of miscellaneous patches since
"origin", and then grab the one(s) I want by title.

However, I would not be surprised to find that my use is unlike that of
most other people[1], so I am not opposed to the patch.

[1] Actually, my use has a deficiency, which is that I am often sending
2/4, without nobody having seen 1/4, on which it might actually depend.
This works in practice for me because I am often producing unrelated
janitorial patches for git. :)

So I think the goal is reasonable, but:

> ---
>  builtin-log.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)

Documentation update?

-Peff
