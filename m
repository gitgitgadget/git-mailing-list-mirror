From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3] ref namespaces: tests
Date: Fri, 22 Jul 2011 16:32:13 -0600
Message-ID: <20110722223211.GA19620@sigill.intra.peff.net>
References: <20110714205055.GA26956@leaf>
 <7v1uxs3177.fsf@alter.siamese.dyndns.org>
 <20110715034538.GD28343@leaf>
 <20110715184045.GA2232@leaf>
 <20110721201054.GA2530@leaf>
 <7v62mux9ae.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Josh Triplett <josh@joshtriplett.org>,
	Jamey Sharp <jamey@minilop.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 00:32:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkOGm-0005eh-Ue
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 00:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868Ab1GVWc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 18:32:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43401
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153Ab1GVWcX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 18:32:23 -0400
Received: (qmail 24029 invoked by uid 107); 22 Jul 2011 22:32:50 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Jul 2011 18:32:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2011 16:32:13 -0600
Content-Disposition: inline
In-Reply-To: <7v62mux9ae.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177677>

On Thu, Jul 21, 2011 at 02:56:16PM -0700, Junio C Hamano wrote:

> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > At this point I think we've incorporated all the outstanding feedback.
> > Does this test need any further changes to allow the ref-namespaces
> > branch to graduate to next?
> 
> No more nitpicks from me on this patch at least for now.
> 
> Are people who expressed concern during the review on the previous round
> of the series happy with the second round? I recall there was a strong
> sentiment that it is regrettable that the series specifically changes
> fetch and push and is not a more general mechanism. Personally I am OK
> with the approach taken by this series, as I do not offhand think of other
> ways to serve a modified namespace. You have to view the unaltered reality
> when interacting with your own refs to enumerate the objects you have,
> while giving the altered view to your clients that is limited to the
> "virtual" space.

I was one of the people who wanted to have namespaces or virtual repos
at a more fundamental level. However, I tried to do a relatively simple
patch when the discussion started, and ended up getting mired in corner
cases. And it sounds like Josh and Jamey made a good faith effort in
that direction, but still ended up where they are now. So I'm willing to
accept that it is not as simple as we hoped, and the more practical
approach from their series is acceptable.

As for the code itself, I admit I haven't been paying all that close
attention. I can try to give a more careful review if we want another
set of eyes.

-Peff
