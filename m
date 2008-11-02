From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Sat, 1 Nov 2008 18:36:36 -0700
Message-ID: <20081102013636.GF15463@spearce.org>
References: <alpine.DEB.1.10.0810311738100.5851@asgard.lang.hm> <20081101010011.GG14786@spearce.org> <alpine.DEB.1.10.0810311802360.5851@asgard.lang.hm> <20081101010824.GE29036@artemis.corp> <alpine.LFD.2.00.0810312121000.13034@xanadu.home> <20081101014336.GI14786@spearce.org> <alpine.LFD.2.00.0810312150200.13034@xanadu.home> <20081101225714.GD15463@spearce.org> <d411cc4a0811011726h1fb1ad0ct5c37af753940f4a4@mail.gmail.com> <d411cc4a0811011807g229f8becs9f411d6e19fb6c12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Pierre Habouzit <madcoder@debian.org>, david@lang.hm,
	git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 02:45:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwS2J-00046r-1J
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 02:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbYKBBgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 21:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752317AbYKBBgh
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 21:36:37 -0400
Received: from george.spearce.org ([209.20.77.23]:48765 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbYKBBgh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 21:36:37 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 726713835F; Sun,  2 Nov 2008 01:36:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <d411cc4a0811011807g229f8becs9f411d6e19fb6c12@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99797>

Scott Chacon <schacon@gmail.com> wrote:
> > On Sat, Nov 1, 2008 at 3:57 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> >>
> >> Headers updated.  Its now GPL+gcc library exception.
> 
> I personally would rather see it BSD or something more permissive so
> that no human has to waste even a second of their valuable time
> figuring out if they can work with it or not, but I understand that
> many people here are much more protective of their code.  I simply
> think that LGPL is a much more widely used and understood compromise
> that affords nearly the same protectionism.

Apparently BSD won't fly, as you have already seen on the list.

If we did put the library under a BSD license we'd lose some core
contributors.  Or they at least wouldn't improve the library code,
even if git.git linked to it in the future.  I don't want to lose
these folks.

IANAL, but from what I can tell the main difference between LGPL
and GPL+"gcc library exception" is that the LGPL requires that
the end-user must be able to relink the derived executable with
their own replacement library.  The GPL+"gcc library exception"
makes no such requirement.

If you read the exception clause it practically makes the library
even easier to use commerically than the BSD license does, however
modifications to the library sources must still be distributed.

Isn't that actually somewhat close to the Mozilla Public License?

-- 
Shawn.
