From: Nicolas Pitre <nico@cam.org>
Subject: Re: fatal: serious inflate inconsistency
Date: Fri, 08 Jun 2007 12:15:48 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706081210130.12885@xanadu.home>
References: <20070608110536.GD2335@cip.informatik.uni-erlangen.de>
 <alpine.LFD.0.99.0706080931330.12885@xanadu.home>
 <20070608135054.GK2335@cip.informatik.uni-erlangen.de>
 <20070608153722.GL2335@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 18:15:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwh7x-0007Fi-Vx
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 18:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S969189AbXFHQPw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 12:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S969382AbXFHQPw
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 12:15:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44754 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966477AbXFHQPv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 12:15:51 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJB003FVRUCDU71@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 08 Jun 2007 12:15:49 -0400 (EDT)
In-reply-to: <20070608153722.GL2335@cip.informatik.uni-erlangen.de>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49483>

On Fri, 8 Jun 2007, Thomas Glanzmann wrote:

> Hello,
> 
> > I give it a try and come back to you. I am off the net for 1 hour.
> 
>         (tomcat-05) [/usr/src] git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>         Initialized empty Git repository in /usr/src/linux-2.6/.git/
>         remote: Generating pack...
>         remote: Done counting 496911 objects.
>         remote: Deltifying 496911 objects...
>         remote:  100% (496911/496911) done
>         Indexing 496911 objects...
>         remote: Total 496911 (delta 401539), reused 493712 (delta 398653)
>         100% (496911/496911) done
>         Resolving 401539 deltas...
>         fatal: serious inflate inconsistency
>         fatal: index-pack died with error code 128
>         fetch-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git' failed.
> 
> yes, it is reproducable. Again I am off the net for an hour.

I can't reproduce that.

$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
Initialized empty Git repository in /home/nico/git/tst/linux-2.6/.git/
remote: Generating pack...
remote: Done counting 496911 objects.
remote: Deltifying 496911 objects...
remote:  100% (496911/496911) done
Indexing 496911 objects...
remote: Total 496911 (delta 401539), reused 493712 (delta 398653)
 100% (496911/496911) done
Resolving 401539 deltas...
 100% (401539/401539) done
Checking 22413 files out...
 100% (22413/22413) done
$ git version
git version 1.5.2.1

> I used the debian packages that built a friend of mine:
>
>         deb http://rmdir.de/~michael/git/ ./
>
> If you want to reproduce it by yourself.

I don't use Debian, sorry.


Nicolas
