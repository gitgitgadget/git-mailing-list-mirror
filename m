From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2010, #06; Sat, 17)
Date: Sun, 18 Apr 2010 14:57:53 -0400
Message-ID: <20100418185753.GB11366@coredump.intra.peff.net>
References: <7v7ho5xp3z.fsf@alter.siamese.dyndns.org>
 <20100418083641.GA17717@coredump.intra.peff.net>
 <7vvdbowrkq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Gilger <heipei@hackvalue.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 20:58:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3ZhO-0004j3-8z
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 20:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432Ab0DRS6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 14:58:25 -0400
Received: from peff.net ([208.65.91.99]:48892 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808Ab0DRS6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 14:58:25 -0400
Received: (qmail 5772 invoked by uid 107); 18 Apr 2010 18:58:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 18 Apr 2010 14:58:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Apr 2010 14:57:53 -0400
Content-Disposition: inline
In-Reply-To: <7vvdbowrkq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145238>

On Sun, Apr 18, 2010 at 11:20:21AM -0700, Junio C Hamano wrote:

> >> * jg/auto-initialize-notes-with-percent-n-in-format (2010-04-13) 1 commit
> >>  - pretty: Initialize notes if %N is used
> [...]
> 
> It is an assertion failure but the fix is low-impact enough to appear in
> the coming release.

Yeah, I forgot it was an assertion and not a segfault, but I think both
are things we would rather not see in a release.

>  t/t3301-notes.sh |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)

Your tests look sane to me.

-Peff
