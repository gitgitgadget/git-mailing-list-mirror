From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git tree for old kernels from before the current tree
Date: Mon, 23 Jul 2007 13:10:53 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707231250390.3607@woody.linux-foundation.org>
References: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com>
 <Pine.LNX.4.64.0707222257540.32367@fbirervta.pbzchgretzou.qr>
 <20070722211314.GA13850@linux-sh.org> <Pine.LNX.4.64.0707222344540.32367@fbirervta.pbzchgretzou.qr>
 <Pine.LNX.4.64.0707230000170.32367@fbirervta.pbzchgretzou.qr>
 <46A3D5EA.2050600@zytor.com> <alpine.LFD.0.999.0707230950340.3607@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707231343350.6355@xanadu.home>
 <alpine.LFD.0.999.0707231057480.3607@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707231432560.6355@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Jan Engelhardt <jengelh@computergmbh.de>,
	Paul Mundt <lethal@linux-sh.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 22:11:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID4G1-0006G4-2M
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 22:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932927AbXGWULt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 16:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765719AbXGWULs
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 16:11:48 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43023 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765540AbXGWULr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 16:11:47 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6NKB0tY020718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jul 2007 13:11:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6NKAr61009417;
	Mon, 23 Jul 2007 13:10:54 -0700
In-Reply-To: <alpine.LFD.0.999.0707231432560.6355@xanadu.home>
X-Spam-Status: No, hits=-2.722 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.14__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53469>



On Mon, 23 Jul 2007, Nicolas Pitre wrote:
> 
> What is missing is:
> 
>  - v0.02 sources

I think this really is gone. 0.03 was such an improvement on 0.02 that I 
think what happened was that I literally removed 0.02 (hey, it wasn't 
historically interesting at the time!). It's not the first time people 
have wondered about it.

0.03 was the first version where you could actually do things under Linux, 
and I think I could compile etc. I *think* it was released pretty close 
after 0.02, which made 0.02 appear even more flawed and a brown-paper-bag 
release.

>  - v0.10 announcement

Hmm. That one would be interesting, since the reason for the 0.03->0.10 
jump was that I was getting so happy with how it was actually working for 
me (ie able to compile itself under itself). But I don't see it, and it's 
not on google in the comp.os.minix archives either, afaik.

>  - v0.96 sources

Hmm. Odd. Might be another case of "0.96a was released as a 
brown-paper-bag fix for 0.96, and the latter hidden in shame".

Stupid bugs only appear endearing in retrospect.

>  - v0.99.12 announcement

Well, the 0.99.12 announcement is found by google.

	http://groups.google.com/group/comp.os.linux.announce/browse_thread/thread/8a19289f68a4af35/fe433c9df4b382a5?lnk=st&q=&rnum=1#fe433c9df4b382a5

In general, google groups (search by date and author, and make the group 
be something like *linux*) is good, I found the above on the first try.

>  - sources for v0.99.13{abcdefghij} (got k, don't know where the serie 
>    ends) as well as announcements for all of them
> 
>  - all announcements for v0.99.14{a-z} except for pl14r
> 
>  - announcements for pl15c to pl15j, 1.0-pre1, and ALPHA-1.0.

Many of those might not have merited announcements. At some point I was 
just making tar-balls a few days apart, to let people track it.

> Otherwise the archive appears fairly complete with almost 3 years of 
> Linux development history captured in a 3MB pack file.

Heh, nice. Those early versions are all smaller than the patch set we 
generate in a day these days :)

		Linus
