From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Tue, 03 May 2005 10:24:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505031022340.14033@localhost.localdomain>
References: <200505030657.38309.alonz@nolaviz.org>
 <Pine.LNX.4.58.0505022131380.3594@ppc970.osdl.org>
 <Pine.LNX.4.62.0505030344170.14033@localhost.localdomain>
 <200505031013.57476.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, Alon Ziv <alonz@nolaviz.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 16:26:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSyKf-0003z9-05
	for gcvg-git@gmane.org; Tue, 03 May 2005 16:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVECOaV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 10:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVECO0m
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 10:26:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32874 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261572AbVECOYc
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 May 2005 10:24:32 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IFX0076E40Q4K@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 May 2005 10:24:26 -0400 (EDT)
In-reply-to: <200505031013.57476.mason@suse.com>
X-X-Sender: nico@localhost.localdomain
To: Chris Mason <mason@suse.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 3 May 2005, Chris Mason wrote:

> On Tuesday 03 May 2005 04:06, Nicolas Pitre wrote:
> > On Mon, 2 May 2005, Linus Torvalds wrote:
> > > If you do something like this, you want such a delta-blob to be named by
> > > the sha1 of the result, so that things that refer to it can transparently
> > > see either the original blob _or_ the "deltified" one, and will never
> > > care.
> >
> > Yep, that's what I've done last weekend (and just made it actually
> > work since people are getting interested).
> 
> Hmmm, something is strange here, am I using this wrong?
> 
> coffee:~/git/linus.orig # ./test-delta -d foo foo2 delta1
> coffee:~/git/linus.orig # ./test-delta -p foo delta1 out
> *** glibc detected *** free(): invalid next size (fast): 0x0804b008 ***
> Aborted

Can you send me your foo and delta2 files?


Nicolas
