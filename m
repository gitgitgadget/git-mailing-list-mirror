From: Jeff King <peff@peff.net>
Subject: Re: Incorrect v1.7.10.4 tag on github?
Date: Fri, 15 Jun 2012 15:17:23 -0400
Message-ID: <20120615191723.GA26651@sigill.intra.peff.net>
References: <77A5E1CD-836A-4747-9E62-42C25C0D8B7D@sfu.ca>
 <20120615182534.GB14843@sigill.intra.peff.net>
 <7vvcis9ylx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Graham Ballantyne <grahamb@sfu.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 21:17:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfc1W-0006fN-LE
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 21:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757495Ab2FOTR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 15:17:28 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:57705
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757323Ab2FOTR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 15:17:26 -0400
Received: (qmail 2777 invoked by uid 107); 15 Jun 2012 19:17:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jun 2012 15:17:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2012 15:17:23 -0400
Content-Disposition: inline
In-Reply-To: <7vvcis9ylx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200084>

On Fri, Jun 15, 2012 at 12:14:18PM -0700, Junio C Hamano wrote:

> > It builds with the right version from the git repository (which runs
> > git-describe and sees we are on the v1.7.10.4 tag), but exporting the
> > tag's contents and building fails. I suspect that the git-1.7.10.4
> > tarball on kernel.org would also have the same problem.
> 
> It builds correctly if you download the tarball from the official
> location in the [ANNOUNCE] message.  This is because the build
> procedure for the official tarball does a bit more than just running
> "git archive-tar", which is what gitweb download interface does
> (namely, it adds the correct "version" file).

Thanks. I should have checked before responding. If it is just the
output of "git archive", and the problem is restricted to one version,
then I am not too worried about it. Re-tagging is out of the question,
anyway.

-Peff
