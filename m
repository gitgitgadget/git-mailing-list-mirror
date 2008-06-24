From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-clone works with ssh but not with http/https/git
Date: Tue, 24 Jun 2008 13:10:32 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806241305150.19665@iabervon.org>
References: <ce513bcc0806240415h669d1725uf7b6e495995ab459@mail.gmail.com>  <1214306517.6441.10.camel@localhost>  <ce513bcc0806240445x6d00323g303f218504d2df53@mail.gmail.com>  <A3460448-8007-4E02-AC20-85C1A8C85786@manchester.ac.uk> 
 <ce513bcc0806240653i45044297t3b963940c5b3daf0@mail.gmail.com>  <BC8F2A2A-9817-401B-BAC3-F36ED42976E5@manchester.ac.uk> <ce513bcc0806240745l365b2d22ga007deb01a93e4b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robert Haines <rhaines@manchester.ac.uk>,
	Matthias Kestenholz <mk@spinlock.ch>, git@vger.kernel.org
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 19:11:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBC3I-0001ri-P5
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 19:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339AbYFXRKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 13:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753124AbYFXRKe
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 13:10:34 -0400
Received: from iabervon.org ([66.92.72.58]:38846 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753699AbYFXRKd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 13:10:33 -0400
Received: (qmail 30910 invoked by uid 1000); 24 Jun 2008 17:10:32 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Jun 2008 17:10:32 -0000
In-Reply-To: <ce513bcc0806240745l365b2d22ga007deb01a93e4b6@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86088>

On Tue, 24 Jun 2008, Erez Zilber wrote:

> BTW - I'm currently running git-daemon in the following way:
> 
> sudo git-daemon --base-path=/pub/git/ --export-all
> 
> Is there any advantage to run it through xinetd? How do you run it?

You probably want to run it from something that init runs, or you'll have 
to figure it out again when you reboot the server in a while. So you 
either want a suitable init script (Gentoo, for example, has one in their 
git package), or to run it through xinetd (which you almost certainly have 
an init script for).

	-Daniel
*This .sig left intentionally blank*
