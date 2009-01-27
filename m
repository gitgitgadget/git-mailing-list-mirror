From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Tue, 27 Jan 2009 15:39:39 -0800
Message-ID: <20090127233939.GD1321@spearce.org>
References: <bab6a2ab0901271504j73dce7afjf8436c3c7c83b770@mail.gmail.com> <bab6a2ab0901271510y1e3e6912t82ff16e0f912d4b6@mail.gmail.com> <alpine.DEB.1.00.0901280034310.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: PJ Hyett <pjhyett@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 28 00:41:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRxYH-0007hX-Es
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 00:41:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbZA0Xjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 18:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbZA0Xjl
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 18:39:41 -0500
Received: from george.spearce.org ([209.20.77.23]:52281 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbZA0Xjk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 18:39:40 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id B5FD038210; Tue, 27 Jan 2009 23:39:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901280034310.3586@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107427>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 27 Jan 2009, PJ Hyett wrote:
> 
> > To expand further, here's the output from the command line when this happened.
> > 
> > ~/Development/github(jetty)$ git push pjhyett jetty
> > fatal: bad object e13a86261c6e710af8fd4b5fb093b28b8583d820
> > error: pack-objects died with strange error
> > error: failed to push some refs to 'git@github.com:pjhyett/github.git'
> 
> Hmm.  The only thing I could think of is that the pack-objects used by 
> your git-daemon is somehow not at the right version...

No, that's pack-objects on the client.

Its freaking weird.  I don't know why a server side upgrade would
cause this on the client side.

FWIW, in 1.6.1 the only mention of those bad object messages
is inside revision.c.  I can't see why we'd get one of those
by itself.  I would have expected messages from deeper down
too, like from sha1_file.c.
 
-- 
Shawn.
