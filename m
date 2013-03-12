From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] teach config parsing to read from strbuf
Date: Tue, 12 Mar 2013 15:29:59 -0400
Message-ID: <20130312192959.GG17099@sigill.intra.peff.net>
References: <20130310165642.GA1136@sandbox-ub.fritz.box>
 <20130310170052.GE1136@sandbox-ub.fritz.box>
 <20130312111806.GF11340@sigill.intra.peff.net>
 <20130312164254.GB4752@sandbox-ub.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 12 20:30:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFUuB-0007Qn-Pe
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 20:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933318Ab3CLTaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 15:30:08 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50043 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932439Ab3CLTaE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 15:30:04 -0400
Received: (qmail 29428 invoked by uid 107); 12 Mar 2013 19:31:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Mar 2013 15:31:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Mar 2013 15:29:59 -0400
Content-Disposition: inline
In-Reply-To: <20130312164254.GB4752@sandbox-ub.fritz.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217987>

On Tue, Mar 12, 2013 at 05:42:54PM +0100, Heiko Voigt wrote:

> > Your series does not actually add any callers of the new function. The
> > obvious "patch 5/4" would be to plumb it into "git config --blob", and
> > then we can just directly test it there (there could be other callers
> > besides reading from a blob, of course, but I think the point of the
> > series is to head in that direction).
> 
> Since this is a split of the series mentioned above there are no real
> callers yet. The main reason for the split was that I wanted to reduce
> the review burden of one big series into multiple reviews of smaller
> chunks. If you think it is useful to add the --blob option I can also
> test from there. It could actually be useful to look at certain
> .gitmodules options from the submodule script.

I am on the fence. I do not want to create more work for you, but I do
think it may come in handy, if only for doing submodule things from
shell. And it is hopefully not a very large patch. I'd say try it, and
if starts looking like it will be very ugly, the right thing may be to
leave it until somebody really wants it.

-Peff
