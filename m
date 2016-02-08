From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1] config: add '--sources' option to print the source of
 a config value
Date: Mon, 8 Feb 2016 07:11:09 -0500
Message-ID: <20160208121108.GB24217@sigill.intra.peff.net>
References: <1454661750-85703-1-git-send-email-larsxschneider@gmail.com>
 <56B483C0.6070906@gmail.com>
 <20160205112240.GA18581@sigill.intra.peff.net>
 <DF57DD4F-630F-421D-A379-0A451F6509DF@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 13:11:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSkey-0007q9-RJ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 13:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbcBHMLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 07:11:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:39138 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752113AbcBHMLL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 07:11:11 -0500
Received: (qmail 24107 invoked by uid 102); 8 Feb 2016 12:11:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 07:11:11 -0500
Received: (qmail 4369 invoked by uid 107); 8 Feb 2016 12:11:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 07:11:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 07:11:09 -0500
Content-Disposition: inline
In-Reply-To: <DF57DD4F-630F-421D-A379-0A451F6509DF@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285758>

On Sun, Feb 07, 2016 at 08:28:26PM +0100, Lars Schneider wrote:

> > I think he inherited the "--sources" name from me. :) I agree it could
> > be better. I think "--show-filename" is not right as there are
> > non-filename cases.  Just "--origin" sounds funny to me, perhaps because
> > of git's normal use of the word "origin".
> > 
> > I like "--show-origin" the best of the ones suggested.
> 
> I understand your reasoning and I agree that "--show-origin" is better than
> "--sources". However, I think just the word "origin" could be misleading in 
> this context because people associate it with Git remotes. How about
> "--show-config-origin" then? Or would that be too verbose?

I think "-config" is redundant here, as we are running "git config". We
have "--add" and not "--add-config", after all.

I dunno. TBH, I do not find --sources to be all that bad. I suspect we
could nitpick any name, and at least it is short and unique.

-Peff
