From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 09:15:26 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710190913280.19446@xanadu.home>
References: <20071019062219.GA28499@coredump.intra.peff.net>
 <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com>
 <20071019073938.GN14735@spearce.org>
 <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_5486P1Zr0xlBp15aYOHQHA)"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 15:15:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iirhc-0005HI-Vn
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 15:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbXJSNPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 09:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbXJSNPh
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 09:15:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21648 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbXJSNPg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 09:15:36 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQ50070PU5RRDI1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 19 Oct 2007 09:15:27 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61702>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_5486P1Zr0xlBp15aYOHQHA)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Fri, 19 Oct 2007, Santi Béjar wrote:

> Another possibility is with just some minor reductions from the
> current output, as:
> 
> $ git fetch spearce
> ...
> >From git://repo.or.cz/git/spearce
> * spearce/gitk: fast forward to branch 'gitk'
>   old..new: 0d6df4d..2b5afb7
> * spearce/maint: fast forward to branch 'maint'
>   old..new: 1aa3d01..e7187e4
> * spearce/master: fast forward to branch 'master'
>   old..new: de61e42..7840ce6
> * spearce/next: fast forward to branch 'next'
>   old..new: 895be02..2fe5433
> * spearce/pu: forcing update to non-fast forward branch 'pu'
>   old...new: 89fa332...1e4c517
> 
> This way it is slightly less terse than the other proposals but not
> that cryptic and it normally fits in one line without padding. And I
> really like to see what has changed explicitly with the old..new line.

I think the advantage of having only one line of output per branch 
really outweight the need for old..new notation.  Do you really benefit 
from it?


Nicolas

--Boundary_(ID_5486P1Zr0xlBp15aYOHQHA)--
