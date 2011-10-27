From: Jeff King <peff@peff.net>
Subject: Re: Credentials and the Secrets API...
Date: Thu, 27 Oct 2011 10:48:07 -0700
Message-ID: <20111027174807.GD1967@sigill.intra.peff.net>
References: <CAEBDL5Udooim_3Za76Q1Rt_aGXtsSv76nxRegGWRBE=WJQzfZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Thu Oct 27 19:48:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJU3t-0006FO-RU
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 19:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215Ab1J0RsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 13:48:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56735
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753853Ab1J0RsK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 13:48:10 -0400
Received: (qmail 3852 invoked by uid 107); 27 Oct 2011 17:53:57 -0000
Received: from c-67-169-41-183.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.41.183)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Oct 2011 13:53:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Oct 2011 10:48:07 -0700
Content-Disposition: inline
In-Reply-To: <CAEBDL5Udooim_3Za76Q1Rt_aGXtsSv76nxRegGWRBE=WJQzfZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184308>

On Thu, Oct 27, 2011 at 12:05:03PM -0400, John Szakmeister wrote:

> Just wanted to keep folks in the loop.  It turns out that the Secrets
> API is still to young.  I asked about the format to store credentials
> in (as far as attributes), and got a response from a KDE developer
> that says it's still to young on their front.  They hope to have
> support in the next release of KDE.  But there's still the issue of
> what attributes to use.

Thanks for looking into this. That explains why I had such trouble
finding good documentation on it.

> With that information, I went ahead and created a
> gnome-credential-keyring that uses Gnome's Keyring facility.  I still
> need to do a few more things (mainly run it against Jeff's tests), but
> it's generally working.  Just wanted to keep folks in the loop.
> Hopefully, I can get patches out this weekend.

Great, I'm looking forward to reading it.

> Jeff: it would be really excellent to break out the various pieces.  I
> think it would also be better to split the asking for passwords from
> the storing of passwords.

That's my current plan. I just need to stop dragging my feet on
re-rolling the series.

-Peff
