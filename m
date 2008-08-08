From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to replace a single corrupt, packed object?
Date: Fri, 8 Aug 2008 07:39:18 -0700
Message-ID: <20080808143918.GB9152@spearce.org>
References: <alpine.DEB.1.00.0808081639490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, nico@cam.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 08 16:40:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRT8g-0004yI-Sb
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 16:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbYHHOjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 10:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbYHHOjT
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 10:39:19 -0400
Received: from george.spearce.org ([209.20.77.23]:43946 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbYHHOjS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 10:39:18 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5E8BB38420; Fri,  8 Aug 2008 14:39:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808081639490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91672>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> my auto gc kicked in, and shows this:
> 
> fatal: corrupt packed object for 2c1e128aa51e3a64bd61556c0cd488628b423ccf
> error: failed to run repack
> 
> Fortunately, I have the uncorrupted object somewhere else.  So I copy the 
> single object as a loose one, and all is fine.  Right?
> 
> Wrong.
> 
> Repack still picks up the corrupt object instead of the good one.  What's 
> the best way out?

Use a 1.6.0 rc?  Nico I thought fixed this in 1.6 to automatically
try and find another copy of an object if the first copy considered
for inclusion into the pack was corrupt.

-- 
Shawn.
