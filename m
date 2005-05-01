From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Should git-prune-script warn about dircache?
Date: Sun, 1 May 2005 09:18:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505010916510.2296@ppc970.osdl.org>
References: <7vwtqjxlrv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 18:14:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSH4u-00070c-5R
	for gcvg-git@gmane.org; Sun, 01 May 2005 18:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVEAQT2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 12:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVEAQTE
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 12:19:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:5255 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261718AbVEAQQP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 12:16:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j41GG7s4010363
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 1 May 2005 09:16:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j41GG7qU020645;
	Sun, 1 May 2005 09:16:07 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtqjxlrv.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 1 May 2005, Junio C Hamano wrote:
> 
> Maybe a big warning in red ugly bold blinking typeface somewhere
> in the doc?

How about making git-prune-script first run "git-update-cache --refresh",
and checking the return value of it (this, of course, assumes that
git-update-cache --refresh would return non-zero if it can't refresh a
file, which is currently not true, but should be easily fixable).

		Linus
