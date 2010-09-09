From: Jeff King <peff@peff.net>
Subject: Re: Tags only shown on log with --decorate?
Date: Thu, 9 Sep 2010 17:14:43 -0400
Message-ID: <20100909211443.GA3096@sigill.intra.peff.net>
References: <AANLkTikgxMFoiQm31FXgqBth=enVxxgxDJv8_97C30HF@mail.gmail.com>
 <AANLkTimOEQY9xJvindxuVPZotmWXZ=Ya9088ghL--Xuf@mail.gmail.com>
 <20100909194823.GB1146@sigill.intra.peff.net>
 <AANLkTi=htz2+tPSNrt+niQPczAoTGeu2g0iWgjZoFxBb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Carlos Eduardo da Fonseca <eduardongu@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 23:14:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtoS5-0007ek-NX
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 23:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755086Ab0IIVOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 17:14:32 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59609 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753727Ab0IIVOc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 17:14:32 -0400
Received: (qmail 21696 invoked by uid 111); 9 Sep 2010 21:14:30 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 09 Sep 2010 21:14:30 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Sep 2010 17:14:43 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=htz2+tPSNrt+niQPczAoTGeu2g0iWgjZoFxBb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155902>

On Thu, Sep 09, 2010 at 05:36:09PM -0300, Carlos Eduardo da Fonseca wrote:

> Well, I don't see how can it distract people, but I find important to
> developers who clone/pull a repository to immediatly see what were the
> tags added and what are they relation with commits when they "git
> log".
> I wouldn't (and I think most developers also wouldn't) remember to
> execute "git tag" or use the "--decorate" parameter every time they
> clone/pull something.

Right. That's why we have a config option, as I explained in my other
mail. If you want to argue that the config option should default to on,
submit a patch.  Either it will get accepted, or it will generate lots
of responses from people who disagree with you.

-Peff
