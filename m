From: Jeff King <peff@peff.net>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Fri, 2 Sep 2011 11:29:47 -0400
Message-ID: <20110902152947.GB19213@sigill.intra.peff.net>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org>
 <20110902000039.GB9339@sigill.intra.peff.net>
 <4E6088F9.5070102@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 02 17:29:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzVgo-0006gv-6I
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 17:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855Ab1IBP3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 11:29:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50754
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752556Ab1IBP3t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 11:29:49 -0400
Received: (qmail 31223 invoked by uid 107); 2 Sep 2011 15:30:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Sep 2011 11:30:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Sep 2011 11:29:47 -0400
Content-Disposition: inline
In-Reply-To: <4E6088F9.5070102@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180614>

On Fri, Sep 02, 2011 at 09:42:49AM +0200, Michael J Gruber wrote:

> >     It would be considerably nicer if the server had some way of saying
> >     "I expect this branch to be rewound". Which has been discussed off
> >     and on over the years, as I recall.
> 
> Hmm, that sounds like the often requested feature to have part of the
> config distributed by "clone" as well, possibly after displaying it and
> getting user confirmation.

Yeah, if distributed config existed, that would be a good place to put
this information.

And I personally thing a limited form[1] of distributed config is a
sensible idea, but I'm not sure everybody else agrees.

-Peff

[1] My idea of "limited" would be an allow-known-good list of harmless
config keys which we would respect when they came from the remote, with
the option for the user to whitelist or blacklist more keys if they
wanted.
