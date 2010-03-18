From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 19:34:32 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003181930230.31128@xanadu.home>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
 <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
 <46a038f91003181536ib3b74f8o40603a4cee13d62b@mail.gmail.com>
 <alpine.LFD.2.00.1003181909180.31128@xanadu.home>
 <9e4733911003181626t7d143903mbc5737ff2fa5100f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 00:34:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsPEr-0007S0-29
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 00:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463Ab0CRXee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 19:34:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59914 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab0CRXed (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 19:34:33 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KZI00F5X45K7Z50@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Mar 2010 19:34:32 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733911003181626t7d143903mbc5737ff2fa5100f@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142536>

On Thu, 18 Mar 2010, Jon Smirl wrote:

> If anyone is interested I can send them a .mailmap that fixes a lot of
> the problems in the kernel tree. It's two years old so it will need
> updating.

Please just make a patch with it, and post it to lkml and CC Linus and 
Andrew Morton.  Repost a month later if no one picked it up.

I think that 'git log' should really consider the .mailmap by default.  
Otherwise what's the point?   The only time when .mailmap should not be 
considered is when using --pretty=raw or when explicitly told not to.


Nicolas
