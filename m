From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Git as a filesystem
Date: Fri, 21 Sep 2007 19:06:32 -0700
Message-ID: <20070922020632.GB8327@muzzle>
References: <fbe8b1780709210351x30775090ldab559f25c27645d@mail.gmail.com> <Pine.LNX.4.64.0709211208440.28395@racer.site> <fbe8b1780709210441n281248dbh5ba9934d09d6bbfc@mail.gmail.com> <alpine.LFD.0.9999.0709210912120.32185@xanadu.home> <20070921233343.GA8327@muzzle> <Pine.LNX.4.64.0709220040450.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Peter Stahlir <peter.stahlir@googlemail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 22 04:06:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYuOG-0001x0-06
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 04:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945AbXIVCGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 22:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbXIVCGe
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 22:06:34 -0400
Received: from hand.yhbt.net ([66.150.188.102]:55050 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807AbXIVCGd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 22:06:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id ADA6A7DC029;
	Fri, 21 Sep 2007 19:06:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709220040450.28395@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58911>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,

Hi,

> On Fri, 21 Sep 2007, Eric Wong wrote:
> > 
> > On a similar note, has anybody experimented with using git to
> > store maildirs or news spools?  I'd imagine the quoted portions of
> > most message threads could be delta-compressed quite efficiently.
> 
> I store all my mail in a git repository.  Works beautifully.  Except that 
> the buffers on my laptop are constantly full :-(  So a simple commit takes 
> some waiting.
> 
> Should be no issue on normal (desktop) machines.

D'oh.  I already have maildir performance problems on my laptop.

I wonder how well only having an index and no commits (no versioning),
and manual packing with pack-objects would work.  Packing could be
optimized to order objects based on the Message-Id, References, and
In-Reply-To headers, too.

-- 
Eric Wong
