From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Mon, 23 May 2005 20:52:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>
  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>  <1116611932.12975.22.camel@dhcp-188>
  <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org> 
 <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>  <1116615600.12975.33.camel@dhcp-188>
  <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com>
  <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>  <428E4D8C.3020606@zytor.com>
 <1116626652.12975.118.camel@dhcp-188> <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org>
 <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
 <4292A08A.5050108@cobite.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 05:51:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaQSE-0000nH-Il
	for gcvg-git@gmane.org; Tue, 24 May 2005 05:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVEXDw3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 23:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVEXDvj
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 23:51:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:13256 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261251AbVEXDua (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2005 23:50:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4O3oMjA014406
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 May 2005 20:50:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4O3oLxF005619;
	Mon, 23 May 2005 20:50:21 -0700
To: David Mansfield <david@cobite.com>
In-Reply-To: <4292A08A.5050108@cobite.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 23 May 2005, David Mansfield wrote:
> > 
> > Bah. What crud.
> > 
> 
> Hey, a polished turd is only so shiny...  cvsps is a 99% solution [to 
> the problem of extracting metatdata from cvs] only and cvs makes the 
> other 1% impossible.

The "what crud" refers to cvs. cvsps seems to be a great way to make a
tool to migrate away from CVS (or if forced to use CVS, at least show it
in a sane manner). So don't take it the wrong way.

I've gotten side-tracked with purely git issues, and since I don't 
actually have any CVS archives, the cvs->git translation will be on the 
back-burner for a while, but your "Ancestor branch" patch seems to at 
least solve the problem that cvsps didn't show all the information that 
was there. So now I know how to do branches, even if I don't think I'd 
ever _really_ merge them back (which is as much info as CVS contains). 

They'd just be dangling references, ie you could get to them if you wanted 
to, for historical reasons, and they could be merged merged by hand, of 
course. Some day..

		Linus
