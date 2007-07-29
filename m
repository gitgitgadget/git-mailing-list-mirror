From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Documentation/git-diff: remove -r from --name-status example
Date: Sun, 29 Jul 2007 10:23:08 +0200
Message-ID: <85r6mrzkib.fsf@lola.goethe.zz>
References: <20070729002427.GA1566@coredump.intra.peff.net>
	<alpine.LFD.0.999.0707281905050.3442@woody.linux-foundation.org>
	<20070729041159.GA5544@coredump.intra.peff.net>
	<alpine.LFD.0.999.0707282119010.3442@woody.linux-foundation.org>
	<7vbqdvolww.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 10:23:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF43u-00050n-Gl
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 10:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760302AbXG2IXe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 04:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760269AbXG2IXe
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 04:23:34 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:60017 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752018AbXG2IXc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 04:23:32 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 5425A303029;
	Sun, 29 Jul 2007 10:23:31 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 3684B23D2D9;
	Sun, 29 Jul 2007 10:23:31 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-015.pools.arcor-ip.net [84.61.17.15])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id B9C232A2AE2;
	Sun, 29 Jul 2007 10:23:29 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 5DEC41CFF95E; Sun, 29 Jul 2007 10:23:09 +0200 (CEST)
In-Reply-To: <7vbqdvolww.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat\, 28 Jul 2007 21\:48\:15 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3804/Sun Jul 29 06:09:31 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54093>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> One minor objection I do have is that, just as a matter of
> principle, in order to avoid setting precedence of making a
> fundamental semantics change in late -rc stage in the game, we
> should not swallow it.  I do not mind if this were clearly a
> good change.
>
> However, I think Jeff's patch always makes it recursive even
> when the user asks for --raw, which makes it inappropriate for
> inclusion whether before or after 1.5.3.

Personally, I think -r should be the default while one can use
--directory to switch it off.

Whether --raw should imply --directory might be a different question.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
