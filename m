From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add git-graft-ripple, a tool for permanently grafting
 history into a tree.
Date: Wed, 23 Nov 2005 09:07:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511230905570.13959@g5.osdl.org>
References: <11326926501602-git-send-email-ryan@michonline.com>
 <Pine.LNX.4.64.0511221652530.13959@g5.osdl.org> <20051123135150.GA16995@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 18:08:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eey5t-0002Hs-US
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 18:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVKWRHj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 12:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbVKWRHj
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 12:07:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932109AbVKWRHi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2005 12:07:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jANH7GnO029542
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 23 Nov 2005 09:07:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jANH7FlN012348;
	Wed, 23 Nov 2005 09:07:15 -0800
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20051123135150.GA16995@mythryan2.michonline.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12636>



On Wed, 23 Nov 2005, Ryan Anderson wrote:
> 
> I'm not entirely convinced this is a good idea, but there it is.

Well, quite frankly, I think the whole graft-rippling is just wrong (why 
do it? The grafts are fine, and after you've rippled, you'll never be able 
to merge with somebody who didn't) but if you do it, I think you should 
fix it up properly and have a resulting tree that is at least as good as 
the original.

		Linus
