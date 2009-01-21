From: Jeff King <peff@peff.net>
Subject: Re: Deleting remote branch pointed by remote HEAD
Date: Wed, 21 Jan 2009 14:16:19 -0500
Message-ID: <20090121191619.GE21686@coredump.intra.peff.net>
References: <e29894ca0901210502n1ed1187bm46669a402ab4fe48@mail.gmail.com> <49773240.7090605@drmicha.warpmail.net> <e29894ca0901210638t636de791sf27d28893a7a0b65@mail.gmail.com> <49773E48.90302@drmicha.warpmail.net> <20090121161940.GA20702@coredump.intra.peff.net> <94a0d4530901211031s18261776rf8abfddcdcb42402@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 20:17:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPiaB-0005Re-Hx
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 20:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbZAUTQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 14:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbZAUTQW
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 14:16:22 -0500
Received: from peff.net ([208.65.91.99]:53673 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974AbZAUTQV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 14:16:21 -0500
Received: (qmail 17008 invoked by uid 107); 21 Jan 2009 19:16:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 21 Jan 2009 14:16:26 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2009 14:16:19 -0500
Content-Disposition: inline
In-Reply-To: <94a0d4530901211031s18261776rf8abfddcdcb42402@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106649>

On Wed, Jan 21, 2009 at 08:31:50PM +0200, Felipe Contreras wrote:

> Why should we care about the remote HEAD? Isn't that relevant only
> when cloning to find out the branch to checkout?

You can use the shorthand $foo to refer to refs/remotes/$foo/HEAD. Which
means, in the default case, you can refer to just "origin" to talk about
origin's master branch.

But as Daniel noted, that is really about local preference for "what is
the most interesting branch on the remote". You might want to track what
the remote sets to HEAD, or you might want to set it individually.

-Peff
