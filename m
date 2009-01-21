From: Jeff King <peff@peff.net>
Subject: Re: Deleting remote branch pointed by remote HEAD
Date: Wed, 21 Jan 2009 14:53:48 -0500
Message-ID: <20090121195348.GB3589@sigill.intra.peff.net>
References: <e29894ca0901210502n1ed1187bm46669a402ab4fe48@mail.gmail.com> <49773240.7090605@drmicha.warpmail.net> <e29894ca0901210638t636de791sf27d28893a7a0b65@mail.gmail.com> <49773E48.90302@drmicha.warpmail.net> <20090121161940.GA20702@coredump.intra.peff.net> <alpine.LNX.1.00.0901211237530.19665@iabervon.org> <20090121191219.GD21686@coredump.intra.peff.net> <20090121191408.GA22958@coredump.intra.peff.net> <alpine.LNX.1.00.0901211443140.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 20:55:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPjAR-0004TG-RX
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 20:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbZAUTxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 14:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbZAUTxv
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 14:53:51 -0500
Received: from peff.net ([208.65.91.99]:34209 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319AbZAUTxv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 14:53:51 -0500
Received: (qmail 17450 invoked by uid 107); 21 Jan 2009 19:53:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 21 Jan 2009 14:53:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2009 14:53:48 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0901211443140.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106658>

On Wed, Jan 21, 2009 at 02:50:40PM -0500, Daniel Barkalow wrote:

> I think the ideal thing is to keep the symref as a reminder and just give 
> a non-confusing error message instead of a confusing one. E.g.:
> 
> """
> $foo is set to mean the tracking branch $foo/bar, which does not exist. 
> Use:
> 
>   git remote set-default $foo <name>
> 
> to set a new default branch for $foo.
> """
> 
> (And, of course, add that subcommand to remote)

I think that would be reasonable behavior (and probably a special mode
for set-default to just update from the remote's idea of HEAD).

-Peff
