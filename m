From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/22] Lockfile refactoring and pre-activation
Date: Tue, 1 Apr 2014 16:44:47 -0400
Message-ID: <20140401204447.GJ21715@sigill.intra.peff.net>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 01 22:44:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV5YH-0000yf-Te
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 22:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbaDAUov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 16:44:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:52101 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751728AbaDAUot (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 16:44:49 -0400
Received: (qmail 23934 invoked by uid 102); 1 Apr 2014 20:44:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Apr 2014 15:44:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2014 16:44:47 -0400
Content-Disposition: inline
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245658>

On Tue, Apr 01, 2014 at 05:58:08PM +0200, Michael Haggerty wrote:

> I've had this patch series kicking around for a long time, along with
> some followup patches to fix a race in reference deletion.  I haven't
> had the time to get everything done and tested, but let me at least
> push this first series out there.  I especially want to submit it in
> case we accept a GSoC student for the project "Refactor tempfile
> handling", because (1) I don't want me and the student to be stepping
> on each others' toes, and (2) there are some cleanups and
> documentation improvements here that will hopefully be useful to the
> student.

Thanks, this sort of preparation for GSoC students is very much welcome.

> The first patch actually demonstrates the race condition that I hope
> to fix someday.  The last patch introduces the lockfile feature that I
> think is needed to fix it: the ability to activate a packed-refs file
> while still holding the lock to prevent another process from
> overwriting it before the accompanying loose reference updates are all
> finished.  But the fix itself is not included here, so you might want
> to keep the last patch on hold until there is a concrete user of the
> feature.

I should have read this more carefully when I responded to the final
patch. I surmised your intent based on our previous work on packed-refs,
but here you spell out my guesses explicitly. :)

I think all of the patches look good. I'd prefer to hold back the final
one (and probably 19/22, which has no purpose except to prepare for
22/22) until seeing its application in practice.

Thanks for a very pleasant read.

-Peff
