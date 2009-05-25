From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] am: do not do any reset on --abort
Date: Mon, 25 May 2009 12:02:07 -0400
Message-ID: <20090525160207.GB5449@coredump.intra.peff.net>
References: <20090525104308.GA26775@coredump.intra.peff.net> <alpine.DEB.1.00.0905251348050.4288@intel-tinevez-2-302> <20090525120019.GA1740@coredump.intra.peff.net> <4A1A8C6C.5020009@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 25 18:02:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8cd0-0005XO-8u
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 18:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbZEYQCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 12:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbZEYQCJ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 12:02:09 -0400
Received: from peff.net ([208.65.91.99]:43662 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731AbZEYQCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 12:02:09 -0400
Received: (qmail 5102 invoked by uid 107); 25 May 2009 16:02:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 25 May 2009 12:02:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 May 2009 12:02:07 -0400
Content-Disposition: inline
In-Reply-To: <4A1A8C6C.5020009@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119941>

On Mon, May 25, 2009 at 02:17:48PM +0200, Johannes Sixt wrote:

> I wonder why we have this problem (and do something about it) with git-am,
> but not with git-rebase. Is it perhaps that the usual case were people
> were bitten by the old behavior is:

I don't know. I had assumed a safety valve we put in git-am might need
to be matched in rebase. But I don't recall whether I have screwed
myself in the same way with rebase. Perhaps because rebase happens on a
detached HEAD, I tend to notice sooner that something is not right.

-Peff
