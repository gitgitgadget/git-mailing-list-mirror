From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones
 fail
Date: Tue, 17 Nov 2015 16:34:40 -0500
Message-ID: <20151117213440.GA27862@sigill.intra.peff.net>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
 <20151113053547.GD29708@sigill.intra.peff.net>
 <D21E9A9A-7444-4585-9066-3546F172A0EC@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sbeller@google.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 22:34:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zynto-0001KJ-7i
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 22:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393AbbKQVeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 16:34:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:58947 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932317AbbKQVen (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 16:34:43 -0500
Received: (qmail 9779 invoked by uid 102); 17 Nov 2015 21:34:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Nov 2015 15:34:43 -0600
Received: (qmail 30055 invoked by uid 107); 17 Nov 2015 21:35:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Nov 2015 16:35:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Nov 2015 16:34:40 -0500
Content-Disposition: inline
In-Reply-To: <D21E9A9A-7444-4585-9066-3546F172A0EC@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281420>

On Sun, Nov 15, 2015 at 01:53:31PM +0100, Lars Schneider wrote:

> > Hrm. Do we want to make these workarounds work correctly? Or is the
> > final solution going to be that the first command you gave simply works,
> > and no workarounds are needed.  If the latter, I wonder if we want to be
> > adding tests for the workarounds in the first place.
> > 
> > I'm not clear on the expected endgame.
> 
> I see your point. I'll remove the workaround tests in the next roll.
> That being said, I think the we should do something about the
> workarounds, too, because it certainly confused me as Git user. Would
> you merge a patch that prints a warning message like "--depth
> parameter not supported for submodules update command" or something if
> a user tries this command?

I would never promise to merge something without seeing it first. :)

It does sound sensible to me to warn the user when some of their request
is being ignored. I'm not familiar enough with submodules to know
whether there are hidden gotchas here (so I would rely on folks like
Stefan and Jens for review).

-Peff
