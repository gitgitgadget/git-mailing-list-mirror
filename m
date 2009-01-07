From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Google Summer of Code 2009
Date: Thu, 8 Jan 2009 00:30:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901080024170.7496@intel-tinevez-2-302>
References: <20090107183033.GB10790@spearce.org> <81b0412b0901071512k64a7d5e2u2c602b903f5233d3@mail.gmail.com> <20090107231431.GC10790@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 00:31:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKhs0-0000p4-Jd
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 00:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758275AbZAGXaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 18:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758345AbZAGXaH
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 18:30:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:53528 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756597AbZAGXaF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 18:30:05 -0500
Received: (qmail invoked by alias); 07 Jan 2009 23:30:03 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp063) with SMTP; 08 Jan 2009 00:30:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX192y0ITVi92L7ExUUDC9XND7iywtQejtwzgJIxFhd
	AyhB9EAGnxzUmX
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090107231431.GC10790@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104849>

Hi,

On Wed, 7 Jan 2009, Shawn O. Pearce wrote:

> Alex Riesen <raa.lkml@gmail.com> wrote:
> > 2009/1/7 Shawn O. Pearce <spearce@spearce.org>:
> > >
> > >  Organization ideas page:
> > >    http://git.or.cz/gitwiki/SoC2009Ideas
> > 
> > BTW, what happened to GitTorrent?
> 
> I got lazy and didn't copy everything over.  ;-)

Actually, that would have been lazy. :-)

> GitTorrent and restartable clone both should probably be on the 2009 
> idea list, though GitTorrent already has a code base from the failed 
> 2008 project that someone might be able to start and pick up from...

According to

	http://repo.or.cz/w/VCS-Git-Torrent.git

Joshua is still working on it (albeit slowly).

However, from what Sam said at the GitTogether, it might be a much better 
idea to look at the existing code as a fact-finding experiment, scrap it 
(excluding the experience), and start modifying git-daemon.

AFAICT Sam has a pretty clear idea how to go about it, and staying with C 
should make it much easier for other people to comment.

Note that there has been a flurry of emails on the gittorrent list a few 
weeks back, where somebody challenged the approach Sam wants to take, 
saying that BitTorrent has some very nice features that are absolutely 
necessary, such as its pretty awkward custom encoding.

But AFAICT Sam did a pretty good job at dispelling all of the objections.

Ciao,
Dscho
