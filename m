From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Add support for GIT_ONE_FILESYSTEM
Date: Tue, 30 Mar 2010 19:02:11 -0400
Message-ID: <20100330230211.GC608@coredump.intra.peff.net>
References: <1268855753-25840-1-git-send-email-lars@pixar.com>
 <1268855753-25840-4-git-send-email-lars@pixar.com>
 <20100328092253.GA17563@coredump.intra.peff.net>
 <7vr5n44crq.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1003301537150.3707@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Lars R. Damerow" <lars@pixar.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 31 01:02:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwkS4-0004Sq-Sm
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 01:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579Ab0C3XCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 19:02:24 -0400
Received: from peff.net ([208.65.91.99]:48761 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753276Ab0C3XCX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 19:02:23 -0400
Received: (qmail 26978 invoked by uid 107); 30 Mar 2010 23:02:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 30 Mar 2010 19:02:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Mar 2010 19:02:11 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1003301537150.3707@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143618>

On Tue, Mar 30, 2010 at 03:43:01PM -0700, Linus Torvalds wrote:

> I realize that I'm late to the party, but I do wonder if the "one 
> filesystem" mode shouldn't be the default, rather than be enabled by a 
> config option? IOW, just switch the meaning of the config option the other 
> way.

Fashionably late, of course. I agree with your reasoning that it is
a more sane default. The only thing that would make me hesitate on it
now is that it is a behavior change. I suspect the group we would be
breaking is small or even zero, though.

-Peff
