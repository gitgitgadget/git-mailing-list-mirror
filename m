From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] custom log formats for "diff --submodule=log"
Date: Mon, 12 Nov 2012 17:19:01 -0500
Message-ID: <20121112221901.GD10531@sigill.intra.peff.net>
References: <20121108202940.GA7982@sigill.intra.peff.net>
 <CALkWK0mYs7Q1256gY7ZH3Ng3xbYv2+XVHCZ7XYWgWUp2O-VzqQ@mail.gmail.com>
 <CALkWK0nT8RXXUUkLuS8zWVMG=wsm0b740q-qYb3iN3cO7Tb=0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Jeffrey S. Haemer" <jeffrey.haemer@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 23:19:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY2Lh-0003F3-Qp
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 23:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712Ab2KLWTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 17:19:07 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45118 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752663Ab2KLWTG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 17:19:06 -0500
Received: (qmail 14885 invoked by uid 107); 12 Nov 2012 22:19:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 17:19:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 17:19:01 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0nT8RXXUUkLuS8zWVMG=wsm0b740q-qYb3iN3cO7Tb=0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209535>

On Sun, Nov 11, 2012 at 06:35:16PM +0530, Ramkumar Ramachandra wrote:

> Ramkumar Ramachandra wrote:
> > Don't you mean `git diff` in place of `git log -p`
> > though?  I don't think `git log --submodule` does anything differently
> > from `git log`.
> 
> Sorry for the nonsense.  I just realized that it affects the diffs
> shown by `git log -p`.

Right. I don't know if that is a common workflow (I do not really use
submodules), but it was the first thing I tried when I heard about
--submodule (and it does make sense to me that it would work).

But the logic could apply equally well to:

  git diff --submodule=log:%an

-Peff
