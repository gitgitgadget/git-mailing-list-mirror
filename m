From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/Makefile: retain cache t/.prove across prove runs
Date: Sat, 19 May 2012 11:27:12 -0400
Message-ID: <20120519152711.GA6979@sigill.intra.peff.net>
References: <1335972712-20621-1-git-send-email-mhagger@alum.mit.edu>
 <20120502160753.GA7193@sigill.intra.peff.net>
 <4FB7B429.80805@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat May 19 17:27:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVlYz-0003Mz-Jo
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 17:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756733Ab2ESP1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 11:27:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49517
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754237Ab2ESP1U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2012 11:27:20 -0400
Received: (qmail 16709 invoked by uid 107); 19 May 2012 15:27:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 19 May 2012 11:27:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 May 2012 11:27:12 -0400
Content-Disposition: inline
In-Reply-To: <4FB7B429.80805@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198034>

On Sat, May 19, 2012 at 04:54:33PM +0200, Michael Haggerty wrote:

> I totally believe you that some of the variations that I listed in my
> commentary don't work in the git context.  I'm not a prove expert; I
> just noticed that removing the .prove file is counterproductive and
> breaks some other prove features.  I also agree with you that it
> would be dangerous to encourage partial testing and that it is
> therefore not a priority to make the use case that you mentioned work
> in the git context.
> 
> I still think my patch makes sense.  The error that Peff pointed out
> was in my commentary, not in the patch itself or in the log message.
> Junio, is there something else keeping you from applying this patch?

Yeah, I hope my comments weren't interpreted as "don't apply this".
Keeping the .prove file around is a prerequisite for lots of clever
things, including some useful (--state=slow) and some less so
(--state=failed). But if the latter case does not work (if we even want
it to), it is because this patch is only the first building block. We
should definitely apply it.

-Peff
