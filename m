From: Jeff King <peff@peff.net>
Subject: Re: Fwd: git clone does not respect command line options
Date: Fri, 26 Feb 2016 04:57:55 -0500
Message-ID: <20160226095755.GA4361@sigill.intra.peff.net>
References: <CAMDzUtzoiJWzckTX818HJV=su0eEP35gsNDJ=+k_me08EDvxRg@mail.gmail.com>
 <CAMDzUtxQPMty0Nncr7Yj3up6Zb6F-E0QudOMOZO_jG-Goq0YBg@mail.gmail.com>
 <20160226073444.GA26340@sigill.intra.peff.net>
 <CAMDzUty5oWjS=4kvvYL7XNCY=xHm3N=+kaeT_zTtpkaMakMrmA@mail.gmail.com>
 <20160226075948.GA26994@sigill.intra.peff.net>
 <CA+P7+xpuiUQgWYRgVrwKkv27KiJGQ0COrR93cFzQzn2uVA6ypQ@mail.gmail.com>
 <20160226082437.GB26994@sigill.intra.peff.net>
 <CAMDzUtwG9pLz6CqxVEaw5xcZwQ2Ni37h_R45+frzJrRshgpZQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Guilherme <guibufolo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 10:58:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZF9w-0003UV-HG
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 10:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbcBZJ6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 04:58:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:49958 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750830AbcBZJ57 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 04:57:59 -0500
Received: (qmail 618 invoked by uid 102); 26 Feb 2016 09:57:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 04:57:58 -0500
Received: (qmail 2373 invoked by uid 107); 26 Feb 2016 09:58:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 04:58:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 04:57:55 -0500
Content-Disposition: inline
In-Reply-To: <CAMDzUtwG9pLz6CqxVEaw5xcZwQ2Ni37h_R45+frzJrRshgpZQg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287562>

On Fri, Feb 26, 2016 at 03:23:58PM +0530, Guilherme wrote:

> I did try -c credential.helper= and there was a second problem with that
> because an unset credential.helper is not the same as an empty
> credential.helper. An empty one printed an error because it tried to invoke
> 'git-credential-'.

Exactly. That's why I say that we can take over the empty string to mean
"clear the list"; it's currently nonsensical.

-Peff
