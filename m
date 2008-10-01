From: Jeff King <peff@peff.net>
Subject: obscure platform autobuilders
Date: Wed, 1 Oct 2008 03:16:53 -0400
Message-ID: <20081001071653.GA21174@sigill.intra.peff.net>
References: <20080924154632.GR3669@spearce.org> <e2b179460809260624n4b329345q3610069af5af75c2@mail.gmail.com> <20080926225423.GA25502@coredump.intra.peff.net> <e2b179460809290051q8ca76a4k7cf0af2748a5f0fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 09:18:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkvyJ-0007mK-Ok
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 09:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbYJAHQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 03:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbYJAHQ6
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 03:16:58 -0400
Received: from peff.net ([208.65.91.99]:3992 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbYJAHQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 03:16:57 -0400
Received: (qmail 16259 invoked by uid 111); 1 Oct 2008 07:16:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 01 Oct 2008 03:16:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Oct 2008 03:16:53 -0400
Content-Disposition: inline
In-Reply-To: <e2b179460809290051q8ca76a4k7cf0af2748a5f0fc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97208>

On Mon, Sep 29, 2008 at 08:51:29AM +0100, Mike Ralphson wrote:

> Feel free to push changes to gitbuild.sh, including getting rid of
> anything which looks environment-specific.

I actually went a step further and revamped the architecture a bit.
Check out the "platform" branch in gitbuild.git. My goal was to try to
include more information in the gitbuild repository about exactly what
goes into the test setup for each platform.

I'm currently building, testing, and pushing FreeBSD 6.1 and Solaris 2.8
with it (you can see the copious tests I am skipping in
jk/solaris/config).

If you like this approach, please go ahead and add an "mr/aix" profile
with your setup. See the README for details, and let me know if you have
questions.  The script is a mish-mash of yours, mine, and some extra
rewrites. I wouldn't be surprised if it needs a tweak or two. :)

-Peff
