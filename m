From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/10] pickaxe: honor -i when used with -S and
 --pickaxe-regex; cleanups
Date: Mon, 24 Mar 2014 17:22:53 -0400
Message-ID: <20140324212253.GD13728@sigill.intra.peff.net>
References: <1395508560-19893-1-git-send-email-l.s.r@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:23:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSCKj-00013b-9D
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 22:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbaCXVW4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2014 17:22:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:46065 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751028AbaCXVWz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 17:22:55 -0400
Received: (qmail 8101 invoked by uid 102); 24 Mar 2014 21:22:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Mar 2014 16:22:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Mar 2014 17:22:53 -0400
Content-Disposition: inline
In-Reply-To: <1395508560-19893-1-git-send-email-l.s.r@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244873>

On Sat, Mar 22, 2014 at 06:15:50PM +0100, Ren=C3=A9 Scharfe wrote:

> This series allows the options -i/--regexp-ignore-case, --pickaxe-reg=
ex,
> and -S to be used together and work as expected to perform a pickaxe
> search using case-insensitive regular expression matching.  Its first
> half refactors the test script and extends test coverage a bit while
> we're at it.  The actual change is in the sixth patch.  It enables th=
e
> two following cleanups.  The last two patches are independent simple
> cleanups.

This all looks very nice.

Upon reading your cover letter, I wondered if somebody would ever want
case-sensitive "--grep", but case-insensitive pickaxe (or vice versa).
However, you are not adding case-insensitivity to -G/-S, but rather
applying it more consistently. So I think that ship has already sailed
anyway (and even if it did not, I think applying "-i" everywhere makes
the interface simpler for the common cases, so the loss of flexibility
may be worth it).

-Peff
