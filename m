From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-add: allow path limiting with -u
Date: Sun, 13 May 2007 20:42:24 -0400
Message-ID: <20070514004224.GB6689@coredump.intra.peff.net>
References: <20070512064159.GA7471@coredump.intra.peff.net> <200705131235.25281.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	cworth@cworth.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 02:42:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnOdy-0002ZV-M3
	for gcvg-git@gmane.org; Mon, 14 May 2007 02:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757836AbXENAm1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 20:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758033AbXENAm1
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 20:42:27 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2938 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757836AbXENAm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 20:42:26 -0400
Received: (qmail 1842 invoked from network); 14 May 2007 00:42:25 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 14 May 2007 00:42:25 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 13 May 2007 20:42:24 -0400
Content-Disposition: inline
In-Reply-To: <200705131235.25281.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47207>

On Sun, May 13, 2007 at 12:35:24PM +0200, Jakub Narebski wrote:

> The fact that "add --interactive does not take any parameters" is
> separate issue (which, accidentally, was adressed in the same patch).

I don't generally use add --interactive, but I imagine that
path-limiting would also make sense there. I think it would be a bit
harder to implement (and test!), since there are many calls to commands
which would need the limits. So I will leave that unless somebody really
cares about it.

-Peff
