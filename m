From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: dumb transports not being welcomed..
Date: Tue, 13 Sep 2005 15:29:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509131525250.26803@g5.osdl.org>
References: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net> <20050913211444.GA27029@mars.ravnborg.org>
 <7vacig1wrb.fsf@assigned-by-dhcp.cox.net> <7vpsrcwrc1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Ravnborg <sam@ravnborg.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 00:38:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFJHe-0006UD-FZ
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 00:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbVIMW3o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 18:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbVIMW3o
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 18:29:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64930 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932482AbVIMW3n (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 18:29:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8DMTaBo026088
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Sep 2005 15:29:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8DMTZAm029864;
	Tue, 13 Sep 2005 15:29:36 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsrcwrc1.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8499>



On Tue, 13 Sep 2005, Junio C Hamano wrote:
> 
> I need to clarify what I meant by 'not welcoming dumb transport'
> a bit better.  Namely, those (~80 - 23) = ~57 repositories lack
> support for 'git ls-remote' over http, which means you cannot
> discover what refs the repository has.

You do realize that up until a week ago (six days, to be exact),
kernel.org was running git-0.99.4, which I don't think actually
implemented any of the info stuff?

So out of the 57 repositories, how many haven't been updated in a week?

I suspect that explains a large portion of it.

Also, I really do think that the dumb transports are oversold, and 
git-daemon is undersold. I know all about firewalls, but I also think that 
if people used the smart protocols more, that's a problem that would 
largely solve itself. 

Dumb protocols can never do really well. That's just very fundamental. 

		Linus
