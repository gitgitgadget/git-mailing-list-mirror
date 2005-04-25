From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Date: Mon, 25 Apr 2005 14:32:36 +0200
Message-ID: <20050425123236.GC26665@pasky.ji.cz>
References: <426CD1F1.2010101@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 14:28:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ2gg-0002xa-Ey
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 14:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbVDYMcl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 08:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbVDYMcl
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 08:32:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11227 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262592AbVDYMcj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 08:32:39 -0400
Received: (qmail 31066 invoked by uid 2001); 25 Apr 2005 12:32:36 -0000
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Content-Disposition: inline
In-Reply-To: <426CD1F1.2010101@tiscali.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 25, 2005 at 01:18:09PM CEST, I got a letter
where Matthias-Christian Ott <matthias.christian@tiscali.de> told me that...
> The "git" didn't try store small variables, which aren't referenced, in 
> the processor registers. It also didn't use the size_t type. I corrected 
> a C++ style comment too.

Honestly, I don't think using the register keyword helps anything but to
make the code less readable.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
