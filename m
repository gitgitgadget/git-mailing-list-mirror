From: Pieter de Bie <pieter@frim.nl>
Subject: Re: hosting git on a nfs
Date: Fri, 14 Nov 2008 01:59:15 +0100
Message-ID: <D0569391-2DB2-46A1-9355-769FF1B1DE1B@frim.nl>
References: <200811121029.34841.thomas@koch.ro> <20081112173651.GA9127@linode.davidb.org> <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org> <loom.20081113T174625-994@post.gmane.org> <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org> <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	James Pickens <jepicken@gmail.com>,
	Bruce Fields <bfields@fieldses.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 02:00:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0n3N-0001Mw-IN
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 02:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbYKNA7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 19:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbYKNA7h
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 19:59:37 -0500
Received: from frim.nl ([87.230.85.232]:33566 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751706AbYKNA7h (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2008 19:59:37 -0500
Received: from s5591931c.adsl.wanadoo.nl ([85.145.147.28] helo=[192.168.1.10])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pieter@frim.nl>)
	id 1L0n1v-0006ou-Vf; Fri, 14 Nov 2008 01:59:24 +0100
In-Reply-To: <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100941>


On Nov 14, 2008, at 1:38 AM, Linus Torvalds wrote:

> Ok, both you and Julian do seem to be getting a nice speedup from  
> this.
>
> I'll clean it up a bit and make a less hacky version. And I'll try  
> to make
> it work for "git status" and friends too.

I have two more datapoints.

The first is OS X 10.5 on a local HFS repository. git.git goes down  
from ~70 to ~63ms and mozilla's repository (30000) files goes from  
~350ms to ~230ms (yeah, HFS sucks).

Using AFP for the same repositories, the first goes down from ~80 to  
~67ms, the second from ~70 seconds to ~50 seconds, which is a nice  
speedup :)

- Pieter
