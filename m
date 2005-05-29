From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Problem with cg-diff <file>
Date: Mon, 30 May 2005 01:38:40 +0200
Message-ID: <20050529233840.GY1036@pasky.ji.cz>
References: <1117408555.7072.109.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 01:37:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcXKN-0008Ca-0I
	for gcvg-git@gmane.org; Mon, 30 May 2005 01:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVE2Xin (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 19:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVE2Xin
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 19:38:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:27781 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261401AbVE2Xil (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 19:38:41 -0400
Received: (qmail 23511 invoked by uid 2001); 29 May 2005 23:38:40 -0000
To: Marcel Holtmann <marcel@holtmann.org>,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <1117408555.7072.109.camel@pegasus>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 30, 2005 at 01:15:55AM CEST, I got a letter
where Marcel Holtmann <marcel@holtmann.org> told me that...
> Hi Petr,

Hi,

> your latest changes are breaking the cg-diff <file> functionality. Now
> cg-diff creates a diff against all local not committed changes.

oops, thanks for the report. Hopefully fixed and pushed out.

Eek, apparently not entirely fixed yet. git-diff-tree (in contrast to
git-diff-cache) won't take the pathspec as its trailing arguments,
causing cg-diff -r a:b still not to work 100% correct.

Junio, is there any specific reason for that, or is the end of
git-diff-tree argument list the right spot for the pathspec stuff?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
