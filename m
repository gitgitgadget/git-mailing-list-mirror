From: David Kastrup <dak@gnu.org>
Subject: Re: Terminology question about remote branches.
Date: Sun, 05 Aug 2007 14:12:04 +0200
Message-ID: <85fy2y89kb.fsf@lola.goethe.zz>
References: <854pjfin68.fsf@lola.goethe.zz>
	<20070804092933.aaec6d52.seanlkml@sympatico.ca>
	<85ejijgzzg.fsf@lola.goethe.zz>
	<20070805100532.GG12507@coredump.intra.peff.net>
	<85172807-B7EB-47DD-813E-FAF5894E1190@zib.de>
	<20070805110200.GA18083@coredump.intra.peff.net>
	<85tzre8b4w.fsf@lola.goethe.zz>
	<20070805115208.GA19734@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 05 14:12:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHeyF-0003HW-Aj
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 14:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755709AbXHEMMS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 08:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbXHEMMS
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 08:12:18 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:58469 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754583AbXHEMMR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 08:12:17 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 644D53366DD;
	Sun,  5 Aug 2007 14:12:16 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 51D1F23D2D9;
	Sun,  5 Aug 2007 14:12:16 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id DA4062BAA23;
	Sun,  5 Aug 2007 14:12:15 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id A54821C3D500; Sun,  5 Aug 2007 14:12:05 +0200 (CEST)
In-Reply-To: <20070805115208.GA19734@coredump.intra.peff.net> (Jeff King's message of "Sun\, 5 Aug 2007 07\:52\:08 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3859/Sun Aug  5 11:16:51 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55003>

Jeff King <peff@peff.net> writes:

> On Sun, Aug 05, 2007 at 01:38:07PM +0200, David Kastrup wrote:
>
>> > I believe the --track setup uses the tracking branches to figure out
>> > which remote/branch combo to track. To do it without a remote tracking
>> > branch, you would have to add the lines to your .git/config manually.
>> 
>> Fascinating, really fascinating.  Is there actually _anybody_ who
>> would not revert to phrases like "I believe" when describing git's
>> interaction with remote branches?
>
> By "I believe", I meant "I am pretty sure this is the way it is
> implemented, but I have better things to do than read through
> builtin-branch.c right now, so please don't take this as gospel and go
> read the code yourself."

Well, that is pretty much exactly what I find fascinating: that the
behavior is arbitrary and undocumented enough that one can't deduce it
either by logic or by recollection or by documentation, but just by
reading the code.

Usually code is supposed to implement a design, but here it seems
rather like the design, if there is any, is to be abstracted from the
code.

Maybe I get fascinated too easily.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
