From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 12:44:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506301242470.14331@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506301025510.14331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 21:37:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do4qR-0003g9-Kn
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 21:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbVF3ToL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 15:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbVF3ToD
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 15:44:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34208 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263025AbVF3Tm6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 15:42:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5UJgmjA018595
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 30 Jun 2005 12:42:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5UJgldF027799;
	Thu, 30 Jun 2005 12:42:48 -0700
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0506301025510.14331@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 30 Jun 2005, Linus Torvalds wrote:
> 
> Anyway, please do give it a test. I think I'll use this to sync up to
> kernel.org

In fact, the most recent push was gone with a

	git-send-pack master.kernel.org:/pub/scm/linux/kernel/git/torvalds/git.git

so if the new commit ("Do ref matching on the sender side rather than on 
receiver") shows up after the mirrors have caught up, then this thing is 
officially in production use..

		Linus
