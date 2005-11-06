From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git binary directory?
Date: Sun, 6 Nov 2005 08:20:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511060816390.3316@g5.osdl.org>
References: <Pine.LNX.4.64.0511051247330.3316@g5.osdl.org>
 <7voe4y5w3v.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511052013550.3316@g5.osdl.org>
 <7vy84249re.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 06 17:21:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYnGM-0003CV-1I
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 17:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbVKFQUs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 11:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbVKFQUs
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 11:20:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25817 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750868AbVKFQUr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 11:20:47 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA6GKgnO012187
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 6 Nov 2005 08:20:43 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA6GKfbR030496;
	Sun, 6 Nov 2005 08:20:42 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy84249re.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11216>



On Sat, 5 Nov 2005, Junio C Hamano wrote:
> 
> My point (actually, my purist half's point) is that /usr/bin is
> that nice structure that keeps related things together --- the
> relatedness of them being "the end user would want to run them".

Yes. I wish there was some way around that.

Right now, for a 1.0 release, I suspect that the "put the git binaries 
somewhere else" just isn't worth it. It will break existing scripts that 
use the binaries directly (we've already broken the kernel.org snapshot 
scripts about a million times with just _renaming_ the binaries ;)

It would still be nice to not screw up peoples /usr/bin too badly. At 
least we have the nice property that our git programs sort together and 
can pretty much be wild-carded (not everybody uses package installers, and 
on one machine I had just done "make prefix=/usr install" and was happy to 
be able to basically remove it with "rm /usr/bin/git-*")

			Linus
