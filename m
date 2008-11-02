From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git send-email: allow any rev-list option as an
	argument.
Date: Sun, 2 Nov 2008 00:35:23 -0400
Message-ID: <20081102043523.GE5261@coredump.intra.peff.net>
References: <1225450632-7230-3-git-send-email-madcoder@debian.org> <1225471925-2750-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 02 05:36:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwUhc-0000vS-HD
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 05:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbYKBEf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 00:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbYKBEf1
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 00:35:27 -0400
Received: from peff.net ([208.65.91.99]:1194 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbYKBEf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 00:35:26 -0400
Received: (qmail 22532 invoked by uid 111); 2 Nov 2008 04:35:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Nov 2008 00:35:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Nov 2008 00:35:23 -0400
Content-Disposition: inline
In-Reply-To: <1225471925-2750-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99810>

On Fri, Oct 31, 2008 at 05:52:05PM +0100, Pierre Habouzit wrote:

> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
> 
>   One can consider to squash that on top of
>   <1225450632-7230-3-git-send-email-madcoder@debian.org> to be able to pass
>   all non path arguments before a possible '--' to git format-patch.

Personally, I think the other patch is not useful without this. I often
pull out funny subsets of patches if I know it is safe to do so (e.g., I
collect small, unrelated bugfixes directly onto a single branch, but I
send them separately).

With this patch, I might even find send-email usable. :)

-Peff
