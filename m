From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's up with the GIT archive on www.kernel.org?
Date: Sun, 11 Sep 2005 12:56:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>
References: <m3mzmjvbh7.fsf@telia.com> <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
 <20050911185711.GA22556@mars.ravnborg.org> <Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
 <20050911194630.GB22951@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Osterlund <petero2@telia.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750837AbVIKT4T@vger.kernel.org Sun Sep 11 21:56:57 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750837AbVIKT4T@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEXwb-0004SR-RJ
	for glk-linux-kernel-3@gmane.org; Sun, 11 Sep 2005 21:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVIKT4T (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 11 Sep 2005 15:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVIKT4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 15:56:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6028 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750712AbVIKT4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 15:56:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8BJuEBo021333
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Sep 2005 12:56:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8BJuC5l019544;
	Sun, 11 Sep 2005 12:56:13 -0700
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20050911194630.GB22951@mars.ravnborg.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8324>



On Sun, 11 Sep 2005, Sam Ravnborg wrote:
> 
> I had to specify both GIT_DIR and GIT_OBJECT_DIRECTORY to make
> git-prune-packed behave as expected. I assume this is normal when I
> rename the .git directory like in this case.

You should only need to specify GIT_DIR - it should figure out that the 
object directory follows GIT_DIR on its own.

Also, I forget what version of git is installed on kernel.org. The
"alternates" support has been around for a while, and looking at the date
of "/usr/bin/git" it _seems_ recent (Sep 7), but I haven't seen any
announcement of updating since the last one (which was git-0.99.4, which
is too old).

You can try removing all the packs in your .git/objects/packs directory. 
Everything _should_ still work fine.

Famous last words.

		Linus
