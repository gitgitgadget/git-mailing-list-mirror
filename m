From: sean <seanlkml@sympatico.ca>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Thu, 23 Mar 2006 17:05:15 -0500
Message-ID: <BAYC1-PASMTP029991B795201E8474F772AEDE0@CEZ.ICE>
References: <20060322133337.GU20746@lug-owl.de>
	<Pine.LNX.4.64.0603221517210.26286@g5.osdl.org>
	<Pine.LNX.4.64.0603221607580.26286@g5.osdl.org>
	<44223B90.3040500@zytor.com>
	<1143128751.6850.35.camel@neko.keithp.com>
	<Pine.LNX.4.64.0603230758260.26286@g5.osdl.org>
	<BAYC1-PASMTP0912D2287AB923F3338969AEDE0@CEZ.ICE>
	<Pine.LNX.4.64.0603231134160.26286@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: keithp@keithp.com, hpa@zytor.com, jbglaw@lug-owl.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 23:08:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMXy8-0000f6-85
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 23:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWCWWHl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 17:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWCWWHl
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 17:07:41 -0500
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:12737 "EHLO
	BAYC1-PASMTP02.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932474AbWCWWHk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 17:07:40 -0500
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 23 Mar 2006 14:07:38 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 8ACF6644C28;
	Thu, 23 Mar 2006 17:07:37 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Message-Id: <20060323170515.3612dc61.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0603231134160.26286@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 23 Mar 2006 22:07:39.0095 (UTC) FILETIME=[32E44670:01C64EC6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 23 Mar 2006 12:38:33 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> Actually, as far as I can tell, git already has a hell of a lot more 
> porcelain than pretty much any non-IDE type traditional SCM. Certainly 
> more than CVS.
> 
> Yeah, I'm not counting things like Eclipse etc. I'm talking about "plain 
> SCM" environments, ie just basic SVN or CVS. What are we missing in that 
> department? (The only thing I can think of is a diff colorizer, which some 
> prople seem to really want).

Yeah, i was thinking more along the lines of the way cogito handles
commit message editing for example, where you can change which files
are committed by editing the file list in place.  Maybe the colorized
git log viewer would be worth pulling into core as well, etc.

It's been a long time since i've looked at cogito but perhaps there
are other things in it that have proven useful and deserve to 
be pushed into core.

I guess my original comment was made because I always cringe when
i see git described as "plumbing" and only having porcelain-"ish"
commands included.

Sean
