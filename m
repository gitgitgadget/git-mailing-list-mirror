From: Jeff King <peff@peff.net>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Mon, 14 Dec 2009 21:39:18 -0500
Message-ID: <20091215023918.GA14689@coredump.intra.peff.net>
References: <1260822484.9379.53.camel@localhost>
 <20091214211142.GC9364@coredump.intra.peff.net>
 <1260825629.9379.56.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Paris <eparis@redhat.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 03:39:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKNK2-00028o-LY
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 03:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458AbZLOCj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 21:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbZLOCj0
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 21:39:26 -0500
Received: from peff.net ([208.65.91.99]:35757 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753257AbZLOCjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 21:39:25 -0500
Received: (qmail 18421 invoked by uid 107); 15 Dec 2009 02:43:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 14 Dec 2009 21:43:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Dec 2009 21:39:18 -0500
Content-Disposition: inline
In-Reply-To: <1260825629.9379.56.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135263>

On Mon, Dec 14, 2009 at 04:20:29PM -0500, Eric Paris wrote:

> I'm pushing a copy of the whole repo (all 1.9G after bzip compression)
> to
> 
> http://people.redhat.com/~eparis/git-tar/
> 
> But it's going to take a couple hours.

Holy cow. Almost 150 packs, and that's not even everything. The tarball
is missing a bunch of objects, because it points to your kernel-1 as an
alternate. So I suspect we would need that, as well, to recreate.

-Peff
