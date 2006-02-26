From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: the war on trailing whitespace
Date: Sun, 26 Feb 2006 12:16:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>
References: <20060225174047.0e9a6d29.akpm@osdl.org> <7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
 <20060225210712.29b30f59.akpm@osdl.org> <Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
 <20060226103604.2d97696c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 21:16:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDSJo-0000Ot-3v
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 21:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWBZUQd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 15:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWBZUQd
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 15:16:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51371 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750760AbWBZUQc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 15:16:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1QKGSDZ010377
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Feb 2006 12:16:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1QKGQ5d022986;
	Sun, 26 Feb 2006 12:16:27 -0800
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060226103604.2d97696c.akpm@osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16791>



On Sun, 26 Feb 2006, Andrew Morton wrote:
> 
> Thanks.  But it defaults to nowarn.  Nobody will turn it on and nothing
> improves.

Few enough people run "git-apply" on its own. Most people (certainly me) 
end up using it through some email-applicator script or other. So the plan 
was that the --whitespace=warn/error flag would go there, and that 
git-apply by default would work more like "patch".

But hey, I have no strong preferences, and it's easy enough to make the 
default be warn (and add a "--whitespace=ok" flag to turn it off).

Personally, I don't mind whitespace that much. In particular, I _suspect_ 
I often have empty lines like

	int i;
	
	i = 10;

where the "empty" line actually has the same indentation as the lines 
around it. Is that wrong? Perhaps.

		Linus
