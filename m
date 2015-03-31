From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] enter_repo(): fix docs to match code
Date: Tue, 31 Mar 2015 13:41:41 -0400
Message-ID: <20150331174141.GG18912@peff.net>
References: <vpqk2xykaiu.fsf@anie.imag.fr>
 <1427809167-21711-1-git-send-email-pyokagan@gmail.com>
 <xmqq4mp1rrwj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 19:41:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd0Ae-0000bG-UM
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 19:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbbCaRlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 13:41:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:40435 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752115AbbCaRlo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 13:41:44 -0400
Received: (qmail 17036 invoked by uid 102); 31 Mar 2015 17:41:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 12:41:44 -0500
Received: (qmail 25700 invoked by uid 107); 31 Mar 2015 17:42:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 13:42:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2015 13:41:41 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4mp1rrwj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266540>

On Tue, Mar 31, 2015 at 10:35:56AM -0700, Junio C Hamano wrote:

> > In b3256eb (standardize and improve lookup rules for external local
> > repos), enter_repo() was modified to use a different precedence ordering
> > of suffixes for DWIM of the repository path, and to ensure that the
> > repository path is actually valid instead of just testing for existence.
> > However, the documentation was not modified to reflect these changes.
> > As such, fix the documentation to match the code.
> >
> > Documentation contributed by Jeff King.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > Signed-off-by: Paul Tan <pyokagan@gmail.com>
> > ---
> 
> It appears to me that Peff's "squash" is nullifying everything you
> did, so a more truthful attribution might be

I'm not sure that's true. The precedence changed, and the "is it valid"
check changed. The fix for the first is from Paul, but the latter is
from me. My squash (hopefully) retained his half. My half just took more
words to change.

I'm OK with the attribution either way (I do not need the credit, but am
happy to take the blame).

-Peff
