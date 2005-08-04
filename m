From: Junio C Hamano <junkio@cox.net>
Subject: Re: bisect gives strange answer
Date: Thu, 04 Aug 2005 11:43:24 -0700
Message-ID: <7v8xzh1r1v.fsf@assigned-by-dhcp.cox.net>
References: <20050804172635.GA14144@kroah.com>
	<E1E0jiv-0003c4-00@skye.ra.phy.cam.ac.uk>
	<20050804182717.GA2241@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, Greg KH <greg@kroah.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 20:44:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0kgp-0004g4-HI
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 20:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbVHDSn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 14:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbVHDSn2
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 14:43:28 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:42187 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262560AbVHDSn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 14:43:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050804184324.IQUN8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 Aug 2005 14:43:24 -0400
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20050804182717.GA2241@redhat.com> (Dave Jones's message of "Thu,
	4 Aug 2005 14:27:17 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> Errrrm, if you don't compile/test those intermediate versions,
> how do you know whether to tag it good/bad ?

I think Sanjoy is saying that they _were_ tested, and suspects
that bisect didn't leave the right versions of the files in the
work tree, so what was compiled and tested were not what bisect
wanted to get tested.  This is theory #2 in Sanjoy's post:

>> 2. git-bisect-script doesn't use -f when it does 'git checkout', so
>>    files that should be updated are not.  Right now I'm in the middle
>>    of recollecting the data with git-bisect-script using -f in all
>>    uses of git checkout (unless that is a really silly idea).

I find this explanation quite plausible, in case it is all my
fault and I apologize for wasting kernel developers' time.
