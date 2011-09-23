From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] A handful of "branch description" patches
Date: Fri, 23 Sep 2011 16:53:19 -0400
Message-ID: <20110923205319.GA28802@sigill.intra.peff.net>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org>
 <1316729362-7714-1-git-send-email-gitster@pobox.com>
 <4E7C49CF.60508@drmicha.warpmail.net>
 <20110923201824.GA27999@sigill.intra.peff.net>
 <7vk48zt211.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 22:53:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7CkR-0007XG-GS
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 22:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab1IWUxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 16:53:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41828
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191Ab1IWUxW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 16:53:22 -0400
Received: (qmail 20635 invoked by uid 107); 23 Sep 2011 20:58:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Sep 2011 16:58:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Sep 2011 16:53:19 -0400
Content-Disposition: inline
In-Reply-To: <7vk48zt211.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182001>

On Fri, Sep 23, 2011 at 01:52:10PM -0700, Junio C Hamano wrote:

> A more fundamental issue I have with this is that names of the refs are
> local by nature (what I call "master" branch is not "master" to you, but
> rather it is "origin/master" or "jch/master") while notes is meant to be
> the mechanism to share. The following shares the same issue, but at least
> it does not abuse "notes", so in that sense it may be cleaner at the
> design level...

Good point. For that reason, your config-based solution perhaps makes
more sense.

-Peff
