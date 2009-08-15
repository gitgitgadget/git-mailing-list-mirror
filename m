From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linus' sha1 is much faster!
Date: Sat, 15 Aug 2009 13:23:41 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908151315400.3162@localhost.localdomain>
References: <4A85F270.20703@draigBrady.com>  <3e8340490908151302y33a97d50t38ad0a8a788f1cee@mail.gmail.com> <43d8ce650908151312o6a43416el27965c4b0ab8d83d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bryan Donlan <bdonlan@gmail.com>,
	=?ISO-8859-15?Q?P=E1draig_Brady?= <P@draigbrady.com>,
	Bug-coreutils@gnu.org, Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 22:24:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McPnZ-0006oc-K1
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 22:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbZHOUYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 16:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbZHOUYJ
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 16:24:09 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58771 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752100AbZHOUYI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Aug 2009 16:24:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7FKNfg1008311
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 15 Aug 2009 13:23:43 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7FKNfrl007909;
	Sat, 15 Aug 2009 13:23:41 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <43d8ce650908151312o6a43416el27965c4b0ab8d83d@mail.gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126026>



On Sat, 15 Aug 2009, John Tapsell wrote:

> 2009/8/15 Bryan Donlan <bdonlan@gmail.com>:
> > coreutils is licensed under GPLv3, and git under GPLv2 (only), so
> > you'd need permission from all contributors to the implementation in
> > order to relicense under GPLv3. A quick grep of the history suggests
> > these contributors to be:
> 
> X11 also requires a fast SHA1 implementation.  It uses this to check
> if two pixmaps are the same.  So it would be really nice to relicense
> under a liberal enough license that xorg can use it.

I'm personally ok with retaining the mozilla-sha1 license.

There's not really anything _remaining_ of the mozilla code, but hey, I 
started from it. In retrospect I probably should have started from the PPC 
asm code that already did the blocking sanely - but that's a "20/20 
hindsight" kind of thing.

Plus hey, the mozilla code being a horrid pile of crud was why I was so 
convinced that I could improve on things. So that's a kind of source for 
it, even if it's more about the motivational side than any actual 
remaining code ;)

That said, I don't know if the MPL is ok for X11. I've not looked at 
compatibility issues with MPL. For git, we could just ignore the MPL, 
since the GPLv2 was acceptable regardless of it.

			Linus
