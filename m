From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch-pack.c: show correct command name that fails
Date: Wed, 18 Sep 2013 14:20:53 -0400
Message-ID: <20130918182052.GB18821@sigill.intra.peff.net>
References: <1379511678-11611-1-git-send-email-pclouds@gmail.com>
 <xmqqvc1yuhao.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 20:21:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMMN9-0003KD-74
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 20:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362Ab3IRSVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 14:21:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:56249 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753155Ab3IRSVB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 14:21:01 -0400
Received: (qmail 20046 invoked by uid 102); 18 Sep 2013 18:21:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Sep 2013 13:21:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Sep 2013 14:20:53 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvc1yuhao.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234979>

On Wed, Sep 18, 2013 at 11:16:15AM -0700, Junio C Hamano wrote:

> I wondered if this is something we can have a test for easily.
> Unlike the "--upload-pack" option, there is no way for the receiving
> end to choose which index-pack (or unpack-objects) to run, but we
> may force a failure by temporarily futzing with PATH to make a dummy
> git-index-pack that always fails to be found or something silly like
> that.

You can feed a bogus pack, which will cause either to fail reliably. I'm
not sure if that counts as "easy" though. :) Munging PATH is probably
simpler.

> >  fetch-pack.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)

Patch looks good to me, too.

-Peff
