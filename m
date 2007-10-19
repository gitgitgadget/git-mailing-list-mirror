From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 09:05:08 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710190859400.19446@xanadu.home>
References: <20071019062219.GA28499@coredump.intra.peff.net>
 <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com>
 <20071019073938.GN14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 15:06:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IirXW-0002SY-Ss
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 15:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758504AbXJSNFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 09:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758008AbXJSNFL
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 09:05:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60187 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915AbXJSNFK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 09:05:10 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ500ELHTOK1780@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 19 Oct 2007 09:05:09 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071019073938.GN14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61701>

On Fri, 19 Oct 2007, Shawn O. Pearce wrote:

> What about this on top of Jeff's patch?
> 
> $ git fetch jc
> ...
> ==> git://repo.or.cz/alt-git.git
>  * tag junio-gpg-pub ......................... (new)
>  * tag v1.5.0 .......................... (tag moved)
> 
> $ git fetch me
> ...
> ==> git://repo.or.cz/git/spearce.git
>  * branch gitk -> spearce/gitk ............... (new)
>  * branch maint -> spearce/maint
>  * branch master -> spearce/master
>  * branch next -> spearce/next
>  * branch pu -> spearce/pu ......... (forced update)
>  * branch todo -> spearce/todo ............... (new)
> 
> The width of the terminal is computed to produce the ... padding.
> I used a very narrow terminal to produce the above so it doesn't
> linewrap badly in email.  If we cannot get the terminal width then
> we just don't produce the padding.

I like it.

I would change the '*' to a '+' for a forced update (for similarity with 
the + notation in refspecs), and a '!' instead of a '-' for refused 
update which might be more indicative of a refusal.


Nicolas
