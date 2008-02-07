From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Thu, 7 Feb 2008 21:14:45 +0100
Message-ID: <20080207201445.GD18497@mail-vs.djpig.de>
References: <pan.2008.02.04.18.25.26@progsoc.org> <20080205050741.GA4624@coredump.intra.peff.net> <pan.2008.02.06.21.56.35@progsoc.org> <20080207042332.GA7632@sigill.intra.peff.net> <pan.2008.02.07.10.15.05@progsoc.org> <20080207142322.GC18497@mail-vs.djpig.de> <alpine.LFD.1.00.0802071039010.2883@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 21:15:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JND9l-0001lD-UZ
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 21:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933813AbYBGUO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 15:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934511AbYBGUO6
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 15:14:58 -0500
Received: from pauli.djpig.de ([78.46.38.139]:48171 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934502AbYBGUO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 15:14:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id CD42890070;
	Thu,  7 Feb 2008 21:14:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tkVU8bltVWgJ; Thu,  7 Feb 2008 21:14:46 +0100 (CET)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id 8625890051;
	Thu,  7 Feb 2008 21:14:46 +0100 (CET)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.63)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1JND8w-0002jR-3s; Thu, 07 Feb 2008 21:14:46 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802071039010.2883@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72996>

On Thu, Feb 07, 2008 at 10:42:15AM -0800, Linus Torvalds wrote:
> On Thu, 7 Feb 2008, Frank Lichtenheld wrote:
> > 
> > Since git has no OpenSSL link exception the resulting binary wouldn't be
> > distributable AFAIK.
> 
> For crazy people who think that regular libraries can change the copyright 
> status of a program (not so), you can always decide to build without 
> OpenSSL and use the included Mozilla-based SHA1 implementation for git.
> 
> Performance will probably suffer, and maybe something else breaks too (I 
> doubt many people test the build that way very often), but I assume Debian 
> people don't care.
> 
> After all, if you're a Debian person, it's likely more important to you to 
> be difficult and anal and argue about theoretical license details than 
> actually be *usable*.

Easy to say for someone who only distributes source code... (AFAIK
anyway)

Anyway, since Debian will not change its opinion about this, my answer
was in the context of the question obviously useful. Whether it was
generally correct is probably off-topic here.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
