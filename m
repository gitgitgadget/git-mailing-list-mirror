From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add tests for git log --pretty, --format and --oneline.
Date: Wed, 25 Feb 2009 05:20:25 -0500
Message-ID: <20090225102024.GA16894@coredump.intra.peff.net>
References: <7vljrvhh13.fsf@gitster.siamese.dyndns.org> <1235509597-18336-1-git-send-email-felipe.contreras@gmail.com> <7vtz6i4zah.fsf@gitster.siamese.dyndns.org> <20090225095741.GB16357@coredump.intra.peff.net> <7vljru4y9j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 11:22:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcGtq-0003BL-MY
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 11:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759502AbZBYKUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 05:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757368AbZBYKUa
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 05:20:30 -0500
Received: from peff.net ([208.65.91.99]:52287 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752499AbZBYKUa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 05:20:30 -0500
Received: (qmail 25550 invoked by uid 107); 25 Feb 2009 10:20:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Feb 2009 05:20:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Feb 2009 05:20:25 -0500
Content-Disposition: inline
In-Reply-To: <7vljru4y9j.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111438>

On Wed, Feb 25, 2009 at 02:16:40AM -0800, Junio C Hamano wrote:

> >> Because 4202 seems to be about testing the log functionality and they rely
> >> on correctly working format output to verify other aspects of the
> >> operation of "git log", I initially was not sure if this is the right
> >> place to add these new tests.  After looking around I didn't find any
> >> existing test that checks the various --pretty output formats that the new
> >> tests can be added, so this probably is as good a place as any.
> >
> > t6006?
> 
> Good eyes.  But sorry I've already queued the four patches to 'next' and
> pushed the result out.  It probably is not worth moving the tests between
> two files as a follow-up patch.

Good memory; I wrote t6006. ;)

I don't think it is a big deal. I actually thought of it when I read the
original patch but decided not to say anything. t6006 is really about
exercising the formats themselves, so you could argue that the new tests
go just as well in either spot.

-Peff
