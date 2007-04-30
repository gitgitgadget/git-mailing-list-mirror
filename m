From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] Make xstrndup common
Date: Mon, 30 Apr 2007 16:50:50 -0400
Message-ID: <20070430205050.GC4385@coredump.intra.peff.net>
References: <46339819.8030007@freedesktop.org> <Pine.LNX.4.64.0704291416370.28708@iabervon.org> <4635003F.7080408@freedesktop.org> <Pine.LNX.4.64.0704301508550.29859@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Triplett <josh@freedesktop.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 30 22:51:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hicpl-00069L-GW
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 22:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946803AbXD3Uuy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 16:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946810AbXD3Uuy
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 16:50:54 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1703 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946803AbXD3Uux (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 16:50:53 -0400
Received: (qmail 21390 invoked from network); 30 Apr 2007 20:50:54 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 30 Apr 2007 20:50:54 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Apr 2007 16:50:50 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704301508550.29859@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45878>

On Mon, Apr 30, 2007 at 03:12:50PM +0200, Johannes Schindelin wrote:

> Unless I am missing something, I think this should work:
> 
> static inline char *xstrndup(const char *str, int len)
> {
> 	char *result = strndup(str, len);
> 	if (result == NULL)
> 		die ("xstrndup(): out of memory");
> 	return result;
> }
> 
> Hmm?

I can't speak for the original authors, but I imagine part of the
impetus was that strndup is a GNU-ism.

-Peff
