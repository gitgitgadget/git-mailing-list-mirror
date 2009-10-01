From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] send-email: fix mutt regex for grouped aliases
Date: Wed, 30 Sep 2009 20:22:59 -0400
Message-ID: <20091001002259.GB27967@sigill.intra.peff.net>
References: <20090930112833.GA4984@sigio.peff.net>
 <1254322176-4561-1-git-send-email-felipe.contreras@gmail.com>
 <20090930205501.GA30910@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Oct 01 02:23:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt9Rs-0000SO-2i
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 02:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186AbZJAAW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 20:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755147AbZJAAW6
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 20:22:58 -0400
Received: from peff.net ([208.65.91.99]:35216 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755134AbZJAAW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 20:22:57 -0400
Received: (qmail 10123 invoked by uid 107); 1 Oct 2009 00:26:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 30 Sep 2009 20:26:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Sep 2009 20:22:59 -0400
Content-Disposition: inline
In-Reply-To: <20090930205501.GA30910@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129371>

On Wed, Sep 30, 2009 at 01:55:01PM -0700, Eric Wong wrote:

> Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > For example:
> > alias -group friends foo Foo Bar <foo@bar.com>
> > 
> > Comments by Jeff King.
> > 
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> 
> Interesting, I didn't know about this feature in mutt before.
> 
> Acked(-and-tested)-by: Eric Wong <normalperson@yhbt.net>

Nor did I, which is why I was reading the docs. :) The v2 patch looks
good to me, as well.

-Peff
