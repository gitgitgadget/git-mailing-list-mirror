From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/6] log/pretty-options: Document --[no-]notes and
 deprecate old notes options
Date: Tue, 29 Mar 2011 23:32:05 -0400
Message-ID: <20110330033205.GB18157@sigill.intra.peff.net>
References: <e83f8b622fba5add563fc331ae3922b79a0af008.1301392999.git.git@drmicha.warpmail.net>
 <201103300018.55371.johan@herland.net>
 <20110330002206.GB1161@sigill.intra.peff.net>
 <201103300257.19921.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 05:32:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4m8j-00087d-Bm
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 05:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab1C3DcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 23:32:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45166
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683Ab1C3DcH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 23:32:07 -0400
Received: (qmail 5290 invoked by uid 107); 30 Mar 2011 03:32:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 23:32:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 23:32:05 -0400
Content-Disposition: inline
In-Reply-To: <201103300257.19921.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170351>

On Wed, Mar 30, 2011 at 02:57:19AM +0200, Johan Herland wrote:

> On Wednesday 30 March 2011, Jeff King wrote:
> > On Wed, Mar 30, 2011 at 12:18:55AM +0200, Johan Herland wrote:
> > > And here's some documentation to go on top.
> > [...]
> > This example is wrong. "--notes=foo" will show _only_ foo. A few
> > examples:
> > 
> >   --notes=foo ;# only foo
> >   --notes --notes=foo ;# foo and default
> >   --notes=foo --notes=bar --notes --no-notes --notes=foo ;# only foo
> > 
> > Make sense?
> 
> Yeah, I really screwed that up. Hope this version is better. :)

Yes, it looks good to me. Thanks.

Acked-by: Jeff King <peff@peff.net>

-Peff
