From: Jeff King <peff@peff.net>
Subject: Re: RAM consumption when working with the gcc repo
Date: Fri, 7 Dec 2007 16:40:49 -0500
Message-ID: <20071207214049.GB11613@coredump.intra.peff.net>
References: <9e4733910712071207p750c14f4h7abc5d637da3a478@mail.gmail.com> <20071207213928.GA11613@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:41:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0kwb-0003ig-FY
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 22:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754945AbXLGVkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 16:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755038AbXLGVkw
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 16:40:52 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1771 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754940AbXLGVkw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 16:40:52 -0500
Received: (qmail 13453 invoked by uid 111); 7 Dec 2007 21:40:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 07 Dec 2007 16:40:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Dec 2007 16:40:49 -0500
Content-Disposition: inline
In-Reply-To: <20071207213928.GA11613@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67471>

On Fri, Dec 07, 2007 at 04:39:28PM -0500, Jeff King wrote:

> Keep in mind that you are trying many different deltas, which are being
> held in memory, to find the right one and generate the 330MB file. And
> when you multiply that times N threads going at once, _each one_ is
> using a bunch of memory.
> 
> As Nico suggested, you could probably drop the memory usage by reducing
> the size of the delta cache.

Sorry, I clearly need to start reading to the ends of threads before
getting involved; I think Nico has already explained this with actual
numbers later on.

-Peff
