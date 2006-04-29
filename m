From: Jeff King <peff@peff.net>
Subject: Re: Two gitweb feature requests
Date: Sat, 29 Apr 2006 01:02:31 -0400
Message-ID: <20060429050231.GC25638@coredump.intra.peff.net>
References: <1146144425.11909.450.camel@pmac.infradead.org> <e2tjqm$83n$1@sea.gmane.org> <Pine.LNX.4.64.0604281116020.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Apr 29 07:02:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZhbJ-0005zv-EP
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 07:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWD2FCe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 01:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWD2FCe
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 01:02:34 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:23027 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1750752AbWD2FCd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Apr 2006 01:02:33 -0400
Received: (qmail 50525 invoked from network); 29 Apr 2006 05:02:31 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 29 Apr 2006 05:02:31 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Apr 2006 01:02:31 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604281116020.3701@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19293>

On Fri, Apr 28, 2006 at 11:23:11AM -0700, Linus Torvalds wrote:

> The downside is that you'd have two different web-pages for the same tree 
> depending on which commit it came from. Which is not a downside from a 
> user perspective, but it's a downside from a caching/server perspective, 
> since it means less reuse of pages (maybe gitweb already does that, 
> though).

The gitweb request for a tree already contains not only the tree hash,
but also the commit hash and the filename path. It's possible (but more
expensive than typical tree requests) to find '..' by munging the path
and traversing the tree from the root.

-Peff
