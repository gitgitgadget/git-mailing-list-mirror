From: Jeff King <peff@peff.net>
Subject: Re: git describe weird behaviour
Date: Wed, 8 Dec 2010 22:28:02 -0500
Message-ID: <20101209032802.GA18773@sigill.intra.peff.net>
References: <20101110010016.GC22105@genesis.frugalware.org>
 <20101110041428.GA8955@sigill.intra.peff.net>
 <20101110140334.GJ22105@genesis.frugalware.org>
 <20101209013323.GJ22105@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Dec 09 04:28:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQXB1-00085e-3Y
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 04:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786Ab0LID2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 22:28:08 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38085 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632Ab0LID2H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 22:28:07 -0500
Received: (qmail 32462 invoked by uid 111); 9 Dec 2010 03:28:04 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 09 Dec 2010 03:28:04 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Dec 2010 22:28:02 -0500
Content-Disposition: inline
In-Reply-To: <20101209013323.GJ22105@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163260>

On Thu, Dec 09, 2010 at 02:33:23AM +0100, Miklos Vajna wrote:

> On Wed, Nov 10, 2010 at 03:03:34PM +0100, Miklos Vajna <vmiklos@frugalware.org> wrote:
> > > The patch below implements that in a very rough-and-dirty way. It does
> > > find the 1.4 tag in your repository that you expect. However:
> > 
> > Yes, works here as well:
> > 
> > $ ~/git/git/git describe
> > 1.4pre1-210-g48b67cd
> 
> Any update on this? I still have this patch in my tree to get correct
> git describe output. :)

Sorry, no, I haven't had time to think about it, and I probably won't
for a few more weeks at least.

The patch I posted was giving some really weird results for git.git,
though, so it is definitely not OK for inclusion as-is.

-Peff
