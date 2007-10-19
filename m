From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 10:52:57 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710191050090.19446@xanadu.home>
References: <20071019062219.GA28499@coredump.intra.peff.net>
 <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com>
 <20071019073938.GN14735@spearce.org>
 <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com>
 <20071019113822.GB16726@thunk.org> <4718A3AB.7090301@viscovery.net>
 <alpine.LFD.0.9999.0710191009330.19446@xanadu.home>
 <8aa486160710190731v67626fd8wa94ba069a17f73ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_Uf5z2ZlWY7xBan4ftt3EUQ)"
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Theodore Tso <tytso@thunk.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 16:53:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IitE4-0004TV-D0
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 16:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965531AbXJSOw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 10:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965510AbXJSOw7
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 10:52:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52517 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965490AbXJSOw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 10:52:58 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ500GE2YO9YSV0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 19 Oct 2007 10:52:57 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <8aa486160710190731v67626fd8wa94ba069a17f73ce@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61723>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_Uf5z2ZlWY7xBan4ftt3EUQ)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Fri, 19 Oct 2007, Santi Béjar wrote:

> I like it too. I would like to add some more descripton, because I
> think for newbies the .. and ... can be overlooked. Something like:
> 
> $ git fetch spearce
> ...
> URL: git://repo.or.cz/git/spearce.git
>  * (new)              spearce/gitk: new branch 'gitk'
>  * 1aa3d01..e7187e4   spearce/maint: fast forward to branch 'maint'
>  * de61e42..7840ce6   spearce/master: fast forward to branch 'master'
>  * 895be02..2fe5433   spearce/next: fast forward to branch 'next'
>  + 89fa332...1e4c517  spearce/pu: forcing update to non-fast forward branch 'pu'
>  * (new)              spearce/todo: new branch spearce/todo

Well, I don't like it as much.  First I don't think newbies will care 
much more even if the type of update is spelled out verbosely.  Better 
keep it short and add all the necessary information in the fetch man 
page instead.


Nicolas

--Boundary_(ID_Uf5z2ZlWY7xBan4ftt3EUQ)--
