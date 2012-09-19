From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/6] make test output coloring more intuitive
Date: Wed, 19 Sep 2012 14:05:00 -0400
Message-ID: <20120919180500.GD11699@sigill.intra.peff.net>
References: <20120918213617.GB2567@atlantic.linksys.moosehall>
 <1348074915-19985-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 20:05:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEOe9-0003zr-43
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 20:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932865Ab2ISSFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 14:05:04 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49790 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932791Ab2ISSFD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 14:05:03 -0400
Received: (qmail 2805 invoked by uid 107); 19 Sep 2012 18:05:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Sep 2012 14:05:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2012 14:05:00 -0400
Content-Disposition: inline
In-Reply-To: <1348074915-19985-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205966>

On Wed, Sep 19, 2012 at 06:15:09PM +0100, Adam Spiers wrote:

> This series of commits attempts to make test output coloring
> more intuitive, so that:
> 
>   - red is _only_ used for things which have gone unexpectedly wrong:
>     test failures, unexpected test passes, and failures with the
>     framework,
> 
>   - yellow is _only_ used for known breakages and skipped tests, and
> 
>   - green is _only_ used for things which have gone to plan and
>     require no further work to be done.

Thanks, I like this much better than the original (and it's much easier
to review broken apart like this).

I raised a few minor questions in the refactoring patch, but other than
that (and assuming your answers are what I expect, I do not care enough
about them to block the series), it looks very good.

The new "a passing expect_failure is a breakage" is a good thing. When
it's unexpected, it will help call attention to it and let us figure out
early what changed. And when it is expected (because you are fixing the
breakage), it is an easy way to remind you to update the tests. :)

Thanks for working on it.

-Peff
