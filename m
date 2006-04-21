From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-log produces no output
Date: Fri, 21 Apr 2006 13:25:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604211322140.3701@g5.osdl.org>
References: <20060421184815.22939.qmail@web60319.mail.yahoo.com>
 <Pine.LNX.4.64.0604211214560.3701@g5.osdl.org> <Pine.LNX.4.64.0604211223561.3701@g5.osdl.org>
 <7vpsjasnh5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 21 22:26:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FX2CQ-0002td-Dr
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 22:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWDUUZv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Apr 2006 16:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWDUUZv
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Apr 2006 16:25:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15016 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751149AbWDUUZv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Apr 2006 16:25:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3LKPctH015116
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 21 Apr 2006 13:25:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3LKPbmc012578;
	Fri, 21 Apr 2006 13:25:37 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsjasnh5.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19031>



On Fri, 21 Apr 2006, Junio C Hamano wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Fri, 21 Apr 2006, Linus Torvalds wrote:
> >> 
> >> This patch would have made things a lot more obvious.
> >
> > Actually, scratch that one, and use this one instead. Much better, and 
> > actually allows Bob's crazy PAGER environment variable to work, rather 
> > than just reporting an error about it.
> 
> Agreed, this is much better than just punting.  Sign-off?

Yup, you can just go wild with the 

	Signed-off-by: Linus Torvalds <torvalds@osdl.org>

lines. My employment contract requires that everything I produce is open 
source ;)

> BTW: The extended extended SHA1 is a great addition.  I do not
> usually have contrib/colordiff checked out (it is in "pu", not
> in "next"), but I can easily do:
> 
> 	git tar-tree pu:contrib/colordiff colordiff | tar xf -

Ahh, yes. That is one situation where a sub-tree SHA1 makes more sense 
than most (the fact that it works with "git diff" and directory renames is 
likely more of a curiosity than anything widely useful, I think)

> BTW: Allow me to try "git fmt-patch -1" ;-).

Looks good to me.

		Linus
