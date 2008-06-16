From: Jeff King <peff@peff.net>
Subject: Re: [Crash] git-push $remote $non_ref:$anything
Date: Mon, 16 Jun 2008 12:17:55 -0400
Message-ID: <20080616161754.GB7219@sigill.intra.peff.net>
References: <20080615193823.GA11218@glandium.org> <20080615195541.GA7683@sigill.intra.peff.net> <alpine.LNX.1.00.0806151626260.19665@iabervon.org> <20080616161502.GA7219@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jun 16 18:18:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8HPv-000231-8o
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 18:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126AbYFPQR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 12:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754125AbYFPQR5
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 12:17:57 -0400
Received: from peff.net ([208.65.91.99]:4600 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754115AbYFPQR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 12:17:57 -0400
Received: (qmail 16803 invoked by uid 111); 16 Jun 2008 16:17:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 16 Jun 2008 12:17:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jun 2008 12:17:55 -0400
Content-Disposition: inline
In-Reply-To: <20080616161502.GA7219@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85203>

On Mon, Jun 16, 2008 at 12:15:02PM -0400, Jeff King wrote:

>  	if (!matched_src)
> -		errs = 1;
> +		return -1;

This could maybe be cleaned up even more by just returning -1 at each
point where matched_src becomes NULL (in the switch statement above).

-Peff
