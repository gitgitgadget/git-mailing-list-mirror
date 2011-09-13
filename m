From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t3200: clean up checks for file existence
Date: Tue, 13 Sep 2011 13:16:12 -0400
Message-ID: <20110913171612.GB32251@sigill.intra.peff.net>
References: <20110909193033.GA31184@sigill.intra.peff.net>
 <49578782dd114220aa2562b5bd29755fc2bdd0fa.1315597137.git.git@drmicha.warpmail.net>
 <20110909194357.GA31446@sigill.intra.peff.net>
 <4E6B6647.7090802@drmicha.warpmail.net>
 <20110913035724.GA4828@sigill.intra.peff.net>
 <4E6F48C4.3030407@drmicha.warpmail.net>
 <20110913161358.GB28634@sigill.intra.peff.net>
 <7v62kwxt4b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 19:16:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Wap-000853-Cf
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 19:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693Ab1IMRQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 13:16:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45057
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753997Ab1IMRQO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 13:16:14 -0400
Received: (qmail 30792 invoked by uid 107); 13 Sep 2011 17:17:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Sep 2011 13:17:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2011 13:16:12 -0400
Content-Disposition: inline
In-Reply-To: <7v62kwxt4b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181295>

On Tue, Sep 13, 2011 at 10:13:56AM -0700, Junio C Hamano wrote:

> In the longer term, we might want to update these tests further so that
> they do not fail when implementation is updated not to write loose refs,
> e.g.

Yeah, I noticed that, too, but figured to leave it for when such a
change came about (which is probably going to need to fix tests
everywhere, not just here). I'm happy to fix this area now, though, if
you want.

-Peff
