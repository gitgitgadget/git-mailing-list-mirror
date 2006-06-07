From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH/RFC] "git --less cmd" to page anywhere
Date: Tue, 6 Jun 2006 17:12:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606061711000.5498@g5.osdl.org>
References: <20060604211931.10117.82695.stgit@machine.or.cz>
 <20060604212050.GV10488@pasky.or.cz> <Pine.LNX.4.64.0606041621010.5498@g5.osdl.org>
 <7vodx5n8en.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606061703380.5498@g5.osdl.org>
 <20060607000816.GY10488@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 02:13:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnlfc-00040O-C7
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 02:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWFGANA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 20:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWFGANA
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 20:13:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51136 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751395AbWFGAM7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 20:12:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k570Cp2g026923
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 6 Jun 2006 17:12:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k570CoeX007734;
	Tue, 6 Jun 2006 17:12:50 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060607000816.GY10488@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21419>



On Wed, 7 Jun 2006, Petr Baudis wrote:
> 
> Actually, you made a case in the misty past that cg-log should just
> stuff things through a pager by default and I ended up finding that
> extremely convenient - what is the reason git log does not do the same?

"git log" does, "git diff" does not (and yeah, I just chose a bad example, 
I meant "git -p diff -p")

For "git diff", pagination by default is definitely not the right thing to 
do, but it's something you often end up wanting.

		Linus
