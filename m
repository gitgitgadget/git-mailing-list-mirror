From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2015, #04; Tue, 24)
Date: Tue, 1 Dec 2015 18:10:44 -0500
Message-ID: <20151201231044.GA13245@sigill.intra.peff.net>
References: <20151125010722.GA23632@sigill.intra.peff.net>
 <20151128154010.GA15706@vauxhall.crustytoothpaste.net>
 <20151128163543.GA26759@sigill.intra.peff.net>
 <20151128170932.GC15706@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 00:11:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3u4T-0006cN-SY
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 00:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbbLAXKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 18:10:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:35985 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932126AbbLAXKr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 18:10:47 -0500
Received: (qmail 22363 invoked by uid 102); 1 Dec 2015 23:10:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Dec 2015 17:10:47 -0600
Received: (qmail 23808 invoked by uid 107); 1 Dec 2015 23:10:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Dec 2015 18:10:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Dec 2015 18:10:44 -0500
Content-Disposition: inline
In-Reply-To: <20151128170932.GC15706@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281861>

On Sat, Nov 28, 2015 at 05:09:32PM +0000, brian m. carlson wrote:

> > I got a bunch of conflicts trying to merge it into 'next' and 'pu' and
> > punted on it. I think the tricky bits are coming from
> > dt/refs-backend-pre-vtable, where there was a lot of code movement.
> 
> I think as for merging into the latest pu, the thing you want to do in
> refs.c is simply take what pu has.  You'll have to fix up one additional
> struct object call site.  The same thing goes for builtin/merge.c and
> builtin/branch.c, where the code I changed has since been eliminated.
> 
> I also noticed that merge-recursive.c and builtin/ff-refs.c needed some
> minor fixups as well, but a quick compile will show you where those are.
> I've included a diff for those two below.

Thanks, this gave me an opportunity to play with Junio's merge-fix
scripts. :) The result will be in the "pu" I push out shortly.

-Peff
