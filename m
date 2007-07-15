From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: question about git-submodule
Date: Sun, 15 Jul 2007 15:42:12 +0200
Message-ID: <20070715134212.GH2568@steel.home>
References: <20070713214630.GB7106@genesis.frugalware.org> <20070715083959.GC999MdfPADPa@greensroom.kotnet.org> <20070715104712.GF2568@steel.home> <20070715115148.GD999MdfPADPa@greensroom.kotnet.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: VMiklos <vmiklos@frugalware.org>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Jul 15 15:42:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA4Ml-0000em-Ev
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 15:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbXGONmQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 09:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbXGONmQ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 09:42:16 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:30038 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382AbXGONmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 09:42:16 -0400
Received: from tigra.home (Fca5f.f.strato-dslnet.de [195.4.202.95])
	by post.webmailer.de (fruni mo24) (RZmta 8.3)
	with ESMTP id v000c9j6FBKFpH ; Sun, 15 Jul 2007 15:42:14 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6EAB4277BD;
	Sun, 15 Jul 2007 15:42:13 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 05B85C164; Sun, 15 Jul 2007 15:42:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070715115148.GD999MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTNzsQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52551>

Sven Verdoolaege, Sun, Jul 15, 2007 13:51:48 +0200:
> On Sun, Jul 15, 2007 at 12:47:12PM +0200, Alex Riesen wrote:
> > Count me out. Junio convinced me instead and having tried the
> > subprojects I find it really convenient: I can choose when and what
> > should be updated and I can see what _can_ be updated, iff I decide
> > to. Subprojects defined in such a loosely way are more flexible then
> > having git-pull fetch subprojects by default.
> 
> I agree that fetching should probably be left as a separate operation,
> but if you have all the data, then I find it very inconvenient that
> every time you switch to a different commit you have to update
> all the subprojects separately too.

I found I do _not_ need to do it every time I switch to a different
commit.

> Did you change your mind about this part too?

Yep. I have less to transfer (and in fact, the subproject I mentioned
is kind of heavy and has a lot of binary stuff in it).

> > Sometimes I even want be
> > _sure_ the subprojects are completely untouched (I have some critical
> > parts in them).
> 
> The update in the superproject would fail if the subproject is dirty
> (just as with files.)

Haven't noticed this yet. Merge ignores subprojects. What do you mean?
