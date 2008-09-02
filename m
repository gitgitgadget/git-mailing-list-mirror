From: Nicolas Pitre <nico@cam.org>
Subject: Re: non-monotonic index error
Date: Tue, 02 Sep 2008 19:04:27 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809021859030.23787@xanadu.home>
References: <9e4733910809021257v3012ec89l64b2bb412ac1ebbd@mail.gmail.com>
 <alpine.LFD.1.10.0809021625230.23787@xanadu.home>
 <9e4733910809021437w40eb1e2cv6379e5d199e234a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 01:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaewb-0008VV-7G
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 01:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbYIBXEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 19:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753364AbYIBXEd
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 19:04:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9850 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339AbYIBXEd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 19:04:33 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6L00EEBC3FOJN1@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 02 Sep 2008 19:04:27 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910809021437w40eb1e2cv6379e5d199e234a5@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94735>

On Tue, 2 Sep 2008, Jon Smirl wrote:

> On 9/2/08, Nicolas Pitre <nico@cam.org> wrote:
> > On Tue, 2 Sep 2008, Jon Smirl wrote:
> >
> >  > I pulled from linus, did stg rebase linus/master, git push digispeaker
> >  > and got these errors.
> >  >
> >  > Where's the problem, at my local machine or the digispeaker one? How
> >  > do I fix this?
> >  >
> >  > jonsmirl@terra:~/fs$ stg --version
> >  > Stacked GIT 0.14.3.195.g36a0
> >  > git version 1.5.6.GIT
> >  > Python version 2.5.2 (r252:60911, Jul 31 2008, 17:31:22)
> >  > [GCC 4.2.3 (Ubuntu 4.2.3-2ubuntu7)]
> >  > jonsmirl@terra:~/fs$
> >  >
> >  > [digispeaker]$ git --version
> >  > git version 1.4.4.4
> >
> >
> > This should be upgraded to at least version 1.4.4.5.  If this is a
> >  Debian distro and they didn't provide an updated package for git then
> >  please fill a bug with Debian.
> >
> 
> I just built the current version in my local directory, I'm still
> getting the monotonic error on push. Do I need to repack or something?

Probably because the version in your local directory is not the one used 
when the push is performed.  Still, on pushes it is the native git 
protocol which is used and in that case there should not be any index 
version issues.

Puzzled.


Nicolas
