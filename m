From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Problem cloning Linus' tree via http
Date: Tue, 17 Apr 2007 08:57:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704170855470.5473@woody.linux-foundation.org>
References: <18A49CF3586FC14290887ECC63C9141F0104D04B@exchange2003.dspace.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Gerald Ruescher <GRuescher@dspace.de>
X-From: git-owner@vger.kernel.org Tue Apr 17 17:57:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdq3o-0007SU-M4
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 17:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031102AbXDQP5Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 11:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031103AbXDQP5Z
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 11:57:25 -0400
Received: from smtp.osdl.org ([65.172.181.24]:52718 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031102AbXDQP5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 11:57:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3HFvITW007110
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Apr 2007 08:57:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3HFvHWV000611;
	Tue, 17 Apr 2007 08:57:18 -0700
In-Reply-To: <18A49CF3586FC14290887ECC63C9141F0104D04B@exchange2003.dspace.de>
X-Spam-Status: No, hits=-0.465 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44788>



On Tue, 17 Apr 2007, Gerald Ruescher wrote:
> 
> stupid newbie question: 

No, I think it's just a "http is stupid", not the newbie.

> I'm trying to clone Linus' kernel tree using git 1.5.1.
> Since I'm behind a firewall which blocks the git port I use: 
> 
>    git clone http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 

I prune and pack my refs, and I don't think the stupid http-protocol ever 
got support for packed refs. It should be easy to do, but somebody needs 
to do it. It won't be me. I'm not a huge fan of the http protocol ;^p

		Linus
