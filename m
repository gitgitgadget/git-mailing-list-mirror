From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Dec 2013, #02; Fri, 6)
Date: Tue, 10 Dec 2013 06:33:47 +0800
Message-ID: <20131209223345.GB11677@sigill.intra.peff.net>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>
 <87ppp8h9ut.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Dec 09 23:34:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq9Ot-0007x6-68
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 23:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809Ab3LIWd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 17:33:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:54841 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752681Ab3LIWd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 17:33:58 -0500
Received: (qmail 26367 invoked by uid 102); 9 Dec 2013 22:33:58 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (123.127.199.235)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Dec 2013 16:33:58 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Dec 2013 06:33:47 +0800
Content-Disposition: inline
In-Reply-To: <87ppp8h9ut.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239114>

On Sat, Dec 07, 2013 at 06:03:22PM +0100, Thomas Rast wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > * jk/pack-bitmap (2013-11-18) 22 commits
> [...]
> Peff can decide if he wants to reroll with my nits or not; either way
> I'm all for moving it forward and aiming for one of the next releases.

I'm going to be a bit slow this week, as I'm traveling in China.

I have at least one more local fix queued up (one of the re-rolls
introduced a use-after-free). Your comments make sense to me, though
some of them are "if this is not too hard", and I haven't looked yet to
see how hard some of the requisite refactoring would be. So expect at
least one more re-roll, and I'll try to incorporate your comments.
Thanks for giving it a careful reading.

As an aside, we have been running the last version sent to the list
(modulo the fix I mentioned above) on github.com for a week or two
(previously we were running the old, based-on-v1.8.4 version). So it is
getting exercised.

-Peff
