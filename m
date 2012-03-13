From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Tue, 13 Mar 2012 17:35:23 -0400
Message-ID: <20120313213522.GA27752@sigill.intra.peff.net>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
 <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
 <1331288715.21444.38.camel@beez.lab.cmartin.tk>
 <4F5A4C45.7070406@xiplink.com>
 <4F5AF1A8.4050604@alum.mit.edu>
 <4F5E12A5.6030701@xiplink.com>
 <vpqzkblixmb.fsf@bauges.imag.fr>
 <20120312183725.GA2187@sigill.intra.peff.net>
 <vpqy5r44zg7.fsf@bauges.imag.fr>
 <7vehswljxi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 22:35:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7ZNT-0007vN-IJ
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 22:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758419Ab2CMVf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 17:35:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48720
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757809Ab2CMVf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 17:35:26 -0400
Received: (qmail 2408 invoked by uid 107); 13 Mar 2012 21:35:37 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Mar 2012 17:35:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Mar 2012 17:35:23 -0400
Content-Disposition: inline
In-Reply-To: <7vehswljxi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193071>

On Tue, Mar 13, 2012 at 06:17:13AM -0700, Junio C Hamano wrote:

> Pushing 'current' from a branch 'topic' forked from either 'master'
> or 'origin/master' will create a new branch 'topic' at the central
> repository. But that is straightforward and understandable. The user
> will see what happened in the feedback from the command, and there
> is no need for the user to be experienced enough to know the mapping
> of @{upstream} to understand why it happened.  "I am on 'topic' and
> I pushed, I created 'topic' there".  Very simple explanation exists.
> [...]
> That makes me suspect that 'current' might be a more appropriate
> default between the two. From that simple default, those in the
> "shared central repository" world can graduate to 'upstream' once
> they know what an 'upstream' is and how to take advantage of
> per-branch configuration.  Similarly, those in the "publish to be
> pulled" world would graduate to 'matching'.

Thanks for this explanation. When writing my last email, I had a gut
feeling about how "current" was a simpler choice, but I didn't quite
find the words to explain it. This paragraph (and the rest of the email)
covers what I was trying to say.

-Peff
