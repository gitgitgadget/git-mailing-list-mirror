From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/9] archimport: first, make sure it still compiles
Date: Thu, 24 Nov 2005 10:54:10 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511241051170.13959@g5.osdl.org>
References: <20051112092336.GA16218@Muzzle> <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com>
 <20051124074605.GA4789@mail.yhbt.net> <20051124074739.GB4789@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	git list <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Nov 24 19:56:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfMEk-0001V2-NK
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 19:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbVKXSyY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 13:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVKXSyY
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 13:54:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2188 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751389AbVKXSyX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Nov 2005 13:54:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAOIsBnO030535
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 24 Nov 2005 10:54:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAOIsAU2007213;
	Thu, 24 Nov 2005 10:54:10 -0800
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051124074739.GB4789@mail.yhbt.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12711>



Eric,
 I don't know about Junio, but if I were him, I'd have preferred that all 
your patches had a

	archimport: ..

prefix in the subject line, not just the first one.

For example, if you just merge the patches as-is now, and then look at the 
end result with gitk (or any of the tools that show the shortlog format: 
just the first line of the commit), you get explanations like

	fix -t tmpdir switch

which is clearly _correct_, but it's much nicer if they show which area 
was implied, ie

	archimport: fix -t tmpdir switch

so that you can tell from the shortlog whether it was a "global" change, 
or somethign that affected a specific program.

Just a suggestion,

		Linus
