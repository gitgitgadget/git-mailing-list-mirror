From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: OT: data destruction classics (was: Re: Error converting from 1.4.4.1 to 1.5.0?)
Date: Thu, 15 Feb 2007 05:13:43 -0800
Message-ID: <f2b55d220702150513n3b6cfc37kc336b452155b5b94@mail.gmail.com>
References: <7vhctor78j.fsf@assigned-by-dhcp.cox.net>
	 <17875.30687.661794.512124@lisa.zopyra.com>
	 <Pine.LNX.4.64.0702141314440.20368@woody.linux-foundation.org>
	 <17875.33204.413186.355557@lisa.zopyra.com>
	 <Pine.LNX.4.64.0702141722410.1757@xanadu.home>
	 <17875.36879.872210.264473@lisa.zopyra.com>
	 <45D3B4E7.8050408@fs.ei.tum.de> <20070215021345.GB29732@spearce.org>
	 <Pine.LNX.4.64.0702141836510.20368@woody.linux-foundation.org>
	 <Pine.LNX.4.63.0702151103100.448@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>,
	"Bill Lear" <rael@zopyra.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 15 14:13:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHgQn-00043J-Ts
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 14:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbXBONNq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 08:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932712AbXBONNq
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 08:13:46 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:60563 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932711AbXBONNp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 08:13:45 -0500
Received: by ug-out-1314.google.com with SMTP id 44so147353uga
        for <git@vger.kernel.org>; Thu, 15 Feb 2007 05:13:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RLtTTRvSL/WyClA40iA018p58ru9OKE+GrGMenl8NSOaP5gnq4IpWd72RHgRsytz0rWi83/sxAe0911e/EH2pCQlVkjThIM4vLP8lMh2xSw2pOEKZx0uyJYwiegDQmzoHwkWPEIju/2+WU3gYK1lnw0l51gVeAHDTefwAFxFj70=
Received: by 10.114.200.2 with SMTP id x2mr951032waf.1171545223281;
        Thu, 15 Feb 2007 05:13:43 -0800 (PST)
Received: by 10.114.130.3 with HTTP; Thu, 15 Feb 2007 05:13:43 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702151103100.448@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39827>

Not quite in the same vein, but perhaps amusing to Silicon Valley veterans:

I worked for several years for a 64-bit processor + workstation vendor
that shall remain nameless.  There was this one guy in the other
building who built the kernels for the 64-bit UNIX variant that
shipped with US models.  He had a SunOS 4 box on his desk that
happened to be the only machine in the world where his magic
32-to-64-bit cross-compiler generated working kernels, for reasons no
one ever fully understood.  The external SCSI died one day, and either
there were no backups or they wouldn't restore cleanly.  I don't think
they ever shipped another kernel update.

I can't swear to the accuracy of that story, though; my mind was on
the million-dollar "high availability" NFS server deployment I was
swept up in.  The vendor never did get the electricals straight on the
shared SCSI bus, possibly because we had shelled out for redundant
power supplies via independent UPSes all the way out to the backup
generator, probably creating a gimongous ground loop.  Kept frying the
third-party SCSI cards that were the key to the whole system, and
scrambled the contents of the terabyte RAID more than once.  I don't
think those backups ever worked, either.  The whole kit got ripped out
after some months of chaos and replaced with in-house gear, which
never worked right either.

Somewhere along the way, I figured out that the whole company (a U.S.
subsidiary of a Japanese multinational) was a clever arbitrage of the
Japanese tax system.  As I understand it, they got tax credits for
foreign direct investment each quarter, then turned around and sent
most of the check back to the parent company to purchase custom DIMMs
at absurd prices, earning yet more tax credits for export in a
critical high-tech product sector.  They made a tidy profit at the
Japanese taxpayers' expense even if we accomplished nothing
whatsoever.

The dedicated chip design and verification team didn't seem to have
cottoned onto this, though, and went through literally dozens of spins
(using the parent's semiconductor manufacturing division, natch).
Their design simulated substantially correctly at the logic level
(nothing you couldn't work around in the compiler) from the beginning,
but actual fabrication exposed problem after problem in the cell
library associated with the parent company's recent process shrink.
(Naturally, the NRE sent back to the parent for each chip spin also
qualified for super-duper tax credits.)

By the time the similar processor division back in Japan went through
the same shrink, the cell library and design rule kinks were all
worked out.  So they got working silicon on the first spin where the
logic was correct (which was not, if I recall correctly, anything
close to the first spin; but they probably weren't charged NRE).
Guess which division took the fall?  Hint: the tax credits expired in
2001, and so did the US subsidiary.  They got another tax credit for
liquidation losses, of course.  Legend at the time had it that the
company had never had a break-even quarter in 11 years of existence,
and had burned more actual cash than any Silicon Valley startup of its
era.  (In retrospect the numbers don't appear to support the latter
claim.)

I got to do some fun stuff while I was there, though, including a
Frankenstein monster of an encrypted CVS transport that slotted SSLeay
into the GSSAPI interface intended for Kerberos.  (Given the choice of
Kerberizing the site or running our own CA for client certs, we picked
the latter.)  Although we had the source to Solaris, UnixWare, and
Windows NT all under one roof, the "secure" version control was not
for any of these.  It was reserved for the real crown-jewels-on-loan:
the source to the OpenBoot PROM.  Go figure.

Cheers,
- Michael
