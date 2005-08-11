From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Thu, 11 Aug 2005 22:32:58 +0200
Message-ID: <20050811203258.GA3560@mars.ravnborg.org>
References: <46a038f9050810155642bb5580@mail.gmail.com> <20050810233953.GV28270@kiste.smurf.noris.de> <E1E33Zb-0004dT-Bx@highlab.com> <46a038f90508102144358a4bcf@mail.gmail.com> <Pine.LNX.4.58.0508102200560.3295@g5.osdl.org> <E1E35vU-0004nP-JR@highlab.com> <Pine.LNX.4.58.0508110915210.3295@g5.osdl.org> <E1E3IOG-0005HO-AK@highlab.com> <20050811201558.GA2874@mars.ravnborg.org> <20050811202410.GB5411@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Kuzminsky <seb@highlab.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 22:29:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3JgK-0004WW-Sd
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 22:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVHKU3i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 16:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVHKU3i
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 16:29:38 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:11856 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932389AbVHKU3i
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 16:29:38 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepa.post.tele.dk (Postfix) with ESMTP id ADCF347FECA;
	Thu, 11 Aug 2005 22:29:32 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 706D96AC01D; Thu, 11 Aug 2005 22:32:58 +0200 (CEST)
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20050811202410.GB5411@kiste.smurf.noris.de>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 11, 2005 at 10:24:10PM +0200, Matthias Urlichs wrote:
> Hi,
> 
> Sam Ravnborg:
> > > 
> > > Anyway, enough of this.  I understand the name will not change and I'm
> > > ok with that.  I'll deal with it on our (Debian's) end.
> > 
> > The easy fix is to kill the small git script that is not
> > mandatory anyway (as far as my quick grep told me).
> 
> I'd vote to keep the scripts in the default build, so that people
> who like to compile their own package (i.e. everybody _except_ the
> Debian packager ;-) get to keep their git and cg scripts.
> 
> A small Debian-specific patch to rename the offending scripts (and drop
> the Conflicts: entries) is cheap.

Yep - my comment was directed to debian only. Not git-core.

	Sam
