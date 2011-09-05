From: Jeff King <peff@peff.net>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Mon, 5 Sep 2011 16:57:35 -0400
Message-ID: <20110905205735.GA5578@sigill.intra.peff.net>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org>
 <20110902000039.GB9339@sigill.intra.peff.net>
 <4E6088F9.5070102@drmicha.warpmail.net>
 <20110902152947.GB19213@sigill.intra.peff.net>
 <7v4o0uncq0.fsf@alter.siamese.dyndns.org>
 <20110902162524.GC19690@sigill.intra.peff.net>
 <CAJo=hJtuUe1ajjW9dNU4JzjE+P94a42W7ZvC+iQBQTeGXVvS8Q@mail.gmail.com>
 <20110905204729.GB4221@sigill.intra.peff.net>
 <CAJo=hJtvU+ujYBMvrgVJpBdaTUq+NOsQwVFkL-A4pHv-CRPdDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 05 22:57:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0gEh-0007Gj-5I
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 22:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920Ab1IEU5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 16:57:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53810
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753764Ab1IEU5h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 16:57:37 -0400
Received: (qmail 21013 invoked by uid 107); 5 Sep 2011 20:58:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 Sep 2011 16:58:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Sep 2011 16:57:35 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJtvU+ujYBMvrgVJpBdaTUq+NOsQwVFkL-A4pHv-CRPdDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180762>

On Mon, Sep 05, 2011 at 01:53:42PM -0700, Shawn O. Pearce wrote:

> > Sure. I'm totally open to the idea of making the non-fast-forward
> > warning more obvious. Suggestions for wording (though I am tempted by
> > "HEY STUPID" above ;) )?
> 
> I'm not suggesting all non-fast-forward should issue a bigger warning.
> pu updates daily with a non-fast-forward. That isn't useful.
> 
> But if the local reflog hints that this reference almost never does a
> non-fast-forward, and then it does, that should be a big warning.

Right. What I mean is, what should the bigger warning look like?

Also, you suggested caching to avoid looking through the whole reflog
each time. I think you could probably just sample the last 10 or so
reflog entries to get an idea.

-Peff
