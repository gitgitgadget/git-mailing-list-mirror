From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6] http: Avoid limit of retrying request only twice
Date: Fri, 4 May 2012 05:28:15 -0400
Message-ID: <20120504092814.GA24398@sigill.intra.peff.net>
References: <4FA2B4FC.3030309@seap.minhap.es>
 <20120504072427.GE21895@sigill.intra.peff.net>
 <4FA3AD72.1010407@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri May 04 11:28:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQEoM-0000AS-KM
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 11:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287Ab2EDJ2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 05:28:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57712
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752427Ab2EDJ2W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 05:28:22 -0400
Received: (qmail 17306 invoked by uid 107); 4 May 2012 09:28:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 May 2012 05:28:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 May 2012 05:28:15 -0400
Content-Disposition: inline
In-Reply-To: <4FA3AD72.1010407@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197010>

On Fri, May 04, 2012 at 12:20:34PM +0200, Nelson Benitez Leon wrote:

> On 05/04/2012 09:24 AM, Jeff King wrote:
> > On Thu, May 03, 2012 at 06:40:28PM +0200, Nelson Benitez Leon wrote:
> > 
> >> [snip]
> >>
> >> Now we retry as long as we keep receiving HTTP_REAUTH, so the previous
> >> sequence correctly completes.
> >>
> >> Patch by Jeff King <peff@peff.net>
> > 
> > We usually spell that as:
> > 
> >   From: Jeff King <peff@peff.net>
> > 
> > at the beginning of the email body (which lets am set the author
> > appropriately).
> 
> Are you saying the first line of the email body? isn't that for the
> commit message first-line? I suppose you're not refering to the 'from
> field' of the email as I would need alter identities in my email client
> and found that cumbersome. Sorry for me not getting it and asking for
> clarification.

Yes, that's what I am saying. When Junio applies the patch using "git
am", git will recognize these extra "pseudo-headers" at the top of the
body, remove them from the commit message, and override the email
headers with them.

It does this for exactly this case; you can leave your email headers
intact, but still provide attribution to someone else.

-Peff
