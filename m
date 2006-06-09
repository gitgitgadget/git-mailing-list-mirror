From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git-daemon messing up permissions for gitweb
Date: Fri, 9 Jun 2006 13:44:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606091344010.5498@g5.osdl.org>
References: <5A14AF34CFF8AD44A44891F7C9FF41050795787F@usahm236.amer.corp.eds.com>
 <Pine.LNX.4.64.0606091321100.5498@g5.osdl.org> <7vodx2m5jp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Post, Mark K" <mark.post@eds.com>
X-From: git-owner@vger.kernel.org Fri Jun 09 22:44:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FonqM-0005xc-S7
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 22:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbWFIUob (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 16:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965166AbWFIUob
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 16:44:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3252 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965164AbWFIUoa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 16:44:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k59KiPgt029984
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 13:44:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k59KiOG3029156;
	Fri, 9 Jun 2006 13:44:25 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodx2m5jp.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21553>



On Fri, 9 Jun 2006, Junio C Hamano wrote:
>
> But that should be tweakable by configuring what sshd does for
> the user, shouldn't it?  The "LOGIN PROCESS" section from man
> sshd(8) seems to talk about $HOME/.ssh/environment, for example.

Yeah. That's probably the right place to set things up.

		Linus
