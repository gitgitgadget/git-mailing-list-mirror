From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4 v2] push.default upcomming change
Date: Fri, 20 Apr 2012 13:35:52 -0700
Message-ID: <20120420203552.GC13103@sigill.intra.peff.net>
References: <vpqfwbye9re.fsf@bauges.imag.fr>
 <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Apr 20 22:36:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLKYj-0006LQ-24
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 22:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371Ab2DTUf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 16:35:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39354
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087Ab2DTUf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 16:35:56 -0400
Received: (qmail 14454 invoked by uid 107); 20 Apr 2012 20:36:06 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Apr 2012 16:36:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Apr 2012 13:35:52 -0700
Content-Disposition: inline
In-Reply-To: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196021>

On Fri, Apr 20, 2012 at 04:59:00PM +0200, Matthieu Moy wrote:

> OK, so this v2 is not supposed to be a draft anymore. It has
> documentation (while I was there, I added PATCH 1/4 thas tries to
> document better the existing modes), and I removed the hunks that came
> here after a broken merge resolution.
> 
> This is based on next, it at least requires 135dade that creates
> t5528.

You are better off to just build it on 135dade in that case, as that is
what Junio will apply it on (never directly on top of next). It
generally isn't a problem, but there's no point reason not to do so.

> Clemens Buchacher (1):
>   t5570: use explicit push refspec
> 
> Matthieu Moy (3):
>   Documentation: explain push.default option a bit more
>   push: introduce new push.default mode "simple"
>   push: start warning upcoming default change for push.default

I commented separately on patches 1 and 2, but modulo those minor
comments, the series looks OK to me. The "Git 2.0" mention in patch 4/4
might need to be tweaked. :)

-Peff
