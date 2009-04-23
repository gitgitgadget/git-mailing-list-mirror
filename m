From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Makefile: ignore perl/ subdirectory under NO_PERL
Date: Thu, 23 Apr 2009 07:17:42 -0400
Message-ID: <20090423111738.GA3670@sigill.intra.peff.net>
References: <7v3ac0x6wr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Robin H. Johnson" <robbat2@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 13:19:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwwxc-0000wh-GQ
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 13:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410AbZDWLRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 07:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752915AbZDWLRp
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 07:17:45 -0400
Received: from peff.net ([208.65.91.99]:40893 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798AbZDWLRp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 07:17:45 -0400
Received: (qmail 22074 invoked by uid 107); 23 Apr 2009 11:17:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 23 Apr 2009 07:17:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Apr 2009 07:17:42 -0400
Content-Disposition: inline
In-Reply-To: <7v3ac0x6wr.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117330>

On Wed, Apr 22, 2009 at 10:42:28PM -0700, Junio C Hamano wrote:

> The install target still descends into perl subdirectory when NO_PERL is
> requested.  Fix this.

Oops, good catch.

Acked-by: Jeff King <peff@peff.net>

-Peff
