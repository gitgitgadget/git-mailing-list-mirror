From: Jeff King <peff@peff.net>
Subject: Re: git behaviour question regarding SHA-1 and commits
Date: Mon, 14 Nov 2011 06:32:35 -0500
Message-ID: <20111114113235.GE10847@sigill.intra.peff.net>
References: <CAJuRt+r9BjYcead6hgzdUT0Bisz1D48cegqkoJ0S537VMYBy_g@mail.gmail.com>
 <20111113182757.GA15194@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: vinassa vinassa <vinassa.vinassa@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 12:32:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPumJ-0004lI-Fq
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 12:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137Ab1KNLcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 06:32:39 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41017
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752681Ab1KNLci (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 06:32:38 -0500
Received: (qmail 28553 invoked by uid 107); 14 Nov 2011 11:32:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Nov 2011 06:32:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2011 06:32:35 -0500
Content-Disposition: inline
In-Reply-To: <20111113182757.GA15194@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185379>

On Sun, Nov 13, 2011 at 12:27:57PM -0600, Jonathan Nieder wrote:

> Though I haven't tested.  It would be nice to have an md5git (or even
> truncated-sha1-git) program to test this kind of thing with.

Fortunately we have such a thing:

  http://article.gmane.org/gmane.comp.version-control.git/184243

That one actually has 40 bits of hash entropy, so you'd expect to
generate 2^20 (about a million) commits before accidentally colliding.
If you want an easier experiment, you could truncate it even further.

-Peff
