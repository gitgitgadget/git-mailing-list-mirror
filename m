From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Switching heads and head vs branch after CVS import
Date: Mon, 15 Aug 2005 21:48:28 +1200
Message-ID: <46a038f90508150248159e070e@mail.gmail.com>
References: <46a038f905081417241f9598cc@mail.gmail.com>
	 <Pine.LNX.4.58.0508141737270.3553@g5.osdl.org>
	 <46a038f905081419057cc6b5cd@mail.gmail.com>
	 <Pine.LNX.4.58.0508141937251.3553@g5.osdl.org>
	 <pan.2005.08.15.09.07.10.118103@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 11:49:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4ba9-0007Vb-Ho
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 11:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVHOJse (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 05:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVHOJse
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 05:48:34 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:24279 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932331AbVHOJsd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 05:48:33 -0400
Received: by rproxy.gmail.com with SMTP id i8so750712rne
        for <git@vger.kernel.org>; Mon, 15 Aug 2005 02:48:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FbHaIqY1QZNxpBcje6BegmZ3+ZcEfuk3t0OKt+r8ePDbRYTFFOX45M2vp/ptEPHf6U7NE7K5lL0No/vt5OIc81+gx/mlyySzaHvDZYWMkE9YKydZswvTXFnVeC4pL4aSMMT/45BDjHZdVH7vel3kZvD+9FeAcEHyDBxtRoYMIdk=
Received: by 10.38.104.22 with SMTP id b22mr1894261rnc;
        Mon, 15 Aug 2005 02:48:28 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Mon, 15 Aug 2005 02:48:28 -0700 (PDT)
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.08.15.09.07.10.118103@smurf.noris.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 8/15/05, Matthias Urlichs <smurf@smurf.noris.de> wrote:
> Umm, actually, no, cvsimport doesn't do merges. Dunno where Martin got his
> from, but it wasn't me. ;-)

Just wishful thinking, and a viewing things on a remote box over a
slow x11-over-ssh connection. When I think about it, it doesn't seem
possible either, so I better stop dreaming.

> > Sven, Matthias, opinions? I've never used CVS keyword expansion, and
> > always felt it was pointless, but hey..
> 
> I have intentionally kept keyword expansion on when I wrote the code,
> because matching up the files from CVS with files gathered from tarballs,
> Debian repositories, and what-not, becomes a whole lot easier that way.

Makes sense in that context. On the other hand, if you are you're
migrating a project from cvs to git, getting rid of the noise is good.

And the resulting git repo will actually let you do trivial merges of
old commits after you've switched -- otherwise every file-level merge
will conflict, as it does in cvs when you don't use -kk.

cheers,


martin
