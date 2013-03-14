From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v2 4/4] teach config parsing to read from strbuf
Date: Thu, 14 Mar 2013 07:39:33 +0100
Message-ID: <20130314063933.GB4062@sandbox-ub.fritz.box>
References: <20130310165642.GA1136@sandbox-ub.fritz.box>
 <20130310170052.GE1136@sandbox-ub.fritz.box>
 <20130312111806.GF11340@sigill.intra.peff.net>
 <20130312164254.GB4752@sandbox-ub.fritz.box>
 <20130312192959.GG17099@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 14 07:40:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG1pf-00064Z-Gr
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 07:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443Ab3CNGjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 02:39:41 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.104]:56949 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950Ab3CNGjk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 02:39:40 -0400
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UG1p8-00040m-6N; Thu, 14 Mar 2013 07:39:34 +0100
Content-Disposition: inline
In-Reply-To: <20130312192959.GG17099@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218118>

On Tue, Mar 12, 2013 at 03:29:59PM -0400, Jeff King wrote:
> On Tue, Mar 12, 2013 at 05:42:54PM +0100, Heiko Voigt wrote:
> 
> > > Your series does not actually add any callers of the new function. The
> > > obvious "patch 5/4" would be to plumb it into "git config --blob", and
> > > then we can just directly test it there (there could be other callers
> > > besides reading from a blob, of course, but I think the point of the
> > > series is to head in that direction).
> > 
> > Since this is a split of the series mentioned above there are no real
> > callers yet. The main reason for the split was that I wanted to reduce
> > the review burden of one big series into multiple reviews of smaller
> > chunks. If you think it is useful to add the --blob option I can also
> > test from there. It could actually be useful to look at certain
> > .gitmodules options from the submodule script.
> 
> I am on the fence. I do not want to create more work for you, but I do
> think it may come in handy, if only for doing submodule things from
> shell. And it is hopefully not a very large patch. I'd say try it, and
> if starts looking like it will be very ugly, the right thing may be to
> leave it until somebody really wants it.

Thats what I will do: Try it and see where I get.

Cheers Heiko
