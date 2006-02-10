From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Ignore commits for which cvsps can't identify a branch
Date: Fri, 10 Feb 2006 15:25:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602101517290.19172@g5.osdl.org>
References: <200602102102.k1AL2Xkd010415@biesi.no-ip.org>
 <7vmzgyvrih.fsf@assigned-by-dhcp.cox.net> <43ED0D63.5090105@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 00:25:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7hdg-00058c-ED
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 00:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWBJXZQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 18:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWBJXZQ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 18:25:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47063 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932233AbWBJXZO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2006 18:25:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1ANP9DZ002231
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 10 Feb 2006 15:25:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1ANP94u009561;
	Fri, 10 Feb 2006 15:25:09 -0800
To: Christian Biesinger <cbiesinger@web.de>
In-Reply-To: <43ED0D63.5090105@web.de>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15898>



On Fri, 10 Feb 2006, Christian Biesinger wrote:
> 
> I have to admit that I can't actually tell you for sure, since I still get a
> failure later (I think it's because cvsps orders changesets wrongly).

Do you have a recent version of "cvsps"? The wrong ordering happened quite 
often with old cvsps versions. So make sure you absolutely have 2.1.

Also, David Mansfield may not be maintaining it horribly actively, but 
that's probably because it's purely a "minimal maintenance" project for 
him by now. He reacted in a very timely manner when we pointed out 
specific bugs, so if you can pinpoint the exact thing cvsps does wrong, I 
bet David will be more than happy to apply patches or perhaps even fix it 
himself and make a new version.

So while it's fine to work around cvsps problems inside "git cvsimport", 
it's even better if you could try to see if you can figure out why they 
happen in the first place. The source code wasn't all that unreadable from 
what I can remember.

		Linus
