From: Jeff King <peff@peff.net>
Subject: Re: git://github.com/some/thing.git/?
Date: Tue, 27 Mar 2012 14:38:33 -0400
Message-ID: <20120327183833.GB8460@sigill.intra.peff.net>
References: <7vpqbyjbbx.fsf@alter.siamese.dyndns.org>
 <20120327163339.GA5941@sigill.intra.peff.net>
 <7vd37xj3zh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 20:38:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCbIG-0006b3-M5
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 20:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755988Ab2C0Sij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 14:38:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34422
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755807Ab2C0Sig (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 14:38:36 -0400
Received: (qmail 6024 invoked by uid 107); 27 Mar 2012 18:38:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Mar 2012 14:38:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2012 14:38:33 -0400
Content-Disposition: inline
In-Reply-To: <7vd37xj3zh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194072>

On Tue, Mar 27, 2012 at 11:25:22AM -0700, Junio C Hamano wrote:

> > Even with that, though, I think it would be good for the server to be
> > liberal in what it accepts.
> 
> It is not about being liberal; it is about accepting what we have always
> accepted.

For some definition of "we"; AFAICT, github has never allowed this, and
this is the first complaint (we run a stock git-daemon, but our forwarding
proxies are picky about getting real "user/project" style paths, since
they need them to route to the correct backends).

However, it turned out to be a one-line patch. I've pushed it out for
review by other GitHubbers. The last thing the world needs is me
deploying anything to a live website.

-Peff
