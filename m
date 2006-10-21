From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] GIT 1.4.3
Date: Fri, 20 Oct 2006 17:31:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610201728031.3962@g5.osdl.org>
References: <7vejt5xjt9.fsf@assigned-by-dhcp.cox.net> <7v4ptylfvw.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610201709430.3962@g5.osdl.org> <20061021002251.GO20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 02:31:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb4m2-0002ln-FS
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 02:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161177AbWJUAbb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 20:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161173AbWJUAbb
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 20:31:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17836 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161159AbWJUAba (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 20:31:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9L0VMaX017951
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Oct 2006 17:31:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9L0VLPX008877;
	Fri, 20 Oct 2006 17:31:21 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061021002251.GO20017@pasky.or.cz>
X-Spam-Status: No, hits=-0.981 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29565>



On Sat, 21 Oct 2006, Petr Baudis wrote:
>
> > That said, "LESS=FRS" doesn't really help that much. It still clears the 
> > screen. Using "LESS=FRSX" fixes that, but the alternate display sequence 
> > is actually nice _if_ the pager is used.
> 
> Hmm, what terminal emulator do you use? The reasonable ones should
> restore the original screen. At least xterm does, and I *think*
> gnome-terminal does too (although I'm too lazy to boot up my notebook
> and confirm).

Not xterm, at least.

Not gnome-terminal either, for that matter.

I just tried.

	LESS=FRS git diff

clears the screen and leaves the thing at the end.

	LESS=FRSX git diff

works fine, but for people who _like_ the alternate screens (and I do, 
once I really use a pager) it also disables the alternate screen.

It might depend on the termcap, of course. I'm running FC5.

		Linus
