From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] pack-objects: stop respecting pack.writebitmaps
Date: Tue, 10 Jun 2014 17:29:46 -0400
Message-ID: <20140610212946.GB15332@sigill.intra.peff.net>
References: <20140610200741.GA11248@sigill.intra.peff.net>
 <20140610201913.GD14974@sigill.intra.peff.net>
 <xmqqoay08odi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 23:29:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuTc8-0004fD-1X
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbaFJV3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:29:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:41332 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753231AbaFJV3r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:29:47 -0400
Received: (qmail 18351 invoked by uid 102); 10 Jun 2014 21:29:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 16:29:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 17:29:46 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoay08odi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251239>

On Tue, Jun 10, 2014 at 02:07:37PM -0700, Junio C Hamano wrote:

> > Another option is to track it to graduate to master during the next
> > cycle. I.e., decide that the possible regression isn't a big deal.
> 
> My gut feeling is that the last one is sufficient.  These low level
> subcommands that are designed to be used by scripts (aka plumbing)
> shouldn't have configuration options in the first place, and users
> shouldn't depend on them even if they were added by design mistake.

That is my gut, too (and why I posted the patch). I was mostly just
trying to make sure it was not me being lazy (it is easy to be so when
you are the one writing the patches, rather than the one reviewing
them or acting as maintainer). :)

-Peff
