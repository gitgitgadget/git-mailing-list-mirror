From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 01:42:05 +0200
Message-ID: <85abttwa7m.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<Pine.LNX.4.64.0707180135200.14781@racer.site>
	<858x9ez1li.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
	<vpq4pk1vf7q.fsf@bauges.imag.fr>
	<alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
	<85644hxujp.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 01:42:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBJAH-0002Yy-76
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 01:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbXGRXmM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 19:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbXGRXmL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 19:42:11 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:49217 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936783AbXGRXmI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 19:42:08 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id E01CD27B577;
	Thu, 19 Jul 2007 01:42:06 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id D274628EBD3;
	Thu, 19 Jul 2007 01:42:06 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-086-214.pools.arcor-ip.net [84.61.86.214])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id B1E5C35E5AC;
	Thu, 19 Jul 2007 01:42:06 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id B82E71C3ACCF; Thu, 19 Jul 2007 01:42:05 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> (Linus Torvalds's message of "Wed\, 18 Jul 2007 16\:16\:26 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3696/Wed Jul 18 14:56:36 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52912>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Gaah.
>
> I'm a damn softie (and soft in the head too, for writing the code).
>
> Ok, here's a trivial patch to start the ball rolling. I'm really not 
> interested in taking this patch any further personally, but I'm hoping 
> that maybe it can make somebody else who is actually _interested_ in 
> trackign empty directories (hint hint) decide that it's a good enough 
> start that they can fill in the details.

Well, kudos.  Together with the analysis from Junio, this seems like a
good start.  Would you have any recommendations about what stuff one
should really read in order to get up to scratch about git internals?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
