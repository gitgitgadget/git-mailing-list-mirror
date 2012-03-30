From: Jeff King <peff@peff.net>
Subject: Re: push.default: current vs upstream
Date: Fri, 30 Mar 2012 18:20:44 -0400
Message-ID: <20120330222044.GA22371@sigill.intra.peff.net>
References: <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vty15ltuo.fsf@alter.siamese.dyndns.org>
 <20120330210112.GA20734@sigill.intra.peff.net>
 <7vzkaxkccg.fsf@alter.siamese.dyndns.org>
 <20120330215344.GD20734@sigill.intra.peff.net>
 <7vvcllka61.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 00:21:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDkBs-0005wB-JX
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 00:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894Ab2C3WUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 18:20:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41463
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964868Ab2C3WUq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 18:20:46 -0400
Received: (qmail 21280 invoked by uid 107); 30 Mar 2012 22:20:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Mar 2012 18:20:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2012 18:20:44 -0400
Content-Disposition: inline
In-Reply-To: <7vvcllka61.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194417>

On Fri, Mar 30, 2012 at 03:15:34PM -0700, Junio C Hamano wrote:

> In the meantime, we can do this.

I'm OK with this. We could perhaps even invite people to take part in
the discussion. I'm not sure if that will generate anything more than a
set of "me too" votes, though.

> -   locally have.  In future versions of Git, this will change to use the
> -   "upstream" rule to update the branch at the remote you would "pull"
> -   from into your current branch with your local current branch.  The
> -   release after 1.7.10 will start issuing a warning about this change,
> -   to encourage you to tell the command what to push out, e.g. by setting
> -   push.default configuration.
> +   locally have.  In future versions of Git, this will change to and push
> +   out only your current branch according to either "upstream" or "current"
> +   rule (we haven't yet decided which).

s/to and/to/

-Peff
