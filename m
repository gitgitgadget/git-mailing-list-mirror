From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: "on for all" configuration of
 notes.rewriteRef
Date: Wed, 7 Sep 2011 17:23:10 -0400
Message-ID: <20110907212310.GH13364@sigill.intra.peff.net>
References: <f415402994735a60664e1f9f85be490a68b25ed3.1315167848.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "John S. Urban\"" <urbanjost@comcast.net>,
	Tor Arntsen <tor@spacetec.no>,
	knittl <knittl89@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Sep 07 23:23:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1PaY-00075E-1J
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 23:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757032Ab1IGVXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 17:23:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60442
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754554Ab1IGVXM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 17:23:12 -0400
Received: (qmail 6170 invoked by uid 107); 7 Sep 2011 21:24:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Sep 2011 17:24:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2011 17:23:10 -0400
Content-Disposition: inline
In-Reply-To: <f415402994735a60664e1f9f85be490a68b25ed3.1315167848.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180914>

On Sun, Sep 04, 2011 at 10:27:04PM +0200, Thomas Rast wrote:

> Users had problems finding a working setting for notes.rewriteRef.
> Document how to enable rewriting for all notes.

Hmm. Is this a safe thing to recommend?

I think the idea of storing something like generation numbers in
git-notes is dead at this point, but it would be quite disastrous to
have generation numbers copied to rebased commits. Ditto for something
like a patch-id cache. Should these sorts of immutable cache notes, if
and when they do come about, go into a separate hierarchy?

-Peff
