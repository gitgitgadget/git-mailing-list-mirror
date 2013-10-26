From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 10/19] pack-bitmap: add support for bitmap indexes
Date: Fri, 25 Oct 2013 20:26:30 -0400
Message-ID: <20131026002629.GA18324@sigill.intra.peff.net>
References: <20131025055521.GD11810@sigill.intra.peff.net>
 <20131025060345.GH23098@sigill.intra.peff.net>
 <xmqqk3h1hrx0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Vicent Marti <vicent@github.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 26 02:26:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZriA-0002tE-W3
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 02:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802Ab3JZA0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 20:26:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:55821 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753734Ab3JZA0e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 20:26:34 -0400
Received: (qmail 24007 invoked by uid 102); 26 Oct 2013 00:26:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Oct 2013 19:26:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Oct 2013 20:26:30 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk3h1hrx0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236728>

On Fri, Oct 25, 2013 at 04:06:19PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/pack-bitmap.c b/pack-bitmap.c
> > new file mode 100644
> > index 0000000..73c52fd
> > --- /dev/null
> > +++ b/pack-bitmap.c
> > @@ -0,0 +1,965 @@
> > +#include <stdlib.h>
> > +
> > +#include "cache.h"
> 
> You among all people already know why this is bad, no?

Yes, I am well aware of why we do not want it. I thought I removed that,
but it appears I missed one. Sorry.

-Peff
