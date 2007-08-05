From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sun, 05 Aug 2007 12:20:32 +0200
Message-ID: <851weib7v3.fsf@lola.goethe.zz>
References: <46B3F762.1050306@midwinter.com>
	<7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net>
	<46B418AA.4070701@midwinter.com>
	<20070804091249.GA17821@uranus.ravnborg.org>
	<46B45B1E.5020104@midwinter.com> <85zm17h4pn.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708040954320.5037@woody.linux-foundation.org>
	<85myx7dwb3.fsf@lola.goethe.zz>
	<20070805094247.GE12507@coredump.intra.peff.net>
	<85abt6b91w.fsf@lola.goethe.zz>
	<20070805095928.GA15949@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Grimm <koreth@midwinter.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ismail D?nmez <ismail@pardus.org.tr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 05 12:20:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHdE8-0005HQ-5s
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 12:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755392AbXHEKUp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 06:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754335AbXHEKUp
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 06:20:45 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:51779 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752169AbXHEKUo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 06:20:44 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 5036F135A8;
	Sun,  5 Aug 2007 12:20:43 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id 3E2345BD69;
	Sun,  5 Aug 2007 12:20:43 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id E56B8312765;
	Sun,  5 Aug 2007 12:20:42 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id BFF351C3D500; Sun,  5 Aug 2007 12:20:33 +0200 (CEST)
In-Reply-To: <20070805095928.GA15949@coredump.intra.peff.net> (Jeff King's message of "Sun\, 5 Aug 2007 05\:59\:28 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3858/Sun Aug  5 09:40:13 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54986>

Jeff King <peff@peff.net> writes:

> On Sun, Aug 05, 2007 at 11:54:51AM +0200, David Kastrup wrote:
>
>> >> (info "(gcc) Extended Asm")
>> >> 
>> >> and when you are reading mail in Emacs, you can click on that line
>> >> and get to the respective page in a manual comprising hundreds of
>> >> pages.
>> >
>> > Ugh. A documentation referencing system that works only in one
>> > particular editor,
>> 
>> That works in readers of the info format.  Do HTML references work
>> outside of HTML readers?
>
> I'm not talking about the _format_, I'm talking about the _referencing
> system_. In other words, because URLs are a standard, there are
> thousands of programs which recognize them and can find the resource
> they mention (which in turn, may spawn an info reader, an html reader,
> or some other interpreter).

Well, just for kicks I let firefox loose on

info:gcc#Extended Asm

It passed this off to the GNOME help browser, which displayed
"Loading...", used up 4 seconds of CPU time and 100M of memory, and
then hanged itself with a spinning cursor.

Interesting.  Starting the help browser manually and typing the URL
in, however, works.  It just seems to suicide when firefox tells it
about URLs.

> What software is going to recognize (info "(gcc) Extended Asm") in
> your email and realize that it's a reference to another document?
> None, except emacs.

Sure.  So use the above syntax.

> Though I don't especially like the info format or readers, my
> argument here isn't against it. It is against the feature you
> mentioned being a substantial benefit, since a large part of the
> world isn't reading their email in emacs.

So write it as a URL, if you want to.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
