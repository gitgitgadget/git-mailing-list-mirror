From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Fri, 20 May 2005 09:54:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>
References: <20050511012626.GL26384@pasky.ji.cz> <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 18:53:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZAj0-0006VO-3g
	for gcvg-git@gmane.org; Fri, 20 May 2005 18:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVETQwn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 12:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVETQwm
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 12:52:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:56532 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261496AbVETQwY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 12:52:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4KGqJU3000695
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 May 2005 09:52:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4KGqIrr020848;
	Fri, 20 May 2005 09:52:18 -0700
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 18 May 2005, Kay Sievers wrote:
> 
> I did this now. The top-link shows now the repository listing with a
> nice "last change" field. The default link points to an overview page
> which also list the tags.

In the summary page, could we get authorship information too? Right now it 
looks like

	recent commits

	15 minutes ago	[PATCH] Add tests for diff-tree
	31 minutes ago	diff-tree: use new base_name_compare() helper function
	34 minutes ago	Introduce "base_name_compare()" helper function 
	...

and wouldn't it be nice if it told you who had written these things, like

	recent commits

	15 minutes ago	Junio C Hamano	[PATCH] Add tests for diff-tree
	31 minutes ago	Linus Torvalds	diff-tree: use new base_name_compare() helper function
	34 minutes ago	Linus Torvalds	Introduce "base_name_compare()" helper function 
	...

(limit the name to the first 20 characters or something to make things 
line up).

If the lines get too long, you could changes "minutes" to "min", and maybe 
limit the name to the first 10 characters (or even first name, but there's 
a lot of David's around, while 10-12 characters tends to get enough of 
the last name to be reasonable unique).

		Linus
