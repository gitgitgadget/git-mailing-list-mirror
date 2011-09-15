From: Jeff King <peff@peff.net>
Subject: Re: Problems with format-patch UTF-8 and a missing second empty line
Date: Thu, 15 Sep 2011 16:33:36 -0400
Message-ID: <20110915203336.GA17566@sigill.intra.peff.net>
References: <CAHz1FYgPuMHLC+f2mFqD73=NGXQSStRPDOsiCy-HtaWKbHu7NQ@mail.gmail.com>
 <20110915151734.GA18305@sigill.intra.peff.net>
 <20110915224456.14410ed8@zappedws>
 <20110915185033.GA17016@sigill.intra.peff.net>
 <20110916000515.1dfc5665@zappedws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ingo Ruhnke <grumbel@gmail.com>, git@vger.kernel.org
To: Alexey Shumkin <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Thu Sep 15 22:33:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4Icx-00065z-Fj
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 22:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934882Ab1IOUdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 16:33:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42862
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934787Ab1IOUdi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 16:33:38 -0400
Received: (qmail 25461 invoked by uid 107); 15 Sep 2011 20:34:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Sep 2011 16:34:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Sep 2011 16:33:36 -0400
Content-Disposition: inline
In-Reply-To: <20110916000515.1dfc5665@zappedws>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181492>

On Fri, Sep 16, 2011 at 12:05:15AM +0400, Alexey Shumkin wrote:

> But as you said
> >>This is by design. Git commit messages are intended to have a
> >>single-line subject, followed by a blank line, followed by more
> >>elaboration
> 
> and solved with "-k" for both "format-patch" and "am" commands

OK, that makes sense to me, then. I didn't read Ingo's first message
carefully enough, but your response made me scratch my head and read it
again. Thanks for the sanity check.

-Peff
