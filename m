From: Nicolas Pitre <nico@cam.org>
Subject: Re: Linus' sha1 is much faster!
Date: Sun, 16 Aug 2009 21:55:39 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908162151180.6044@xanadu.home>
References: <4A85F270.20703@draigBrady.com>
 <3e8340490908151302y33a97d50t38ad0a8a788f1cee@mail.gmail.com>
 <43d8ce650908151312o6a43416el27965c4b0ab8d83d@mail.gmail.com>
 <alpine.LFD.2.01.0908151315400.3162@localhost.localdomain>
 <alpine.LFD.2.01.0908151336530.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: John Tapsell <johnflux@gmail.com>,
	Bryan Donlan <bdonlan@gmail.com>,
	=?ISO-8859-15?Q?P=E1draig_Brady?= <P@draigbrady.com>,
	Bug-coreutils@gnu.org, Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Kocher <paul@paulkocher.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 03:56:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McrSC-0005NU-9j
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 03:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756163AbZHQBz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 21:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755353AbZHQBz7
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 21:55:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12208 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231AbZHQBz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 21:55:58 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOI00GF800RL200@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 16 Aug 2009 21:55:40 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.01.0908151336530.3162@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126105>

On Sat, 15 Aug 2009, Linus Torvalds wrote:

> (Heh. Looking at that, I probably should move the 'size' field first, 
> since that would have different alignment rules, and the struct would be 
> more tightly packed that way, and initialize better).

I was about to suggest (i.e. post) a patch for that.  This is indeed a 
good idea.

> Afaik, none of the actual code remains (the mozilla SHA1 thing did the 
> wrong thing for performance even for just the final bytes, and did those a 
> byte at a time etc, so I rewrote even the trivial SHA1_Final parts).

Maybe a patch adding a proper header with the actual license would be a 
good idea too.


Nicolas
