From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 10:14:59 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710191009330.19446@xanadu.home>
References: <20071019062219.GA28499@coredump.intra.peff.net>
 <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com>
 <20071019073938.GN14735@spearce.org>
 <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com>
 <20071019113822.GB16726@thunk.org> <4718A3AB.7090301@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Theodore Tso <tytso@thunk.org>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 16:15:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IisdQ-0002WV-AJ
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 16:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758928AbXJSOPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 10:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757721AbXJSOPF
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 10:15:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46892 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759399AbXJSOPB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 10:15:01 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ500MWJWWZL350@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 19 Oct 2007 10:15:00 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4718A3AB.7090301@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61713>

On Fri, 19 Oct 2007, Johannes Sixt wrote:

> Theodore Tso schrieb:
> > ==> git://repo.or.cz/git/spearce.git
> >  * branch gitk -> spearce/gitk		(new)
> >  * branch maint -> spearce/maint	1aa3d01..e7187e4
> >  * branch master -> spearce/master	de61e42..7840ce6
> >  * branch next -> spearce/next		895be02..2fe5433
> >  + branch pu -> spearce/pu		89fa332...1e4c517
> >  * branch todo -> spearce/todo		(new)
> 
> > As far as the padding, it would be a pain to figure out how to make
> > the right hand column be padded so that it starts 3 spaces after the
> > longest "  * branch foo -> bar" line, but that would look the best.
> 
> But this way it wouldn't be difficult at all:
> 
> ==> git://repo.or.cz/git/spearce.git
>  * (new)              gitk -> spearce/gitk
>  * 1aa3d01..e7187e4   maint -> spearce/maint
>  * de61e42..7840ce6   master -> spearce/master
>  * 895be02..2fe5433   next -> spearce/next
>  + 89fa332...1e4c517  pu -> spearce/pu
>  * (new)              todo -> spearce/todo

Actually I think this is the best format so far: one line per branch, no 
terminal width issue (long branch names are simply wrapped), the 
old..new info is there also with the single character marker to quickly 
notice the type of update.


Nicolas
