From: Jon Loeliger <jdl@freescale.com>
Subject: Re: dumb transports not being welcomed..
Date: Wed, 14 Sep 2005 14:13:26 -0500
Message-ID: <1126725206.14036.22.camel@cashmere.sps.mot.com>
References: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net>
	 <20050913211444.GA27029@mars.ravnborg.org>
	 <7vacig1wrb.fsf@assigned-by-dhcp.cox.net>
	 <7vpsrcwrc1.fsf@assigned-by-dhcp.cox.net>
	 <1126707016.14036.14.camel@cashmere.sps.mot.com>
	 <7vk6hjiiew.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Sam Ravnborg <sam@ravnborg.org>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 21:14:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFchT-000526-Nu
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 21:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932753AbVINTNl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 15:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932755AbVINTNk
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 15:13:40 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:12433 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S932754AbVINTNk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 15:13:40 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id j8EJNBnO000143;
	Wed, 14 Sep 2005 12:23:11 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id j8EJHxE4029931;
	Wed, 14 Sep 2005 14:17:59 -0500 (CDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6hjiiew.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8555>

On Wed, 2005-09-14 at 14:00, Junio C Hamano wrote:

> Fair enough.  My excuse is that Linus did not want the
> update-server-info hook enabled by default.  He does not believe
> in dumb transports anyway, but aside from that, it still is a
> valid attitude because it is not necessary when you do not
> intend to publish your repository over dumb transport at all but
> still want to push into it.  And another excuse is I do not
> in general think enabling hooks by default is a good idea.
> 
> Even if you built your repository with older git tools, you
> should be always able to say 'GIT_DIR=that-repository
> git-init-db' without damaging its existing contents to install
> the disabled hooks in its hooks/ directory.

Hmmm.  Maybe this is all begging a form of documentation
down the "Best Practices" line, or "Tips I Learned
By Reading Junio and Linus Postings on Git". :-)

> And I thought rsync was a reliable way too, until I saw a
> message from Tony Luck this morning X-<.

Heh.  I read his problem description too, and it sounded
remarkably close to the HTTP pull problems that I had
been victimized by, thus converting me to rsync (for now).

I have recloned entire repos due to the aborted pulls
being left in an inconsistent state.  In fact, that is
what lead me to find git-fsck-cache, which I was expecting
to sort out the missing pieces and detect an incomplete
clone.  Perhaps marking it as "needing completion" via
another clone/pull effort.  Dunno.

jdl
