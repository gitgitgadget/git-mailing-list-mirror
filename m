From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Continue git clone after interruption
Date: Mon, 17 Aug 2009 08:23:58 -0700
Message-ID: <20090817152358.GV1033@spearce.org>
References: <1250509342.2885.13.camel@cf-48> <alpine.DEB.1.00.0908171430010.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tomasz Kontusz <roverorna@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 17:24:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md445-0007G7-W5
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 17:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057AbZHQPX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 11:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754943AbZHQPX5
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 11:23:57 -0400
Received: from george.spearce.org ([209.20.77.23]:56671 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875AbZHQPX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 11:23:57 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EF853381FD; Mon, 17 Aug 2009 15:23:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0908171430010.4991@intel-tinevez-2-302>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126193>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 17 Aug 2009, Tomasz Kontusz wrote:
> 
> > is anybody working on making it possible to continue git clone after 
> > interruption? It would be quite useful for people with bad internet 
> > connection (I was downloading a big repo lately, and it was a bit 
> > frustrating to start it over every time git stopped at ~90%).
> 
> Unfortunately, we did not have enough GSoC slots for the project to allow 
> restartable clones.
> 
> There were discussions about how to implement this on the list, though.

Unfortunately, those of us who know how the native protocol works
can't come to an agreement on how it might be restartable.  If you
really read the archives on this topic, you'll see that Nico and I
disagree about how to do this.  IIRC Nico's position is, it isn't
really possible to implement a restart.

-- 
Shawn.
