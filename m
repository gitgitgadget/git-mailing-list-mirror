From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Mon, 28 Jul 2008 03:29:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0807280308120.6791@localhost.localdomain>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com> 
 <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org> 
 <200807260512.40088.zippel@linux-m68k.org> 
 <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org> 
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain> 
 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> 
 <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
 <46a038f90807271625x35c561fdv6dc6b2c312f45fa1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 03:30:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNHZY-0000mP-Qd
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 03:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbYG1B3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 21:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbYG1B3s
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 21:29:48 -0400
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:4151 "EHLO
	smtp-vbr12.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbYG1B3r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 21:29:47 -0400
Received: from squid.home (linux-m68k.xs4all.nl [82.95.193.92])
	(authenticated bits=0)
	by smtp-vbr12.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6S1TdvV000241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Jul 2008 03:29:39 +0200 (CEST)
	(envelope-from zippel@linux-m68k.org)
X-X-Sender: roman@localhost.localdomain
In-Reply-To: <46a038f90807271625x35c561fdv6dc6b2c312f45fa1@mail.gmail.com>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90394>

Hi,

On Mon, 28 Jul 2008, Martin Langhoff wrote:

> On Mon, Jul 28, 2008 at 11:14 AM, Roman Zippel <zippel@linux-m68k.org> wrote:
> > Why are you dismissing what I wrote without even giving it a second
> > thought? I didn't bother with the initial example, because it's so
> > simple, that it's no real challenge.
> 
> I can't speak for anyone else, but you do have to keep in mind that a
> solution to this has to be rather fast - and I mean fast in git terms,
> not in scripting-language-fast terms.

You also have to keep in mind, that I haven't really hacked git before, so 
I'm just trying to do something with the data I can somehow extract from 
it. I seriously didn't thought that anyone wouldn't understand that the 
code example was just a proof of concept.

> That you can do it Ruby - and I may be able to do it Perl - has little
> bearing on what can be done inside the git log machinery with a small
> performance penalty.

It also has to do with correctness, is performance more important than 
correctness? 
Part of the problem is, what is the correct history, as which it should be 
displayed via the various interfaces by default.

bye, Roman
