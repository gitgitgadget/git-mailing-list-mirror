From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] Move pack_refs() and friends into libgit
Date: Sun, 15 Jun 2008 13:52:00 -0400
Message-ID: <20080615175159.GA6127@sigill.intra.peff.net>
References: <200806151602.03445.johan@herland.net> <200806151605.07008.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 15 19:53:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7wPT-0003z1-Ax
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 19:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758679AbYFORwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 13:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758756AbYFORwG
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 13:52:06 -0400
Received: from peff.net ([208.65.91.99]:4913 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758735AbYFORwE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 13:52:04 -0400
Received: (qmail 3567 invoked by uid 111); 15 Jun 2008 17:52:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 15 Jun 2008 13:52:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Jun 2008 13:52:00 -0400
Content-Disposition: inline
In-Reply-To: <200806151605.07008.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85101>

On Sun, Jun 15, 2008 at 04:05:06PM +0200, Johan Herland wrote:

> ---
>  Makefile            |    2 +
>  builtin-pack-refs.c |  121 +-----------------------------------------------
>  pack-refs.c         |  117 ++++++++++++++++++++++++++++++++++++++++++++++
>  pack-refs.h         |   18 ++++++++
>  4 files changed, 138 insertions(+), 120 deletions(-)
>  create mode 100644 pack-refs.c
>  create mode 100644 pack-refs.h

This patch would have been a lot easier to read, btw, if it had been
generated with '-C' (then patch to pack-refs.c is based on
builtin-pack-refs instead of /dev/null).

-Peff
