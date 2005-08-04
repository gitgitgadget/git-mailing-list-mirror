From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: bisect gives strange answer
Date: Thu, 04 Aug 2005 19:32:20 +0100
Message-ID: <E1E0kVw-0003re-00@skye.ra.phy.cam.ac.uk>
References: <20050804182717.GA2241@redhat.com>
Cc: Greg KH <greg@kroah.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 20:34:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0kWd-0003Da-DF
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 20:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbVHDScc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 14:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVHDScb
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 14:32:31 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:30931 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262405AbVHDSc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 14:32:27 -0400
Received: from skye.ra.phy.cam.ac.uk ([131.111.48.158] ident=mail)
	by mraos.ra.phy.cam.ac.uk with esmtp (Exim 4.43)
	id 1E0kVw-00074x-9F; Thu, 04 Aug 2005 19:32:20 +0100
Received: from sanjoy by skye.ra.phy.cam.ac.uk with local (Exim 3.35 #1)
	id 1E0kVw-0003re-00; Thu, 04 Aug 2005 19:32:20 +0100
To: Dave Jones <davej@redhat.com>
In-Reply-To: Your message of "Thu, 04 Aug 2005 14:27:17 EDT."
             <20050804182717.GA2241@redhat.com> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Errrrm, if you don't compile/test those intermediate versions,
> how do you know whether to tag it good/bad ?

Sorry, I wrote this part carelessly: "If I had checked out and
compiled those intermediate versions from scratch..."

I meant to emphasize the 'from scratch'.  I did check out and compile
the versions, but I didn't compile from scratch. i.e. I just took
whatever directory tree I got after

  git bisect good
or
  git bisect bad

and then did 'make -j 4'.  Perhaps I should have done

  make clean 
  <restore .config>
  make -j 4

to be really sure that every file that needed recompilation got
recompiled.

-Sanjoy
