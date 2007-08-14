From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch -
	scripts/get_maintainer.pl
Date: Tue, 14 Aug 2007 12:57:15 -0700
Message-ID: <1187121435.32555.166.camel@localhost>
References: <1187026955.2688.4.camel@laptopd505.fenrus.org>
	 <1187037445.6628.98.camel@heimdal.trondhjem.org>
	 <1187054366.2757.0.camel@laptopd505.fenrus.org>
	 <46C10AA8.3090505@gmail.com> <20070814102033.604c8695@the-village.bc.nu>
	 <46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost>
	 <46C1EE6F.2080807@gmail.com> <1187116082.32555.122.camel@localhost>
	 <alpine.LFD.0.999.0708141131140.30176@woody.linux-foundation.org>
	 <20070814193333.GI21089@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Rene Herman <rene.herman@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934813AbXHNT5y@vger.kernel.org Tue Aug 14 21:58:02 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934813AbXHNT5y@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL2Wc-0006dV-NJ
	for glk-linux-kernel-3@gmane.org; Tue, 14 Aug 2007 21:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934813AbXHNT5y (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 14 Aug 2007 15:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758486AbXHNT5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Aug 2007 15:57:38 -0400
Received: from DSL022.labridge.com ([206.117.136.22]:4882 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754486AbXHNT5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Aug 2007 15:57:37 -0400
Received: from [192.168.1.128] ([192.168.1.128])
	by perches.com (8.9.3/8.9.3) with ESMTP id NAA23910;
	Tue, 14 Aug 2007 13:19:43 -0700
In-Reply-To: <20070814193333.GI21089@ftp.linux.org.uk>
X-Mailer: Evolution 2.10.2-2.1mdv2007.1 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55853>

On Tue, 2007-08-14 at 20:33 +0100, Al Viro wrote:
> FWIW, I suspect that we are looking at that from the wrong POV.  If
> that's about "who ought to be Cc'd on the issues dealing with <list
> of pathnames>", why does it have to be tied to "who is maintainer for
> <pathname>"?

Right, it doesn't have to.
I think a notification list would be just fine.

> I'm not suggesting something like fs.ext2@kernel.org with something
> like majordomo allowing to add yourself to those, but something less
> extreme in that direction might be worth thinking about...
> Hell, even simple
> $ finger fs/minix/dir.c@cc.kernel.org
> with majordomo-like interface for adding yourself to such lists
> might solve most of those problems...

Might solve all of my wants for this problem.

cheers, Joe
