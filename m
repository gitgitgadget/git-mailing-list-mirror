From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] notes: allow merging from arbitrary references
Date: Tue, 24 Nov 2015 17:47:10 -0500
Message-ID: <20151124224709.GA13691@sigill.intra.peff.net>
References: <1447432462-21192-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 23:52:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1MRe-00044H-1r
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 23:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbbKXWwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 17:52:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:33525 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932627AbbKXWrN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 17:47:13 -0500
Received: (qmail 28450 invoked by uid 102); 24 Nov 2015 22:47:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 16:47:12 -0600
Received: (qmail 19509 invoked by uid 107); 24 Nov 2015 22:47:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 17:47:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 17:47:10 -0500
Content-Disposition: inline
In-Reply-To: <1447432462-21192-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281646>

On Fri, Nov 13, 2015 at 08:34:22AM -0800, Jacob Keller wrote:

> ---
> I do not remember what version this was since it has been an age ago
> that I sent the previous code. This is mostly just a rebase onto current
> next. I believe I have covered everything previous reviewers noted.

Please keep topics branched from master where possible. And if not
possible, please indicate which topic in 'next' is required to build on.

We never merge 'next' itself, only individual topics from it. So I can't
just apply your patch on top of 'next'.

I did get it to apply on the current master with "am -3", but some tests
in t3310 seem to fail. Can you take a look?

I skimmed the discussion with Johan that followed this. Are we happy
with this as a first step, or would people rather look at re-working the
notes-ref lookups everywhere?

-Peff
