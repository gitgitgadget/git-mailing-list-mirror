From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] Add [] as an alias for a reference to the empty
 tree
Date: Mon, 10 May 2010 05:20:54 -0400
Message-ID: <20100510092054.GA2602@coredump.intra.peff.net>
References: <1273250247-20762-1-git-send-email-pkj@axis.com>
 <20100508045319.GD14998@coredump.intra.peff.net>
 <7vhbmjc6dy.fsf@alter.siamese.dyndns.org>
 <A612847CFE53224C91B23E3A5B48BAC74482E511E7@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Mon May 10 11:21:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBPAb-0006Wa-R2
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 11:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585Ab0EJJU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 05:20:56 -0400
Received: from peff.net ([208.65.91.99]:52530 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752770Ab0EJJU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 05:20:56 -0400
Received: (qmail 2848 invoked by uid 107); 10 May 2010 09:21:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 10 May 2010 05:21:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 10 May 2010 05:20:54 -0400
Content-Disposition: inline
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC74482E511E7@xmail3.se.axis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146777>

On Mon, May 10, 2010 at 10:14:15AM +0200, Peter Kjellerstedt wrote:

> However, if INDEX, WORKTREE and EMPTY are preferred as syntactic sugar
> tokes, then that is fine by me. Unfortunately, I do not have the time
> nor the knowledge needed to add support for the INDEX and WORKTREE 
> tokens, so I am afraid I will have to leave this as a suggestion for 
> the future.

Implementing INDEX and WORKTREE would be quite challenging. EMPTY is
easy because it is really just a fake ref for a particular sha1. The
others need special casing everywhere that might look at the result.

So certainly if you want to do EMPTY, I wouldn't let the lack of the
other two hold you back. The only reason they are related at all is that
they would probably share a syntax, if the other two ever even get
implemented.

-Peff
