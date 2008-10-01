From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH, resent] fix openssl headers conflicting with custom
	SHA1 implementations
Date: Wed, 1 Oct 2008 09:39:52 -0700
Message-ID: <20081001163952.GJ21310@spearce.org>
References: <alpine.LFD.2.00.0809301621091.3635@xanadu.home> <20080930203928.GN21310@spearce.org> <alpine.LFD.2.00.0809301645340.3635@xanadu.home> <20080930205122.GO21310@spearce.org> <20081001034712.GE24513@coredump.intra.peff.net> <20081001155458.GF21310@spearce.org> <20081001160418.GA13917@coredump.intra.peff.net> <20081001161047.GG21310@spearce.org> <alpine.LFD.2.00.0810011222090.3635@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 18:42:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl4lD-0007qh-Lo
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 18:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbYJAQjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 12:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbYJAQjx
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 12:39:53 -0400
Received: from george.spearce.org ([209.20.77.23]:35258 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244AbYJAQjx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 12:39:53 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 58A903835F; Wed,  1 Oct 2008 16:39:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810011222090.3635@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97248>

Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 1 Oct 2008, Shawn O. Pearce wrote:
> > Jeff King <peff@peff.net> wrote:
> > > On Wed, Oct 01, 2008 at 08:54:58AM -0700, Shawn O. Pearce wrote:
> > > 
> > > > I think its easy enough to just rename our SHA_CTX and SHA_*
> > > > functions to something more git specific.  Since its mostly a global
> > > 
> > > I think that is the cleanest and simplest solution. As for merging pain,
> > > I think Junio would generally do a mechanical change like this as the
> > > first thing after a release. However, in this case, I think we might
> > > want it sooner if the conflict is causing breakage.
> > 
> > Oh, yea, that's probably true.  But with ARM broken according to
> > Nico I'd almost just want this fixed in the upcoming 1.6.1 release.
> 
> > Its simple enough to do.  We can even do something like this during
> > the transition period until right before the 1.6.1 final:
> 
> Because it's easy to do then I'd do it sooner than later.

Nico, are you going to write a patch for this?  If not I'll do it
myself later today or tomorrow morning.  I don't mind doing it,
I just don't want to duplicate work with you.  I've got too much
else going on to waste my time that way.

Of course I'm wasting time on this email... ;-)

-- 
Shawn.
