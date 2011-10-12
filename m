From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: update [section.subsection] to reflect
 what git does
Date: Wed, 12 Oct 2011 14:27:42 -0400
Message-ID: <20111012182742.GA14543@sigill.intra.peff.net>
References: <1318434726-5556-1-git-send-email-cmn@elego.de>
 <20111012162939.GA3055@sigill.intra.peff.net>
 <20111012174643.GA14336@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Oct 12 20:27:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE3Wv-000103-Mu
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 20:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241Ab1JLS1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 14:27:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58661
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492Ab1JLS1o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 14:27:44 -0400
Received: (qmail 13640 invoked by uid 107); 12 Oct 2011 18:27:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Oct 2011 14:27:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2011 14:27:42 -0400
Content-Disposition: inline
In-Reply-To: <20111012174643.GA14336@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183385>

On Wed, Oct 12, 2011 at 01:46:43PM -0400, Jeff King wrote:

> On Wed, Oct 12, 2011 at 12:29:39PM -0400, Jeff King wrote:
> 
> > The explanation matches what we do now, but it did end up a bit longer
> > than I had hoped. We could make it a lot shorter by:
> > 
> >   1. Canonicalizing the section and key names that the caller gives to
> >      git-config.
> 
> Hmm. Scratch that. We seem to do this already in my tests. I'll look
> further and try to make a better documentation patch.

OK, I was all set to do a patch to git-config for this, but it seems the
code is already there.  It's only the subsections which are the sticking
point, and those can't be canonicalized, because in most cases we need
to match them exactly.

In the process, I did some cleanup and added some new tests to t1300,
which I think are probably worth applying anyway.

  [1/2]: t1300: put git invocations inside test function
  [2/2]: t1300: test mixed-case variable retrieval

-Peff
