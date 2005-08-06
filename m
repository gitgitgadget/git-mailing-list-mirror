From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk "hyperlinks" (was Re: Display of merges in gitk)
Date: Sat, 6 Aug 2005 23:16:32 +1000
Message-ID: <17140.47152.672091.474748@cargo.ozlabs.ibm.com>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0508050658260.3258@g5.osdl.org>
	<Pine.LNX.4.58.0508050710460.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 06 15:17:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1OXl-0002pS-Nd
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 15:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVHFNQs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 09:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVHFNQs
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 09:16:48 -0400
Received: from ozlabs.org ([203.10.76.45]:55450 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261914AbVHFNQs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2005 09:16:48 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 7E0AC67F2D; Sat,  6 Aug 2005 23:16:44 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508050710460.3258@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds writes:

>  - "clickable" SHA1's in commit messages would be really really cool if 
>    something like that is even possible with tcl/tk.

Done, and it was even pretty easy.  It took only about a dozen lines.

>  - I'd like to have a "back button". Not just for the above kind of thing, 
>    but in general too: when searching for something, it would just be very 
>    nice if gitk just kept a list of the <n> last commits that have 
>    been selected, and there was a web-browser-like button that went 
>    back/forward in history.

Good idea.  Also done. :)  It's on master.kernel.org now in my gitk.git
directory.  Hopefully Junio will pull it into git soon.  The current
version also squishes the graph horizontally if it gets too wide
(i.e. more than half the width of the top-left pane).

Paul.
