From: Jeff King <peff@peff.net>
Subject: Re: git push --quiet option does not seem to work
Date: Sun, 15 May 2016 17:23:32 -0400
Message-ID: <20160515212332.GB31809@sigill.intra.peff.net>
References: <CADKp0pwrKzHG7KVSMH+6OHuv9sKXTcKSsdKMEZ_fFdjWT+kW6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Chris B <chris.blaszczynski@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 23:23:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b23Vk-0005Ok-N5
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 23:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbcEOVXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 17:23:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:39962 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751701AbcEOVXf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 17:23:35 -0400
Received: (qmail 9135 invoked by uid 102); 15 May 2016 21:23:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 15 May 2016 17:23:34 -0400
Received: (qmail 1526 invoked by uid 107); 15 May 2016 21:23:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 15 May 2016 17:23:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 15 May 2016 17:23:32 -0400
Content-Disposition: inline
In-Reply-To: <CADKp0pwrKzHG7KVSMH+6OHuv9sKXTcKSsdKMEZ_fFdjWT+kW6g@mail.gmail.com>
 <CADKp0pw5FFDVvPz0CcjOTYteQ9jFn2jBZwaX6_n8r3UQRGcGdQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294687>

On Sun, May 15, 2016 at 04:29:36PM -0400, Chris B wrote:

> Try it by making some changes to files and committing them, and then push.
> It works fine for me when there is nothing to actually push, but not
> so when there are commits to push.

In my example there were commits to push.

As you noted, my test was on Linux, so it's certainly possible that it's
Windows-specific. What protocol are you pushing over (e.g., http follows
a very different code path for progress)?

-Peff
