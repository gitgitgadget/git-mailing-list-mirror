From: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@swipnet.se>
Subject: Re: Implementing stat() with FindFirstFile()
Date: Mon, 30 Mar 2009 00:48:03 +0200
Message-ID: <20090329224803.GD27249@jeeves.jpl.local>
References: <20090321154738.GA27249@jeeves.jpl.local> <200903212055.15026.j6t@kdbg.org> <20090324215416.GB27249@jeeves.jpl.local> <49CB2BA5.1070100@viscovery.net> <20090326213907.GC27249@jeeves.jpl.local> <alpine.DEB.1.00.0903270320020.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 30 00:49:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo3p1-0007uO-6H
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 00:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbZC2WsM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Mar 2009 18:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbZC2WsM
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 18:48:12 -0400
Received: from proxy3.bredband.net ([195.54.101.73]:49652 "EHLO
	proxy3.bredband.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbZC2WsL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 18:48:11 -0400
Received: from ironport.bredband.com (195.54.101.120) by proxy3.bredband.net (7.3.139)
        id 49CB852D001C0C7E for git@vger.kernel.org; Mon, 30 Mar 2009 00:48:08 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuAwAAaXz0lT4/BMPGdsb2JhbACBUYdOjFoBAQEBHhcLsBmDegY
X-IronPort-AV: E=Sophos;i="4.38,442,1233529200"; 
   d="scan'208";a="501528070"
Received: from ua-83-227-240-76.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.240.76])
  by ironport1.bredband.com with ESMTP; 30 Mar 2009 00:48:07 +0200
Received: from jeeves.jpl.local (jeeves.jpl.local [192.168.7.3])
	by elwood.jpl.local (Postfix) with ESMTP id 03BF5422AF;
	Mon, 30 Mar 2009 00:48:06 +0200 (CEST)
Received: by jeeves.jpl.local (Postfix, from userid 100)
	id 9E2763C2D; Mon, 30 Mar 2009 00:48:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903270320020.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115047>

On Friday, March 27, 2009 at 03:25 CET,
     Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Magnus, it is the official policy to reply-to-all on this list.  This
> has been mentioned in the past quite often, and it will be mentioned
> in the future, too.

Sorry, I was not aware. Doesn't seem to have been mentioned in the last
month or so. Perhaps it could be included in the list introduction
message? All people obviously won't read it, but some will.

> You actually forced me to manually look up and re-add Hannes' address=
=2E
> I do not appreciate having to waste my time like that.
>
> If that sounds negative, please understand that I am used to the ways
> of this list, and when I am annoyed by somebody not fitting in, then
> it is not totally _my_ mistake.

A plain "please use reply all" would've sufficed.

> On Thu, 26 Mar 2009, Magnus B=E4ck wrote:
>
> > I'd be very surprised if ZwQueryDirectoryFile() hasn't always been
> > around (I just verified ntdll.dll from NT 4.0), so that's not a
> > worry. Don't know why MSDN reports it as introduced in XP.
>
> As the current maintainer of msysGit, I refuse to have something in
> the installer I ship that relies on not-at-all guaranteed interfaces.

Although I do appreciate the importance of guaranteed interfaces,
I am also pragmatic. An incompatible change in ntdll.dll would break
vast amounts of programs, including cygwin. There is a lot to be said
about Microsoft and their APIs, but I don't think they have a habit of
changing ABIs or function semantics for userland libraries that have
been around for 15 years.

> > All right, I'll see if I can find time to take a look at this. I
> > just wanted to check that it wasn't a project policy or whatever
> > to bypass Win32.
>
> You can do whatever you want... This is Open Source.
>
> However, I will try to stay with the officially supported functionali=
ty,
> even if that makes msysGit slower -- Windows will never reach the
> performance levels of Linux anyway.

Okay, thanks. Just like you I hate wasting time, in my case with patche=
s
that'll be refused.

--=20
Magnus B=E4ck
baeck@swipnet.se
