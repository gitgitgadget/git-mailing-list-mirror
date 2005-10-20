From: Petr Baudis <pasky@suse.cz>
Subject: Re: How do I clear the directory cache
Date: Thu, 20 Oct 2005 10:59:31 +0200
Message-ID: <20051020085931.GW30889@pasky.or.cz>
References: <2b05065b0510170720n5333f03l1941e84c1288fc5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 11:01:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESWH5-00048U-Af
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 10:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVJTI7f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 04:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVJTI7f
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 04:59:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49885 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750760AbVJTI7e (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 04:59:34 -0400
Received: (qmail 14644 invoked by uid 2001); 20 Oct 2005 10:59:31 +0200
To: eschvoca <eschvoca@gmail.com>
Content-Disposition: inline
In-Reply-To: <2b05065b0510170720n5333f03l1941e84c1288fc5d@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10355>

  Hello,

Dear diary, on Mon, Oct 17, 2005 at 04:20:42PM CEST, I got a letter
where eschvoca <eschvoca@gmail.com> told me that...
> If I do a:
> 
> cg-commit
> modifiy some files
> cg-rm <modified files>
> cg-add <a new file>
> cg-rm <a unmodified file>
> 
> Then how do I get back and undo all of the cg-adds and cg-rms?  I want
> cg-status to show the the changes from my commit and my current
> working tree.

  why can't you just do the following?

	cg-add <an unmodified file>
	cg-rm <a new file>
	cg-add <modified files>

  Hmm. Would it be non-marginally useful to offer something like

	cg-reset --adds-removals

to just reset the index? (It's not --index because Cogito users aren't
supposed to have to know what an "index" is.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
