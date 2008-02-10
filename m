From: Seth Falcon <seth@userprimary.net>
Subject: Trouble with gitk and ActiveState tcltk on OS X
Date: Sun, 10 Feb 2008 13:15:10 -0800
Message-ID: <m2ve4wh5sx.fsf@ziti.evri.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 22:15:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOJWh-0006Gf-3I
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 22:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbYBJVPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 16:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbYBJVPU
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 16:15:20 -0500
Received: from qmta06.emeryville.ca.mail.comcast.net ([76.96.30.56]:52503 "EHLO
	QMTA06.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750943AbYBJVPS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 16:15:18 -0500
Received: from OMTA01.emeryville.ca.mail.comcast.net ([76.96.30.11])
	by QMTA06.emeryville.ca.mail.comcast.net with comcast
	id npuh1Y0020EPchoA60Rs00; Sun, 10 Feb 2008 21:15:06 +0000
Received: from ziti.evri.corp ([24.19.171.108])
	by OMTA01.emeryville.ca.mail.comcast.net with comcast
	id nxFF1Y0092LgWns8M00000; Sun, 10 Feb 2008 21:15:16 +0000
X-Authority-Analysis: v=1.0 c=1 a=mFPw9axO2vMA:10 a=Z4mJgif-AAAA:8
 a=xtGCs6gw5ITshMobTPoA:9 a=rxgt2zm0F-VY2M85Tr4A:7
 a=2LS9eeMiwsRwL2vCmaWah4vRSjAA:4 a=F-J2dRE9H3gA:10 a=50e4U0PicR4A:10
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.90 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73417>

Hi all,

I'm hoping that another OS X git user can point me in the right
direction...

I installed the ActiveState tcltk and set the following in
git/config.mak:

    TCLTK_PATH=/usr/local/bin/wish8.5

With this, git gui works great (I get a real icon when switching apps
and the overall look is more consistent than when I was running with
X11 + MacPorts tcltk).

But gitk does not work.  gitk starts up but no window appears.  The
menus appear, but that's it.

If I start X11 and switch the wish path to /opt/local/bin/wish in the
gitk script, then things work.  Any suggestions for running gitk
without X11 on OS X?

Thanks,

+ seth

-- 
Seth Falcon | seth@userprimary.net | blog: http://userprimary.net/user/
