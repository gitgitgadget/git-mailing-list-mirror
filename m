From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Use a *real* built-in diff generator
Date: Sat, 25 Mar 2006 12:48:33 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603251238550.15714@g5.osdl.org>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
 <118833cc0603250544h289f385fo683ec7b40cdb0ed@mail.gmail.com>
 <Pine.LNX.4.64.0603250734130.15714@g5.osdl.org> <Pine.LNX.4.64.0603250742340.15714@g5.osdl.org>
 <7vslp6uvn1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 21:48:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNFgl-0002tN-RP
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 21:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWCYUsm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 15:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWCYUsm
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 15:48:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4044 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751406AbWCYUsl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 15:48:41 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2PKmYDZ029791
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 25 Mar 2006 12:48:35 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2PKmXrY011767;
	Sat, 25 Mar 2006 12:48:34 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslp6uvn1.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17998>



On Sat, 25 Mar 2006, Junio C Hamano wrote:
> 
> This is a replacement for my previous one, which reduces the
> changes to the testsuite.

Looks good. With this, I think it's certainly ready for the "next" branch, 
and with some testing should be quite mergable into the main branch too.

I really didn't have to mess up the libxdiff files very much, so I don't 
think I introduced any new bugs, and libxdiff itself seems to be pretty 
stable (and that's partly from running the tests, but even more from just 
looking at the code and not having any 'Ewww! Gross!'-moments).

Which is not to say that there couldn't be bugs, but I think this is very 
much worth merging quickly..

> I'll find time to omit prepare_temp_file() calls from diffcore
> emit routines over the weekend.  Another useful project would be
> to redo the combine-diff.c using the real built-in diff.

I think the pickaxe improvements would be an even bigger thing..

		Linus
