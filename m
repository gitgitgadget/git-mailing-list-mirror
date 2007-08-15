From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch - scripts/get_maintainer.pl
Date: Wed, 15 Aug 2007 21:37:45 +0200
Message-ID: <m3fy2kk2ra.fsf@maximus.localdomain>
References: <1187026955.2688.4.camel@laptopd505.fenrus.org>
	<1187037445.6628.98.camel@heimdal.trondhjem.org>
	<1187054366.2757.0.camel@laptopd505.fenrus.org>
	<46C10AA8.3090505@gmail.com>
	<20070814102033.604c8695@the-village.bc.nu>
	<46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost>
	<46C1EE6F.2080807@gmail.com> <1187116082.32555.122.camel@localhost>
	<alpine.LFD.0.999.0708141131140.30176@woody.linux-foundation.org>
	<20070814193333.GI21089@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Joe Perches <joe@perches.com>,
	Rene Herman <rene.herman@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
X-From: git-owner@vger.kernel.org Wed Aug 15 21:38:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILOgq-0004q1-0E
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 21:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935634AbXHOThv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 15:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935263AbXHOThu
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 15:37:50 -0400
Received: from khc.piap.pl ([195.187.100.11]:38834 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935634AbXHOTht (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 15:37:49 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id 0E52965652; Wed, 15 Aug 2007 21:37:46 +0200 (CEST)
In-Reply-To: <20070814193333.GI21089@ftp.linux.org.uk> (Al Viro's message of "Tue, 14 Aug 2007 20:33:33 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55940>

Al Viro <viro@ftp.linux.org.uk> writes:

> I'm not suggesting something like fs.ext2@kernel.org with something
> like majordomo allowing to add yourself to those,

Why not

> but something less
> extreme in that direction might be worth thinking about...  Hell,
> even simple
> $ finger fs/minix/dir.c@cc.kernel.org
> with majordomo-like interface for adding yourself to such lists
> might solve most of those problems...

I think so.

And you would be able to add yourself even if you're merely
interested in something, not a maintainer.

However I think the mailing lists could do better. Duplicate
suppression, among other things.

And they could eventually supersede the subsystem mailing lists
we use today. Just use net@kernel.org or drivers.net@kernel.org.
-- 
Krzysztof Halasa
