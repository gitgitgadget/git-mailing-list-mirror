From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitk - ewww
Date: Sat, 3 Dec 2005 20:44:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512032040240.3099@g5.osdl.org>
References: <6CC092B0-101F-4D98-9761-B4E24A7CA35A@hawaga.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 04 05:47:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eillk-0004vX-Lz
	for gcvg-git@gmane.org; Sun, 04 Dec 2005 05:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVLDEqL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 23:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVLDEqL
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 23:46:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65414 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750709AbVLDEqK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Dec 2005 23:46:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jB44ilDZ003722
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 3 Dec 2005 20:44:48 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jB44ikta021658;
	Sat, 3 Dec 2005 20:44:46 -0800
To: Ben Clifford <benc@hawaga.org.uk>
In-Reply-To: <6CC092B0-101F-4D98-9761-B4E24A7CA35A@hawaga.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.128 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13175>



On Sun, 4 Dec 2005, Ben Clifford wrote:
> 
> Screen shot is at:
> http://www/hawaga.org.uk/ben/tech/gitk-eww-1.png

Yes. gitk doesn't look wonderful with octopus merges, the lines start 
crossing. Oh well. I think you have to live with it, it's done this for a 
long time.

What makes _me_ go "eww" in that screenshot is that tcl/tk doesn't do 
anti-aliased fonts, but maybe that's just me, and that's apparently 8.5 
has that fixed (at a horrible performance impact, I'm sure, but hey, one 
look at your screenshot and I'm saying "bring it on").

		Linus
