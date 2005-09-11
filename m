From: Roland Dreier <rolandd@cisco.com>
Subject: Re: What's up with the GIT archive on www.kernel.org?
Date: Sun, 11 Sep 2005 14:09:30 -0700
Message-ID: <52irx7cnw5.fsf@cisco.com>
References: <m3mzmjvbh7.fsf@telia.com>
	<Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
	<20050911185711.GA22556@mars.ravnborg.org>
	<Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
	<20050911194630.GB22951@mars.ravnborg.org>
	<Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Peter Osterlund <petero2@telia.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 11 23:10:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEZ52-0003dz-6q
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 23:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVIKVJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 17:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbVIKVJh
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 17:09:37 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:31410 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750867AbVIKVJg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 17:09:36 -0400
Received: from ams-core-1.cisco.com ([144.254.224.150])
  by ams-iport-1.cisco.com with ESMTP; 11 Sep 2005 23:09:36 +0200
Received: from xbh-ams-332.emea.cisco.com (xbh-ams-332.cisco.com [144.254.231.87])
	by ams-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id j8BL9WVP013895;
	Sun, 11 Sep 2005 23:09:32 +0200 (MEST)
Received: from xfe-ams-331.emea.cisco.com ([144.254.231.72]) by xbh-ams-332.emea.cisco.com with Microsoft SMTPSVC(6.0.3790.0);
	 Sun, 11 Sep 2005 23:09:31 +0200
Received: from localhost.localdomain ([171.70.33.55]) by xfe-ams-331.emea.cisco.com with Microsoft SMTPSVC(6.0.3790.0);
	 Sun, 11 Sep 2005 23:09:31 +0200
Received: by localhost.localdomain (Postfix, from userid 1113)
	id 347C94FE46; Sun, 11 Sep 2005 14:09:30 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
X-Message-Flag: Warning: May contain useful information
In-Reply-To: <Pine.LNX.4.58.0509111251150.3242@g5.osdl.org> (Linus
 Torvalds's message of "Sun, 11 Sep 2005 12:56:12 -0700 (PDT)")
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
X-OriginalArrivalTime: 11 Sep 2005 21:09:31.0534 (UTC) FILETIME=[1A6AF2E0:01C5B715]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8331>

    Linus> You can try removing all the packs in your
    Linus> .git/objects/packs directory. Everything _should_ still
    Linus> work fine.

Does "everything" include someone doing

    git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/roland/whatever.git

How about http:// instead of rsync://?

In other words, is the git network transport smart enough to handle
the alternates path?

Or is the idea that everyone will clone your tree and then pull extra
stuff from other trees?

 - R.
