From: David Kastrup <dak@gnu.org>
Subject: Re: Terminology question about remote branches.
Date: Sun, 05 Aug 2007 11:44:12 +0200
Message-ID: <85fy2yb9jn.fsf@lola.goethe.zz>
References: <854pjfin68.fsf@lola.goethe.zz>
	<20070804120243.GB9716@coredump.intra.peff.net>
	<85tzrfh3yg.fsf@lola.goethe.zz>
	<20070805092115.GA12507@coredump.intra.peff.net>
	<85myx6ba8n.fsf@lola.goethe.zz>
	<20070805093232.GC12507@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 05 11:44:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHcev-0006TZ-Fr
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 11:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297AbXHEJoW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 05:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753039AbXHEJoW
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 05:44:22 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:40910 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754105AbXHEJoW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 05:44:22 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id E20C0346640;
	Sun,  5 Aug 2007 11:44:20 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id D3D971143B8;
	Sun,  5 Aug 2007 11:44:20 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 97210312763;
	Sun,  5 Aug 2007 11:44:20 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id E49211C4F932; Sun,  5 Aug 2007 11:44:12 +0200 (CEST)
In-Reply-To: <20070805093232.GC12507@coredump.intra.peff.net> (Jeff King's message of "Sun\, 5 Aug 2007 05\:32\:32 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3858/Sun Aug  5 09:40:13 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54977>

Jeff King <peff@peff.net> writes:

> On Sun, Aug 05, 2007 at 11:29:12AM +0200, David Kastrup wrote:
>
>> The main question is why I can't find this explained in this manner in
>> the documentation.  Are you going to put it in yourself, or should I
>> attempt doing it?
>
> I guess because nobody complained it wasn't there before. :) Some of the
> information is a bit under-the-hood for most end-users, but obviously in
> your case the lack of information was creating confusion about the
> terms.
>
> Why don't you take a stab at updating the documentation (since you are
> the one who knows which parts were confusing you),

Well, one problem is that there simply _is_ no part of the
documentation where such an explanation would have a place.  It does
not fit in the man pages of git-branch/git-commit, it has some passing
relation to the repository layout explanation (even though the latter
should not be something that the user has to read and understand for
basic operation), it may have some place in the user manual, but may
be a bit technical/long for that.  Or one places it into another
isolated file and hopes that a user will stumble across it when in
need of the information.

Hm.  Probably the usermanual is the best option in the current scheme
of things.

> and I will be more than happy to help with making sure the changes
> are accurate.

Thanks.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
