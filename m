From: Jeff King <peff@peff.net>
Subject: Re: problem with branches
Date: Mon, 2 Jun 2008 13:23:47 -0400
Message-ID: <20080602172346.GA18945@sigill.intra.peff.net>
References: <556d90580806020314u7ba60af7kc0176a1867ba32fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alf Clement <alf.clement@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 19:24:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Dm4-0001Vn-D8
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 19:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbYFBRXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 13:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbYFBRXx
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 13:23:53 -0400
Received: from peff.net ([208.65.91.99]:2383 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395AbYFBRXx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 13:23:53 -0400
Received: (qmail 18565 invoked by uid 111); 2 Jun 2008 17:23:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 02 Jun 2008 13:23:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jun 2008 13:23:47 -0400
Content-Disposition: inline
In-Reply-To: <556d90580806020314u7ba60af7kc0176a1867ba32fb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83545>

On Mon, Jun 02, 2008 at 12:14:07PM +0200, Alf Clement wrote:

>  = [up to date]      TEST -> TEST
>  ! [remote rejected] master -> master (hook declined)
>  ! [remote rejected] v3.11 -> v3.11 (hook declined)
> error: failed to push some refs to 'git://XXXX/YY'

OK. So your "update" hook returned failure. What's in the remote's
.git/hooks/update?

> I also get a warning when moving between branches:
> $ git checkout v3.11
> Switched to branch "v3.11"
> Your branch is ahead of the tracked remote branch 'origin/v3.11' by 1 commit.

This is fine; it's just reminding you that you have commits that could
be pushed.

-Peff
