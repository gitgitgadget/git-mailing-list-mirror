From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add git-graft-ripple, a tool for permanently grafting
 history into a tree.
Date: Tue, 22 Nov 2005 16:55:04 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511221652530.13959@g5.osdl.org>
References: <11326926501602-git-send-email-ryan@michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 01:56:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eeiv9-0003ep-3c
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 01:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbVKWAzP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 19:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbVKWAzP
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 19:55:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45013 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030288AbVKWAzN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 19:55:13 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAN0t6nO021855
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 22 Nov 2005 16:55:06 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAN0t4en006505;
	Tue, 22 Nov 2005 16:55:05 -0800
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <11326926501602-git-send-email-ryan@michonline.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12591>



On Tue, 22 Nov 2005, Ryan Anderson wrote:
>
> Enhancements over the original example:
> 
> 	o Each newly created commit A' references A, and (A^1)' (The first try
> 	referenced A^1 and (A^1)' but not A)
> 
> 	o Support for incrementally rewriting history is present.

How about the case of having commits that have pointers to other commits 
in the comments? 

For example, on the kernel do

	gitk 19842d67340e4a8f616552d344e97fc7452aa37a

and see how gitk highlights the SHA1's in the commit message and makes 
hyperlinks to the commits they point to..

		Linus
