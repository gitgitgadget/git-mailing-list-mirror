From: Robert Wohlrab <robert.wohlrab@gmx.de>
Subject: Re: diffstat and signoff in git-format-patch
Date: Sat, 12 Sep 2009 20:29:30 +0200
Message-ID: <200909122029.30220.robert.wohlrab@gmx.de>
References: <200909121713.13296.robert.wohlrab@gmx.de> <200909121717.57896.robert.wohlrab@gmx.de> <20090912181919.GA20561@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 12 20:29:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmXLg-0000Lh-6q
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 20:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640AbZILS3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 14:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754561AbZILS3P
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 14:29:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:45624 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754559AbZILS3O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 14:29:14 -0400
Received: (qmail invoked by alias); 12 Sep 2009 18:29:16 -0000
Received: from unknown (EHLO resul-server) [89.246.208.0]
  by mail.gmx.net (mp048) with SMTP; 12 Sep 2009 20:29:16 +0200
X-Authenticated: #15668376
X-Provags-ID: V01U2FsdGVkX1/WxfJ+i5fWNW7Kx/HY4xvdp+W1d1Nyqh2tyGXw09
	f/yJxZ/lM5R7lR
User-Agent: KMail/1.12.1 (Linux/2.6.31-rc5; KDE/4.3.1; x86_64; ; )
In-Reply-To: <20090912181919.GA20561@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128276>

> On Sat, Sep 12, 2009 at 05:17:57PM +0200, Robert Wohlrab wrote:
> > > Hi,
> > > I am currently trying to use git-format-patch in a script to generate
> > > files which must be in a special format. This means that I have to
> > > override also changes by users. This is as far as I can see suffix,
> > > signoff and some more. Most of the stuff works, but I cannot get away
> > > the signoff message as their is nothing like --no-signoff and the -p
> > > option which should be disable generation of diffstat doesn't do
> > > anything. How can I disable them anyway?
> > > git version 1.6.3.3
> >
> > And can i disable this "--\n1.6.3.3" at the end of the patch?
> 
> format-patch isn't very configurable in its output. Maybe you want to
> just do:
> 
>   git log -1 --pretty=email -p
> 
> instead (or if you want to tweak the format even further, try
> --pretty=format)?
Thanks. I am currently playing with it and i think that I can create what I 
want with it.
-- 
Robert Wohlrab
