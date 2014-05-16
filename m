From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Fri, 16 May 2014 04:41:26 -0400
Message-ID: <20140516084126.GB21468@sigill.intra.peff.net>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 16 10:43:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlDjY-0006Jk-QT
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 10:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756660AbaEPInK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 04:43:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:52881 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753751AbaEPIl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 04:41:28 -0400
Received: (qmail 5160 invoked by uid 102); 16 May 2014 08:41:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 May 2014 03:41:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 May 2014 04:41:26 -0400
Content-Disposition: inline
In-Reply-To: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249280>

On Thu, May 15, 2014 at 03:56:29PM -0700, Junio C Hamano wrote:

> Two announcements for their version 0.2 on the list archive are not
> quite enough to advertise them to their users.

I do not think this README nor a mention in the release notes will get
their attention either, and many people (and packagers) will continue to
use the stale versions forever until those versions go away.

I would much rather _replace_ them with a README in the long run, and
people will notice that they are gone, and then use the README to update
their install procedure.

For 2.0, I am hesitant to do that, though I do not have a problem with a
README like this as a heads-up to prepare packagers for the future. I
say hesitant because people may have been test-packaging 2.0.0-rc3 in
preparation for release, and it will be annoying to them to suddenly
switch.

But that being said, this is Felipe's code. While we have a legal right
to distribute it in v2.0, if he would really prefer it out for v2.0, I
would respect that.

I would prefer to instrument the code with warnings, as that is the sort
of thing a packager moving from -rc3 to -final might not notice, and
shipping the warnings to end users who did not package the software in
the first place will not help them. It is the attention of the packagers
(and source-builders) you want to get.

Of course that is all just my two cents, and is mostly predicated on
there _being_ packagers of the contrib/ tools. It looks like there is a
Debian package in RFP status, but I don't know if that is following the
new release closely. And I don't know about other systems.

-Peff
