From: Nicolas Pitre <nico@cam.org>
Subject: Re: warning: no common commits - slow pull
Date: Tue, 26 Feb 2008 15:47:28 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802261546030.3167@xanadu.home>
References: <200802102007.38838.lenb@kernel.org>
 <20080211035501.GB26205@mit.edu> <200802151643.30232.lenb@kernel.org>
 <200802261438.17014.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, Theodore Tso <tytso@mit.edu>,
	git@vger.kernel.org
To: Len Brown <lenb@kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 21:49:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU6jA-00054X-S1
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 21:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbYBZUr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 15:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbYBZUr6
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 15:47:58 -0500
Received: from relais.videotron.ca ([24.201.245.36]:47242 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbYBZUr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 15:47:57 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JWV00A7Y5R4F060@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 26 Feb 2008 15:47:29 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <200802261438.17014.lenb@kernel.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75172>

On Tue, 26 Feb 2008, Len Brown wrote:

> On Friday 15 February 2008, Len Brown wrote:
> > it happened again.
> > 
> > this morning I pulled linus' tree up through 
> > 4ee29f6a52158cea526b16a44ae38643946103ec
> > 
> > then during the day, linus declared "rc2".
> > 
> > and now I pulled linus' tree again,
> > which has a HEAD now of 
> > 
> > 101142c37be8e5af9b847860219217e6b958c739
> > 
> > and the pull sucked down 172 MB even though the uncompressed
> > diff between the two is 0.3 MB.
> > 
> > -Len
> > 
> > [lenb@d975xbx2 linus (master)]$ git pull
> > remote: Counting objects: 649, done.
> > remote: Compressing objects: 100% (106/106), done.
> > remote: Total 513 (delta 417), reused 503 (delta 407)
> > Receiving objects: 100% (513/513), 116.67 KiB, done.
> > Resolving deltas: 100% (417/417), completed with 103 local objects.
> > warning: no common commits
> > remote: Counting objects: 710725, done.
> > remote: Compressing objects: 100% (125738/125738), done.
> > remote: Total 710725 (delta 589584), reused 704450 (delta 584029)
> > Receiving objects: 100% (710725/710725), 172.71 MiB | 1073 KiB/s, done.
> > Resolving deltas: 100% (589584/589584), done.
> > From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
> >  * [new tag]         v2.6.25-rc2 -> v2.6.25-rc2
> > Updating 4ee29f6..101142c
> > Fast forward
> >  Makefile                               |    4 +-
> ...
> > [lenb@d975xbx2 linus (master)]$            
> > [lenb@d975xbx2 linus (master)]$ git --version
> > git version 1.5.4.1.122.gaa8d
> 
> It still happens with latest git. (linus has declared -rc3 this time)

So it happens everytime a new tag is fetched.

> unfortunately for me, i'm not on broadband this time so it is extremely painful --
> to the point that i simply can't update this tree until i get home.

What happens if you restart the pull after interrupting the first 
attempt?


Nicolas
