From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 21:30:19 -0700
Message-ID: <20090528043019.GA30527@spearce.org>
References: <m3y6siboij.fsf@localhost.localdomain> <alpine.LFD.2.01.0905270922250.3435@localhost.localdomain> <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain> <alpine.LFD.2.00.0905271312220.3906@xanadu.home> <20090527215314.GA10362@coredump.intra.peff.net> <alpine.LFD.2.01.0905271457310.3435@localhost.localdomain> <f95910c20905271609u63d04965oa38b8af34d7704c1@mail.gmail.com> <alpine.LFD.2.01.0905271825520.3435@localhost.localdomain> <alpine.LFD.2.00.0905272312370.3906@xanadu.home> <loom.20090528T041831-21@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 06:30:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9XG9-000561-OB
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 06:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbZE1EaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 00:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbZE1EaT
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 00:30:19 -0400
Received: from george.spearce.org ([209.20.77.23]:55550 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbZE1EaS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 00:30:18 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E633C381FD; Thu, 28 May 2009 04:30:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <loom.20090528T041831-21@post.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120145>

Eric Raible <raible@gmail.com> wrote:
> Nicolas Pitre <nico <at> cam.org> writes:
> > On Wed, 27 May 2009, Linus Torvalds wrote:
> > 
> > > +pack.packDeltaLimit::
> > > +	The default maximum size of objects that we try to delta.
> > 
> > The option name feels a bit wrong here, like if it meant the max number 
> > of deltas in a pack.  Nothing better comes to my mind at the moment 
> > though.
> 
> pack.maxDeltaSize sounds weird when said aloud.
> How about pack.deltaMaxSize?

That sounds like, how big should a delta be?  E.g. set it to 200
and any delta instruction stream over 200 bytes would be discarded,
causing the whole object to be stored instead.  Which is obviously
somewhat silly, but that's the way I'd read that option...

-- 
Shawn.
