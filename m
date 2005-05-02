From: Paul Jakma <paul@clubi.ie>
Subject: Re: [PATCH] add git.spec and adapt Makefile for RPM build
Date: Mon, 2 May 2005 20:06:50 +0100 (IST)
Message-ID: <Pine.LNX.4.62.0505022005200.14200@sheen.jakma.org>
References: <200505021858.j42Iw4M1029427@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Chris Wright <chrisw@osdl.org>, Kay Sievers <kay.sievers@vrfy.org>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon May 02 21:03:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSgAW-0001x3-9d
	for gcvg-git@gmane.org; Mon, 02 May 2005 21:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVEBTH0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 15:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVEBTH0
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 15:07:26 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:9858 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S261697AbVEBTHT
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 May 2005 15:07:19 -0400
Received: from sheen.jakma.org (sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id j42J6llg029689;
	Mon, 2 May 2005 20:06:54 +0100
X-X-Sender: paul@sheen.jakma.org
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200505021858.j42Iw4M1029427@laptop11.inf.utfsm.cl>
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
X-Virus-Scanned: ClamAV 0.83/861/Sat Apr 30 10:28:52 2005 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2 May 2005, Horst von Brand wrote:

> And yes, I've seen quite a few packages autogenerating the spec 
> file. As a result, you /can't/ build the package from pristine 
> sources, you have to unpack and configure to get enough for 
> building. For me that just isn't acceptable, as it completely 
> misses the point of RPM.

I think maybe you're missing the point of what is sometimes known as 
a 'make dist' target. (eg in autoconf type build systems).

> (You can go "rpmbuild -ta whatever-2.3.1.tar.bz2" if the tarball is set up
> correctly, your idea prevents that).

Then the tarball wasn't of distributable (ie end-user buildable) 
source.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
"Now this is a totally brain damaged algorithm.  Gag me with a smurfette."
 		-- P. Buhr, Computer Science 354
