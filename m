From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cg-update with local uncommitted changes
Date: Mon, 30 May 2005 20:39:32 +0200
Message-ID: <20050530183932.GB10439@pasky.ji.cz>
References: <1117463114.7072.185.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 20:40:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcpAp-0006Ed-Q2
	for gcvg-git@gmane.org; Mon, 30 May 2005 20:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVE3Slu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 14:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVE3Slu
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 14:41:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26004 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261691AbVE3Sjf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 14:39:35 -0400
Received: (qmail 13574 invoked by uid 2001); 30 May 2005 18:39:32 -0000
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1117463114.7072.185.camel@pegasus>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 30, 2005 at 04:25:14PM CEST, I got a letter
where Marcel Holtmann <marcel@holtmann.org> told me that...
> Hi Petr,

Hello,

> when doing a cg-update and I have local uncommitted changes it fails
> with the "... needs update" message. From some previous posts on the
> mailing list I got the impression that it is possible to pull updates
> into the local repository with changed files. At the moment I am using
> the following sequence:
> 
> 	cg-diff > patch
> 	cg-cancel
> 	cg-update origin
> 	cat patch | patch -p1
> 	rm patch
> 
> The problem with this sequence is when I have added or removed files
> from my repository. This needs a lot of manual fixing.
> 
> With Bitkeeper it was possible to pull changes as long as they don't
> affect local uncommitted files.
> 
> Any ideas on how to implement or if it exists on how to use it?

does it really fail? "... needs update" is not an error but something
between informative and warning message. (I've just committed a change
which silences it in this case.)

If the update did indeed fail, could you show the complete output,
please?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
