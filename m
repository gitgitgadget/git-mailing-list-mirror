From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-ls-tree: add "-t" option to always show the tree entries
Date: Thu, 1 Dec 2005 13:57:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512011354500.3099@g5.osdl.org>
References: <7vlkz5n3r1.fsf@assigned-by-dhcp.cox.net>
 <20051201085433.GA7866@c165.ib.student.liu.se> <Pine.LNX.4.64.0512011022520.3099@g5.osdl.org>
 <7vlkz4friv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 23:01:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhwSG-0006cS-9G
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 22:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbVLAV60 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 16:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbVLAV60
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 16:58:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58066 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932513AbVLAV6Z (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 16:58:25 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jB1LvZnO010142
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 1 Dec 2005 13:57:36 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jB1LvUbZ009473;
	Thu, 1 Dec 2005 13:57:32 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkz4friv.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13080>



On Thu, 1 Dec 2005, Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > NOTE! This also means that it will show all trees leading up to that tree. 
> 
> ... which is logical but slightly unexpected.  Also I noticed we
> lost '-d' but still accept it as an option, so...

Yes. I like the notion of doing

	git-ls-tree -r -d HEAD

to get a full list of directories for the project.

That brings up another issue. I typed

	git-ls-tree -r --name-only ..

and it obviously didn't work. That's kind of sad. I use that quite a lot 
for "git diff", for example, because quite often I want to see the files, 
but I don't care about anything else.

Maybe nobody else uses that "--name-only" thing.

		Linus
