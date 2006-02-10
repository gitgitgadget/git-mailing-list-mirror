From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Comments on "status -v"
Date: Fri, 10 Feb 2006 13:35:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602101333570.19172@g5.osdl.org>
References: <87slqtcr2f.wl%cworth@cworth.org> <7vfymtl43b.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602081726390.2458@g5.osdl.org> <7vmzgzy46f.fsf@assigned-by-dhcp.cox.net>
 <87u0b7uf91.wl%cworth@cworth.org> <7vaccyx6ne.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 00:12:38 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7fvB-0004UV-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 22:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWBJVfO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 16:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWBJVfN
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 16:35:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41399 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750723AbWBJVfM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2006 16:35:12 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1ALZ6DZ028214
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 10 Feb 2006 13:35:07 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1ALZ5hx005092;
	Fri, 10 Feb 2006 13:35:06 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vaccyx6ne.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15894>



On Fri, 10 Feb 2006, Junio C Hamano wrote:

> Carl Worth <cworth@cworth.org> writes:
> 
> > 1) I think the patch should come after the traditional status summary,
> >    not before. If something is obviously "wrong" (non-updated file,
> >    etc.) that will be more obvious in the summary, so it's good to
> >    present that up front, and not bury it after the patch, (which
> >    might make it initially invisible without scrolling).
> 
> Maybe.  A time for a quick poll.

I think I agree. Especially if doing "git commit -v", the _top_ of the 
status message is what you'd normally be most aware of. I think. 
Especially if the patch is large, you'd grow bored looking at it long 
before you saw what followed.

			Linus
