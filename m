From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: CRLF problems with Git on Win32
Date: Fri, 11 Jan 2008 20:50:22 +0100
Message-ID: <20080111195022.GC29189@uranus.ravnborg.org>
References: <C3AC3E6F.10D42%jefferis@gmail.com> <alpine.LFD.1.00.0801101556380.3148@woody.linux-foundation.org> <7EAB1DA8-627D-455E-AA23-C404FDC615D9@zib.de> <alpine.LFD.1.00.0801110756260.3148@woody.linux-foundation.org> <D36EB89D-11A3-4EAF-BC1C-6100383FCBFC@zib.de> <alpine.LFD.1.00.0801110924380.3148@woody.linux-foundation.org> <930EC77A-73D1-4DDD-81D4-BF22B248FCB6@zib.de> <alpine.LFD.1.00.0801111005360.3148@woody.linux-foundation.org> <14E7B5D5-B1B8-4532-A471-106B14B912B8@zib.de> <alpine.LFD.1.00.0801111103420.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Gregory Jefferis <jefferis@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 20:50:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDPtz-0005wU-MZ
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 20:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761336AbYAKTuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 14:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760323AbYAKTuU
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 14:50:20 -0500
Received: from pasmtpb.tele.dk ([80.160.77.98]:56309 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759779AbYAKTuS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 14:50:18 -0500
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id 9A58FE303F3;
	Fri, 11 Jan 2008 20:50:16 +0100 (CET)
Received: by ravnborg.org (Postfix, from userid 500)
	id A949F580D2; Fri, 11 Jan 2008 20:50:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801111103420.3148@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70194>

On Fri, Jan 11, 2008 at 11:16:02AM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 11 Jan 2008, Steffen Prohaska wrote:
> > 
> > I already started to teach everyone the new "autocrlf=input" policy to 
> > avoid these questions.
> 
> I certainly don't think "autocrlf=input" is wrong. It might even be a 
> reasonable default on Unix, although I don't think it's nearly as obvious 
> as the Windows case. I wouldn't mind using it myself, for example, 
> although probably only because I know that for the stuff I work on it 
> simply cannot possibly ever do the wrong thing.
> 
> In fact, we had a case of bogus CRLF in one of the kernel documentation 
> files for some reason that we ended up fixing by hand. "autocflf=input" 
> would have fixed it (except in that case it wouldn't have, since it came 
> from the original kernel tree, long before crlf was an issue for git ;)
> 
> So I'd say that autocrlf=input is quite possibly a good idea on Unix in 
> general, but my gut feel is still that it's not a big enough issue to be 
> actually worth making a default change over. But there's absolutely 
> nothing wrong with having it as a policy at a company that has mixed Unix 
> and Windows machines.
> 
> (Every place I've ever been at, people who had a choice would never ever 
> develop under Windows, so I've never seen any real mixing - even when some 
> parts of the project were DOS/Windows stuff, there was a clear boundary 
> between the stuff that was actually done under Windows)

The reality I see is the other way around as common practice.
For people that has never tried a Linux box the barrier
is quite high and they prefer to stick with Windows.
Where I work today and in several other places I know of the
default choice is to work on Windows and use a Linux box only
for cross compilation.
This is common practice in many smaller embedded companies
and it is also these companies that like to be able to build
Linux on a Windows box.

	Sam
