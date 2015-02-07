From: Jeff King <peff@peff.net>
Subject: Re: BUG: 'error: invalid key: pager.show_ref' on 'git show_ref'
Date: Fri, 6 Feb 2015 23:52:20 -0500
Message-ID: <20150207045219.GA15548@peff.net>
References: <20150206124528.GA18859@inner.h.apk.li>
 <20150206193313.GA4220@peff.net>
 <xmqq386ihk5w.fsf@gitster.dls.corp.google.com>
 <20150206203716.GA10857@peff.net>
 <xmqqk2zud6b0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Krey <a.krey@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 05:52:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJxNh-0003eJ-UC
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 05:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbbBGEwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 23:52:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:46230 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751286AbbBGEwW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 23:52:22 -0500
Received: (qmail 29824 invoked by uid 102); 7 Feb 2015 04:52:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Feb 2015 22:52:22 -0600
Received: (qmail 14385 invoked by uid 107); 7 Feb 2015 04:52:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Feb 2015 23:52:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Feb 2015 23:52:20 -0500
Content-Disposition: inline
In-Reply-To: <xmqqk2zud6b0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263437>

On Fri, Feb 06, 2015 at 02:27:31PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > A list of enum-like values where we are OK confining the names to the
> > alnums is OK to use as an unbounded set of key values. Just like we have
> > color.branch.*, we just pick a name within that syntax for any new
> > values we add (and that is not even a burden; alnum names are what we
> > would have picked anyway).
> 
> I would say that color.branch.<slot> names are very different from
> subcommand names.  The latter is exposed to the end users who do not
> have to know that they can be used and must be usable as config
> keys.

Yeah, again, sorry if I wasn't clear. That was the same contrast I was
making. Of the examples given in this thread, color.branch.<slot> and
fsck.* names are in one boat ("OK to give them configuration-friendly
names, they are just a list") and arbitrary commands are in another.

-Peff
