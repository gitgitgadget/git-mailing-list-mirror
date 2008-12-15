From: Jeff King <peff@peff.net>
Subject: Re: git log --numstat disagrees with git apply --numstat
Date: Mon, 15 Dec 2008 15:32:26 -0500
Message-ID: <20081215203225.GA19964@sigill.intra.peff.net>
References: <20081211235337.GK32487@spearce.org> <20081212015254.GA23128@sigill.intra.peff.net> <20081212020857.GB23128@sigill.intra.peff.net> <20081212022156.GC23128@sigill.intra.peff.net> <7vhc55yd58.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 21:34:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCK8b-0001D3-1D
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 21:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbYLOUce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 15:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753068AbYLOUcd
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 15:32:33 -0500
Received: from peff.net ([208.65.91.99]:4775 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791AbYLOUcd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 15:32:33 -0500
Received: (qmail 8126 invoked by uid 111); 15 Dec 2008 20:32:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 15 Dec 2008 15:32:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Dec 2008 15:32:26 -0500
Content-Disposition: inline
In-Reply-To: <7vhc55yd58.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103206>

On Mon, Dec 15, 2008 at 01:57:07AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > BTW, I got a little confused looking at the parameters to xdi_diff_outf,
> > since ecb gets passed in full of random garbage. I don't know if this
> > cleanup is worth applying:
> 
> I think this makes sense, but let's do this after 1.6.1 final.  It does
> not fix anything, and I'd rather avoid distraction.

Agreed. I will re-post both patches after 1.6.1 is released.

-Peff
