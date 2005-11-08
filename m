From: Dave Jones <davej@redhat.com>
Subject: Re: git-rev-tree
Date: Mon, 7 Nov 2005 21:57:55 -0500
Message-ID: <20051108025755.GA22243@redhat.com>
References: <20051108021232.GB10835@redhat.com> <Pine.LNX.4.64.0511071819510.3247@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 03:59:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZJgd-0000v9-1V
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 03:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965686AbVKHC6M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 21:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965687AbVKHC6M
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 21:58:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4552 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965686AbVKHC6K (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 21:58:10 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id jA82w1Yt026957;
	Mon, 7 Nov 2005 21:58:01 -0500
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id jA82vuV16643;
	Mon, 7 Nov 2005 21:57:56 -0500
Received: from nwo.kernelslacker.org (vpn83-122.boston.redhat.com [172.16.83.122])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id jA82vuAx022360;
	Mon, 7 Nov 2005 21:57:56 -0500
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.5/8.13.4) with ESMTP id jA82vtq9023995;
	Mon, 7 Nov 2005 21:57:55 -0500
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.5/8.13.5/Submit) id jA82vtUr023994;
	Mon, 7 Nov 2005 21:57:55 -0500
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511071819510.3247@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11306>

On Mon, Nov 07, 2005 at 06:33:30PM -0800, Linus Torvalds wrote:

 > 	export KERNEL=master.kernel.org:/pub/scm/linux/kernel/git/
 > 	git fetch $KERNEL/torvalds/linux-2.6 master:linus
 > 
 >    which will just fetch my "master" branch into the local "linus" branch.
 > 
 >  - then just do
 > 
 > 	git log linus..HEAD
 > 
 >    and you'll see exactly what you wanted: what exists in your HEAD but 
 >    not in mine.
 > 
 > No complex script required.

Ok, I must be doing something totally bone-headed.  Because this is what
I tried to do before I headed down the path of making that script work.

Doing the above yields ...

(18:47:37:davej@hera:agp2)$ export KERNEL=master.kernel.org:/pub/scm/linux/kernel/git/
(18:47:43:davej@hera:agp2)$ git fetch $KERNEL/torvalds/linux-2.6 master:linus
davej@master.kernel.org's password:
Packing 35335 objects
Unpacking 35335 objects
 100% (35335/35335) done
* committish: d27ba47e7e8c466c18983a1779d611f82d6a354f
  branch 'master' of master.kernel.org:/pub/scm/linux/kernel/git//torvalds/linux-2.6
* refs/heads/linus: storing branch 'master' of master.kernel.org:/pub/scm/linux/kernel/git//torvalds/linux-2.6

which looks ok, but then when I do the git log linus..HEAD, I get no output at all.

Whatever I'm doing wrong, I'm doing it consistently, as this happens
in all my trees both locally, and on k.o

*click*, ahh wait, I didn't have a 'linus' branch before I did that fetch.
For the above to work, do I need there to be a 'linus' branch before
I start making changes ?  Or am I barking up the wrong tree ?

		Dave
