From: Dave Jones <davej@redhat.com>
Subject: Re: bisect gives strange answer
Date: Thu, 4 Aug 2005 14:27:17 -0400
Message-ID: <20050804182717.GA2241@redhat.com>
References: <20050804172635.GA14144@kroah.com> <E1E0jiv-0003c4-00@skye.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 20:30:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0kT0-0002lZ-Lk
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 20:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVHDS2o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 14:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVHDS2o
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 14:28:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39839 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261821AbVHDS1Z (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 14:27:25 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j74IRIve005439;
	Thu, 4 Aug 2005 14:27:18 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j74IRIV32098;
	Thu, 4 Aug 2005 14:27:18 -0400
Received: from nwo.kernelslacker.org (vpn50-5.rdu.redhat.com [172.16.50.5])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j74IRIHM001245;
	Thu, 4 Aug 2005 14:27:18 -0400
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.4/8.13.4) with ESMTP id j74IRHeY002398;
	Thu, 4 Aug 2005 14:27:17 -0400
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.4/8.13.4/Submit) id j74IRHRb002397;
	Thu, 4 Aug 2005 14:27:17 -0400
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Content-Disposition: inline
In-Reply-To: <E1E0jiv-0003c4-00@skye.ra.phy.cam.ac.uk>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 04, 2005 at 06:41:41PM +0100, Sanjoy Mahajan wrote:
 > > By any chance, is this patch causing you problems?
 > 
 > No, sadly.  But I had hopes!  As I think about it more, there's no way
 > it could, since I have CONFIG_HOTPLUG=y, so moving the CONFIG_HOTPLUG
 > would not change anything (for those who don't know the patch, it is
 > appended below).  
 > 
 > My latest theory is that I fed bisect incorrect good/bad data.
 > Perhaps If I had checked out and compiled those intermediate versions
 > from scratch, each version in a separate directory, then I would have
 > got different answers.  Two possible reasons:

Errrrm, if you don't compile/test those intermediate versions,
how do you know whether to tag it good/bad ?

		Dave
