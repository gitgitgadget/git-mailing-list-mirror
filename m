From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 19:17:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003181909180.31128@xanadu.home>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
 <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
 <46a038f91003181536ib3b74f8o40603a4cee13d62b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 00:18:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsOyV-0001fo-BQ
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 00:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544Ab0CRXRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 19:17:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34820 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab0CRXRr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 19:17:47 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KZI000RZ3DMXN00@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Mar 2010 19:17:46 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <46a038f91003181536ib3b74f8o40603a4cee13d62b@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142534>

On Thu, 18 Mar 2010, Martin Langhoff wrote:

> On Thu, Mar 18, 2010 at 1:27 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > Even shorter version: NO.
> 
> One thing we all forgot to mention here is that even if it was a good
> idea (which it is not), implementing it means a flag day: changing in
> the pack format, wire protocol and APIs, messing up with compatibility
> with users of pre-flag-day git, and rippling out to all the GUIs,
> frontends and integration scripts out there.

And nobody yet mentioned what should happen when someone sends a patch 
by email.  Most commits in git.git originated from a patch sent via 
email.  Should we start pasting UUIDs in the email body?  What if the 
cut & paste was quickly done and the UUID is missing a character or two?  
Because this does happen.  And because this UUID thing is supposed to be 
a perfect identity representation then we'll need a .uuidmap to correct 
such mistakes of course.

Better improve on the existing .mailmap instead.


Nicolas
