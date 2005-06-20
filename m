From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 'git commit' duplicates parents?
Date: Sun, 19 Jun 2005 20:00:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506191958010.2268@ppc970.osdl.org>
References: <42B59CF7.3080509@pobox.com> <Pine.LNX.4.58.0506191921270.2268@ppc970.osdl.org>
 <Pine.LNX.4.58.0506191926530.2268@ppc970.osdl.org> <42B62C85.10701@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 04:52:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkCOZ-0001C9-FF
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 04:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVFTC6D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 22:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVFTC6D
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 22:58:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5344 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261408AbVFTC6B (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2005 22:58:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5K2vwjA028415
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 19 Jun 2005 19:57:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5K2vv2e005886;
	Sun, 19 Jun 2005 19:57:57 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42B62C85.10701@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 19 Jun 2005, Jeff Garzik wrote:
> 
> I simply assumed that the vanilla git scripts would clean up after 
> themselves :)

Hey, they definitely should. I've pushed out the fixes so far (just pushed
out the ".cmitmsg/.editmsg" cleanup).

Keep the complaints coming when something doesn't work the way it should.  
I'll continue to try to blame your incompetence as much as I humanly can,
but hey, some of it is occasionally mine too... ;(

		Linus
