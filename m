From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git versus CVS (versus bk)
Date: Mon, 31 Oct 2005 17:48:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0510311747580.27915@g5.osdl.org>
References: <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com>
 <7vr7a1e719.fsf@assigned-by-dhcp.cox.net> <20051031213616.GO11488@ca-server1.us.oracle.com>
 <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net> <20051031224246.GP11488@ca-server1.us.oracle.com>
 <7vbr15b4m4.fsf@assigned-by-dhcp.cox.net> <20051101004255.GQ11488@ca-server1.us.oracle.com>
 <46a038f90510311702wfb43281rf4464a02e8e3be2@mail.gmail.com>
 <20051101012915.GR11488@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Nov 01 02:49:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWlGt-0002Ed-Hj
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 02:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbVKABtE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 20:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbVKABtD
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 20:49:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32665 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964943AbVKABtC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 20:49:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA11mlW6030293
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Oct 2005 17:48:47 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA11mkHu009398;
	Mon, 31 Oct 2005 17:48:46 -0800
To: Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20051101012915.GR11488@ca-server1.us.oracle.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10916>



On Mon, 31 Oct 2005, Joel Becker wrote:
> 
> 	But I'm not.  I don't want patches in the first place.  I want
> cg-pull but with a flattened history.

Well, that you've largely got in "git rebase". But if you wanrt to merge 
commits, you'd have to do that logic yourself..

		Linus
