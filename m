From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 17:40:48 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710191739270.19446@xanadu.home>
References: <20071019062219.GA28499@coredump.intra.peff.net>
 <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com>
 <20071019073938.GN14735@spearce.org>
 <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com>
 <20071019113822.GB16726@thunk.org>
 <20071019143844.GB23765@diana.vm.bytemark.co.uk>
 <alpine.LFD.0.9999.0710191058570.19446@xanadu.home>
 <20071019211755.GC751@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Oct 19 23:41:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iizap-0008Qi-FJ
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 23:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936480AbXJSVlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 17:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936460AbXJSVlG
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 17:41:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25737 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936438AbXJSVlE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 17:41:04 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQ6008DSHK0KOY1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 19 Oct 2007 17:40:49 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071019211755.GC751@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61768>

On Fri, 19 Oct 2007, Theodore Tso wrote:

> On Fri, Oct 19, 2007 at 11:03:00AM -0400, Nicolas Pitre wrote:
> > Well, the important thing is that the _content_ is moving from the 
> > remote repository to the local one.  That's how the arrow should be 
> > interpreted conceptually.  The fact that technically we end up assigning 
> > the local ref with the remote value is a technical issue.
> 
> If the _content_ is moving from the remote repository to the local
> one, I would think the arrow should be pointing from the remote
> repoistory to the local one, i.e.:
> 
>   * 895be02..2fe5433   next <- spearce/next
> 
> But right now we are proposing:
> 
>   * 895be02..2fe5433   next -> spearce/next
> 
> I would think the former makes more sense is the content is going
> *from* spearce/next into the local next branch.

No.  "next" is the name of the _remote_ branch that is stored locally in 
spearce/next.  So the arrow is correct.


Nicolas
