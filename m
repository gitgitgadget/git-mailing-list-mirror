From: Jeff King <peff@peff.net>
Subject: Re: Why a _full_ diff? (was: [PATCH] Char: serial167, cleanup (fwd))
Date: Mon, 12 Feb 2007 03:51:03 -0500
Message-ID: <20070212085102.GA12605@coredump.intra.peff.net>
References: <Pine.LNX.4.62.0702120934120.10436@chinchilla.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 09:51:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGWuA-000897-Mu
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 09:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933124AbXBLIvH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 03:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933125AbXBLIvG
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 03:51:06 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2780 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933124AbXBLIvF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 03:51:05 -0500
Received: (qmail 2187 invoked from network); 12 Feb 2007 03:51:09 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 12 Feb 2007 03:51:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Feb 2007 03:51:03 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0702120934120.10436@chinchilla.sonytel.be>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39385>

On Mon, Feb 12, 2007 at 09:39:46AM +0100, Geert Uytterhoeven wrote:

> At first I thought the new version had CR/LF line endings or so, but that
> isn't the case.

Close. It looks like tabs/spaces changes. Try

  git show 44bafd | cat -A | less

-Peff
