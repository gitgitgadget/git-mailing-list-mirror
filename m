From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] GIT 1.4.3
Date: Fri, 20 Oct 2006 17:14:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610201709430.3962@g5.osdl.org>
References: <7vejt5xjt9.fsf@assigned-by-dhcp.cox.net> <7v4ptylfvw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 02:15:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb4Vs-0008U4-Nv
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 02:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161170AbWJUAOq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 20:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161162AbWJUAOp
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 20:14:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50089 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161087AbWJUAOo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 20:14:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9L0EeaX017200
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Oct 2006 17:14:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9L0Edip008460;
	Fri, 20 Oct 2006 17:14:40 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4ptylfvw.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.98 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29563>



On Fri, 20 Oct 2006, Junio C Hamano wrote:
> 
> I am considering the following to address irritation some people
> (including me, actually) are experiencing with this change when
> viewing a small (or no) diff.  Any objections?

Not from me. I use "git diff" just to check that the tree is empty, and 
the fact that it now throws me into an empty pager is irritating.

That said, "LESS=FRS" doesn't really help that much. It still clears the 
screen. Using "LESS=FRSX" fixes that, but the alternate display sequence 
is actually nice _if_ the pager is used.

Still, I think I'd prefer FRSX as the default.

		Linus
