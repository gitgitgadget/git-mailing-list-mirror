From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] Teach "git clone" to pack refs
Date: Sun, 15 Jun 2008 13:56:14 -0400
Message-ID: <20080615175613.GC6127@sigill.intra.peff.net>
References: <200806151602.03445.johan@herland.net> <200806151606.16380.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 15 19:57:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7wTX-00058P-1f
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 19:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758756AbYFOR4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 13:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758753AbYFOR4Q
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 13:56:16 -0400
Received: from peff.net ([208.65.91.99]:4551 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758735AbYFOR4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 13:56:16 -0400
Received: (qmail 3884 invoked by uid 111); 15 Jun 2008 17:56:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 15 Jun 2008 13:56:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Jun 2008 13:56:14 -0400
Content-Disposition: inline
In-Reply-To: <200806151606.16380.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85103>

On Sun, Jun 15, 2008 at 04:06:16PM +0200, Johan Herland wrote:

> +	pack_refs(PACK_REFS_ALL);

I haven't looked carefully at the pack_refs code, but my understanding
was that this would pack _all_ refs, including branches. Don't we
generally try to leave branches unpacked, since they change a lot? IOW,
shouldn't this just be "pack_refs(0)"?

-Peff
