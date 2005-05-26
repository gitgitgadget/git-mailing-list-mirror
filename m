From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Test case portability fix.
Date: Wed, 25 May 2005 19:36:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505251935210.2307@ppc970.osdl.org>
References: <20050525111711.GA27492@vrfy.org> <Pine.LNX.4.58.0505251054110.2307@ppc970.osdl.org>
 <20050525183546.GA4241@vrfy.org> <7vzmujjdq4.fsf@assigned-by-dhcp.cox.net>
 <20050525222622.GA8552@vrfy.org> <Pine.LNX.4.58.0505251544250.2307@ppc970.osdl.org>
 <7v1x7uj4i3.fsf_-_@assigned-by-dhcp.cox.net> <7vr7fug2i4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 04:33:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db8B0-0006W1-IN
	for gcvg-git@gmane.org; Thu, 26 May 2005 04:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVEZCeW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 22:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVEZCeV
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 22:34:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:55245 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261153AbVEZCeS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 22:34:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4Q2YCjA016713
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 25 May 2005 19:34:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4Q2YBAK030257;
	Wed, 25 May 2005 19:34:12 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7fug2i4.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 25 May 2005, Junio C Hamano wrote:
>
> This is the remainder of testcase fix by Mark Allen to make them
> work on his Darwin box.  I was using "xargs -r" (GNU) where it
> was not needed, sed -ne '/^\(author\|committer\)/s|>.*|>|p'
> where some sed does not know what to do with '\|', and also
> "cmp - file" to compare standard input with a file, which his
> cmp does not support.
> 
> Author: Mark Allen <mrallen1@yahoo.com>
> Author-Date: 

Btw, do this as

	From: Mark Allen <mrallen1@yahoo.com>

at the top of the email body, and my patch-application scripts will
automatically do the right thing.

The Author-date thing you might as well drop for now..

		Linus
