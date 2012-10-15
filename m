From: Jeff King <peff@peff.net>
Subject: Re: When Will We See Collisions for SHA-1? (An interesting analysis
 by Bruce Schneier)
Date: Mon, 15 Oct 2012 15:14:14 -0400
Message-ID: <20121015191414.GA6779@sigill.intra.peff.net>
References: <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>
 <CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com>
 <20121015183438.GB31658@sigill.intra.peff.net>
 <CA+EOSBki6-PWu=mwxr3PU0XC15cBhqr7L5Ay7-e9on+jGumsxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org, Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 21:14:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNq7Q-000700-I2
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 21:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402Ab2JOTOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 15:14:17 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53146 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827Ab2JOTOR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 15:14:17 -0400
Received: (qmail 5402 invoked by uid 107); 15 Oct 2012 19:14:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Oct 2012 15:14:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Oct 2012 15:14:14 -0400
Content-Disposition: inline
In-Reply-To: <CA+EOSBki6-PWu=mwxr3PU0XC15cBhqr7L5Ay7-e9on+jGumsxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207775>

On Mon, Oct 15, 2012 at 09:09:44PM +0200, Elia Pinto wrote:

> Hem , sha-3 i suppose, keccak, no ? But really is not so urgent as you
> have already told .

It depends. Read what Schneier wrote right before they announced the
SHA-3 winner:

  https://www.schneier.com/crypto-gram-1210.html#2

There's really no security reason not to use SHA-2, and in fact it's
probably better, as it has been more widely studied at this point. But
that part is easy; it's the compatibility switch-over that's hard (we
could also even parameterize the hash, but that has some annoyances,
too).

-Peff
