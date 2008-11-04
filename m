From: Jeff King <peff@peff.net>
Subject: Re: Intensive rename detection
Date: Tue, 4 Nov 2008 01:16:47 -0500
Message-ID: <20081104061647.GA18297@coredump.intra.peff.net>
References: <216e54900811031717j70669868p3c7503357ceb5138@mail.gmail.com> <216e54900811031718o4cc81294sc0c32be1e71b9372@mail.gmail.com> <alpine.LFD.2.00.0811032021210.3419@nehalem.linux-foundation.org> <216e54900811032107p159e98ecn8958f0a78efde8f2@mail.gmail.com> <216e54900811032119h4cb51327v2d85712acc444185@mail.gmail.com> <216e54900811032202h5c82e3a9j30100e5b82f6a16a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Andrew Arnott <andrewarnott@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 07:18:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxFEv-0005N7-8h
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 07:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbYKDGQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 01:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbYKDGQw
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 01:16:52 -0500
Received: from peff.net ([208.65.91.99]:4507 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780AbYKDGQu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 01:16:50 -0500
Received: (qmail 5470 invoked by uid 111); 4 Nov 2008 06:16:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 04 Nov 2008 01:16:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Nov 2008 01:16:47 -0500
Content-Disposition: inline
In-Reply-To: <216e54900811032202h5c82e3a9j30100e5b82f6a16a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100043>

On Mon, Nov 03, 2008 at 10:02:37PM -0800, Andrew Arnott wrote:

> Hmmm.... actually on second run I am still getting the too many files
> warning.  I put the [diff] section in a ~/.gitconfig file, a
> .gitconfig file in the root of my repo, and in the .git/config file,
> but none of them seem to get rid of the message.

Where are you getting the warning? On "git status"?

If so, then this is an instance of the problem I mentioned here:

  [PATCH v3 7/8] wt-status: load diff ui config
  20081026044935.GG21047@coredump.intra.peff.net

(sorry, I would link to gmane, but it seems to be down at the moment).
Junio, maybe it is worth applying after all (we could also do just the
diff "basic" config instead).

-Peff
