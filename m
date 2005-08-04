From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: bisect gives strange answer
Date: Thu, 4 Aug 2005 21:28:38 +0200
Message-ID: <20050804192838.GB26714@mars.ravnborg.org>
References: <20050804172635.GA14144@kroah.com> <E1E0jiv-0003c4-00@skye.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 21:29:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0lON-0001Up-0l
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 21:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbVHDT22 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 15:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVHDT22
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 15:28:28 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:24448 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262636AbVHDT21
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 15:28:27 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepa.post.tele.dk (Postfix) with ESMTP id 912D847FE47;
	Thu,  4 Aug 2005 21:28:22 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 6F43D6AC01D; Thu,  4 Aug 2005 21:28:38 +0200 (CEST)
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Content-Disposition: inline
In-Reply-To: <E1E0jiv-0003c4-00@skye.ra.phy.cam.ac.uk>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> 
> 1. The kernel Makefiles ar do not understand every subtle dependency.
>    So they might get confused by updating to different tree states (as
>    the bisect progresses) because those updates change Makefiles and
>    include files.  In other words, I should have done 'make clean' or
>    'make mrproper' before each kernel compile.

If you see any sort of evidence that this would hold true I really like
to know.
The current build system is only known to fail if a changed file gets a
timestamp that is not equal to 'now'. Some braindead SCM uses the
timestamp of the chekin.

There has been put a tremendous effort in tracking each and every subtle
dependeny - and if something is missing then it ought to be fixed.

	Sam
