From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] don't mention index refreshing side effect in
	git-status docs
Date: Sun, 9 Dec 2007 03:42:17 -0500
Message-ID: <20071209084217.GA2377@coredump.intra.peff.net>
References: <20071209082133.GA2257@coredump.intra.peff.net> <7vhciss1ww.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 09:42:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1HkH-00081K-BZ
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 09:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbXLIImU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 03:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbXLIImU
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 03:42:20 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2078 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbXLIImU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 03:42:20 -0500
Received: (qmail 23891 invoked by uid 111); 9 Dec 2007 08:42:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 09 Dec 2007 03:42:19 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Dec 2007 03:42:17 -0500
Content-Disposition: inline
In-Reply-To: <7vhciss1ww.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67609>

On Sun, Dec 09, 2007 at 12:33:19AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If there is some desire to document the side effect, I think we should
> > at least remove the mention of speeding up git-diff (which is just wrong
> > now).
> 
> Why is it "just wrong"?  Having to squelch the false hits and to run
> auto-refresh are both unnecessary overhead if your index is fresh.

I mean that this is not a useful technique for speeding up git-diff
anymore (assuming you have not tinkered with autorefreshindex, in which
case I assume you know what you are doing and don't need this tip).

Did you think I meant "there is no speedup with autorefreshindex off",
or are you arguing that even with the new diff behavior there is still a
speedup in "git status; git diff" over just "git status"?

-Peff
