From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: checkout-cache -f: a better way?
Date: Fri, 20 May 2005 18:44:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505201841550.2206@ppc970.osdl.org>
References: <428E5102.60003@pobox.com> <7vacmpsetb.fsf@assigned-by-dhcp.cox.net>
 <428E73B9.1080907@pobox.com> <7vvf5dqxfq.fsf@assigned-by-dhcp.cox.net>
 <428E7994.1090402@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 21 03:42:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZIzf-0005qh-Iq
	for gcvg-git@gmane.org; Sat, 21 May 2005 03:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVEUBmg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 21:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVEUBmg
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 21:42:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:54500 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261629AbVEUBmc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 21:42:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4L1gPjA011180
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 May 2005 18:42:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4L1gO9A013099;
	Fri, 20 May 2005 18:42:24 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <428E7994.1090402@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 20 May 2005, Jeff Garzik wrote:
>
> Yep, thanks.  Script does seem faster now. 

Yeah. They "seem faster".

> real    0m7.069s

to

> real    0m0.389s

That's what, 20 times faster? 

More, actually, I suspect, since the "-m" version is not only faster, but
it doesn't do much IO, so you'll not have tons of dirty pages/inodes etc
afterwards.

		Linus
