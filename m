From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] ls-remote: default to 'origin' when no remote specified
Date: Thu, 8 Apr 2010 02:25:39 -0400
Message-ID: <20100408062539.GC30473@coredump.intra.peff.net>
References: <1270699083-5424-1-git-send-email-rctay89@gmail.com>
 <20100408044552.GA30473@coredump.intra.peff.net>
 <7v8w8y8q1f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 08:26:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzlBm-0007zH-HK
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 08:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756943Ab0DHG0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 02:26:00 -0400
Received: from peff.net ([208.65.91.99]:51759 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755657Ab0DHGZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 02:25:59 -0400
Received: (qmail 16683 invoked by uid 107); 8 Apr 2010 06:25:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 08 Apr 2010 02:25:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Apr 2010 02:25:39 -0400
Content-Disposition: inline
In-Reply-To: <7v8w8y8q1f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144324>

On Wed, Apr 07, 2010 at 10:35:40PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't really see a problem with this. The current behavior produces an
> > error, so it is not as if we are breaking somebody's workflow, and the
> > only sensible default is the same one used by the other commands.
> 
> I'd agree only if "the other commands" default to the same remote;
> otherwise as a plumbing, ls-remote should insist that the user be more
> explicit.
>
> The only odd-man out that would worry me is "git pull", as I expect
> everybody written in C would just use remote_get(NULL).

I agree, but I think they do all default to the same remote. Push and
fetch both use remote_get(NULL). Pull, AFAICT, just calls fetch and
picks out what to merge from FETCH_HEAD. Am I missing any others?

-Peff
