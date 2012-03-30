From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add diff.minimal configuration setting
Date: Fri, 30 Mar 2012 04:09:04 -0400
Message-ID: <20120330080904.GA2661@sigill.intra.peff.net>
References: <20120329202648.GA27318@l0b0x>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thomas Rast <trast@student.ethz.ch>
To: Victor Engmark <victor.engmark@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 10:09:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDWuB-0007vx-KX
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 10:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759229Ab2C3IJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 04:09:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40997
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759022Ab2C3IJH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 04:09:07 -0400
Received: (qmail 12796 invoked by uid 107); 30 Mar 2012 08:09:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Mar 2012 04:09:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2012 04:09:04 -0400
Content-Disposition: inline
In-Reply-To: <20120329202648.GA27318@l0b0x>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194338>

On Thu, Mar 29, 2012 at 10:26:48PM +0200, Victor Engmark wrote:

> Complements the --minimal and --no-minimal options.

There was a recent discussion here:

  http://article.gmane.org/gmane.comp.version-control.git/192719

where two similar options were considered:

  1. diff.algorithm should be added, and consider "minimal" to be a
     variant algorithm

  2. we should have a generic "diff options" config variable, in which
     one could put "--minimal", "--patience", or whatever.

I don't think anything was decided, but either option would remove the
need for a separate diff.minimal variable. Maybe it would be worth
combining efforts.

-Peff

PS I like the generality of (2), but the idea of diff defaults came up a
   few years ago, and I remember it devolving into quite a complex
   patch. But that may also just have been the patch submitter, who
   seemed very interested in complexifying things. I can dig up the
   discussion if you want.
