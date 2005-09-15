From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Shell quoting
Date: Thu, 15 Sep 2005 13:02:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509151258400.26803@g5.osdl.org>
References: <43290BB8.90501@zytor.com> <7vy85yahjk.fsf@assigned-by-dhcp.cox.net>
 <4329C11A.1040302@zytor.com> <Pine.LNX.4.58.0509151153140.26803@g5.osdl.org>
 <7vpsrayviz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 22:04:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFzwO-0006H6-Lq
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 22:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030463AbVIOUCf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 16:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbVIOUCf
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 16:02:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34540 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030463AbVIOUCf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 16:02:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8FK2UBo014732
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Sep 2005 13:02:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8FK2RCJ021510;
	Thu, 15 Sep 2005 13:02:28 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsrayviz.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8637>



On Thu, 15 Sep 2005, Junio C Hamano wrote:
> 
> I vaguely recall you had a code that assumes what sq_quote()
> produces and unquote it without using shell.  If somebody does
> the above change for '!' and '\', that code may need to be
> checked and adjusted as well.

I sent out a trivial "push-shell" that was meant to be usable as a login 
shell for an ssh connection that only accepted pushes (and could perhaps 
be extended to also allow some administrative stuff like creating new 
archives etc).

In that thing, push-shell.c: parse_argument() would need to be trivially
updated.

I didn't ever test it, and I never got any feedback on it, so.. If anybody 
is interested in it, I still have it, although I think a better place to 
find it is probably on the git mailing list archives. I've not done any 
other work on it.

		Linus
