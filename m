From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/14] less annoying http authentication
Date: Mon, 18 Jul 2011 04:00:55 -0400
Message-ID: <20110718080054.GA12692@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 10:01:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiilB-0007W9-Uf
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 10:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315Ab1GRIA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 04:00:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56251
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745Ab1GRIA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 04:00:57 -0400
Received: (qmail 20185 invoked by uid 107); 18 Jul 2011 08:01:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Jul 2011 04:01:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2011 04:00:55 -0400
Content-Disposition: inline
In-Reply-To: <20110718074642.GA11678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177359>

On Mon, Jul 18, 2011 at 03:46:42AM -0400, Jeff King wrote:

> This is still in the RFC stage. I think the code is fine, and I've been
> using it for a few weeks. I tried to keep the design of the credential
> helper interface simple, but flexible enough to meet the needs of the
> various keychain systems. Aside from the usual, what I'd most like
> feedback on is whether the interface is sufficient to actually integrate
> with those systems. And I suspect we won't really know until people try
> to make helpers for their pet systems.

BTW, I'll be traveling and have spotty time and email availability for
the next 3-5 days. So I hope to get lots of comments, but please don't
be discouraged if I don't respond immediately. :)

-Peff
