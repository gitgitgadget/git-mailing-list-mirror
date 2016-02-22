From: Jeff King <peff@peff.net>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Mon, 22 Feb 2016 16:42:46 -0500
Message-ID: <20160222214246.GE15595@sigill.intra.peff.net>
References: <vpqoabox66p.fsf@anie.imag.fr>
 <CAP8UFD0UxB6Z1UU=4Bkz0Yt2KE+AkrttQeTx2oY9v9O78f9qow@mail.gmail.com>
 <vpqd1s2e74l.fsf@anie.imag.fr>
 <20160212130446.GB10858@sigill.intra.peff.net>
 <vpqd1s04zzs.fsf@anie.imag.fr>
 <CACsJy8BzkWSc11ODenEuGBBta+dkLS893o7oRS57_ctoB5ie8A@mail.gmail.com>
 <vpqziutkps7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 22 22:42:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXyFp-0005gR-6d
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 22:42:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755708AbcBVVmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 16:42:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:46964 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754742AbcBVVmt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 16:42:49 -0500
Received: (qmail 18795 invoked by uid 102); 22 Feb 2016 21:42:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 16:42:49 -0500
Received: (qmail 22300 invoked by uid 107); 22 Feb 2016 21:42:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 16:42:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 16:42:46 -0500
Content-Disposition: inline
In-Reply-To: <vpqziutkps7.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286955>

On Mon, Feb 22, 2016 at 11:22:48AM +0100, Matthieu Moy wrote:

> > Idea for microprojects. If you compile using gcc with -Wshadow, it
> > spots local variables that shadow another local or global variables.
> > These are usually bad because it makes it's easy to make mistakes when
> > changing the code.
> 
> I hade a look an a few instances of the warning, and all of them were
> bad (sometimes even suspicious, I wouldn't be surprised if we found real
> bugs hunting these down).

I looked at a handful, too, and many looked fine (e.g., shadowing an
overly-broadly-named global parameter with a function parameter). Not
that I'm against squelching them. There's definitely potential for
confusion, and I won't be surprised either if there's a real bug lurking
in there (which we can't find because of the number of false positives).

But...

> > _If_ you agree shadow vars are bad and should be exterminated,
> > 'master' has 94 warnings spreading over 49 files. A student can pick
> > _one_ file and try to fix all warnings in that file. There are many
> > possible approaches (rename, combine vars, change scope, even
> > restructure/kill global vars..), plenty of room for discussion.
> 
> +1.
> 
> Are there counter-arguments to this?

I agree that there are a lot of different ways to resolve each instance,
and it will vary from case to case. I think the original point of a
microproject was to do something really easy and not contentious, so
that the student could get familiar with all of the other parts of the
cycle: writing a commit message, formatting the patch, posting to the
list, etc.

It seems like this has a high chance of frustrating students as they get
embroiled in back-and-forth review. I dunno. Maybe it should be marked
with a star as a "challenge" microproject. :)

-Peff
