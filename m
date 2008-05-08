From: Jeff King <peff@peff.net>
Subject: Re: git gc & deleted branches
Date: Thu, 8 May 2008 17:17:34 -0400
Message-ID: <20080508211734.GA819@sigill.intra.peff.net>
References: <alpine.LSU.1.10.0805081920160.8678@bianca.dialin.t-online.de> <20080508183926.GA30613@sigill.intra.peff.net> <alpine.LSU.1.10.0805082051210.10981@bianca.dialin.t-online.de> <48235D99.2040407@nrlssc.navy.mil> <alpine.LSU.1.10.0805082232070.4260@bianca.dialin.t-online.de> <20080508210125.GC32762@sigill.intra.peff.net> <alpine.LFD.1.10.0805081712270.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>,
	Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu May 08 23:18:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuDVO-0001kt-6c
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 23:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759982AbYEHVRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 17:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758074AbYEHVRd
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 17:17:33 -0400
Received: from peff.net ([208.65.91.99]:4911 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757344AbYEHVRc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 17:17:32 -0400
Received: (qmail 24117 invoked by uid 111); 8 May 2008 21:17:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 May 2008 17:17:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2008 17:17:34 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0805081712270.23581@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81567>

On Thu, May 08, 2008 at 05:15:34PM -0400, Nicolas Pitre wrote:

> > According to that commit message, prune is now a no-op. However, it
> > looks like it is still used for trigger a "repack -a" rather than
> > "repack -A". I don't know if it is worth making that behavior available
> 
> Well, actually this is a problem.
> 
> I think it is a good thing to deprecate gc --prune.  but if that means 
> that repack -a is never used then unreferenced and expired objects will 
> never be pruned if they're packed if one is always using 'git gc' as we 
> are advocating.

I thought that -A would eventually put them all into a single pack,
killing off the old packs.

-Peff
