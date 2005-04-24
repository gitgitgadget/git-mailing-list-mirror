From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Add -u option to diff-cache to show UNCHANGED files
Date: Sun, 24 Apr 2005 14:43:18 +0200
Message-ID: <20050424124318.GD1507@pasky.ji.cz>
References: <Pine.LNX.4.21.0504232003490.30848-100000@iabervon.org> <Pine.LNX.4.58.0504231906110.2344@ppc970.osdl.org> <Pine.LNX.4.58.0504232022180.4690@sam.ics.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 14:38:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPgNh-0005tY-8a
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 14:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVDXMnW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 08:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVDXMnW
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 08:43:22 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51395 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262320AbVDXMnT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 08:43:19 -0400
Received: (qmail 15124 invoked by uid 2001); 24 Apr 2005 12:43:18 -0000
To: Andreas Gal <gal@uci.edu>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504232022180.4690@sam.ics.uci.edu>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 24, 2005 at 05:28:17AM CEST, I got a letter
where Andreas Gal <gal@uci.edu> told me that...
> With -u diff-cache shows unchanged files, instead of files that changed. 
> This is useful to implement a "git clean" command that throws away all 
> checked out files that have not changed (yes, I really would like to 
> have that). One could also do show-files and then substract the 
> diff-cache output from it, but thats slow and clumsy. 
> 
> Signed-off-by: Andreas Gal <gal@uci.edu>

I don't think this fits to diff-cache (since the output is basically
nonsensical apart of the filename, right?). Maybe rather show-files?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
