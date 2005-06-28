From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org and GIT tree rebuilding
Date: Tue, 28 Jun 2005 14:27:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506281424420.19755@ppc970.osdl.org>
References: <20050624.212009.92584730.davem@davemloft.net> <42BCE026.8050405@pobox.com>
 <Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org> <42BCF02B.5090706@pobox.com>
 <Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
 <Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org>
 <Pine.LNX.4.63.0506281351150.1667@localhost.localdomain>
 <Pine.LNX.4.58.0506281201510.19755@ppc970.osdl.org>
 <Pine.LNX.4.63.0506281655140.1667@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Chris Mason <mason@suse.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 23:22:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnNWP-0007q7-0d
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 23:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVF1V2T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 17:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVF1V2N
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 17:28:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50076 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261395AbVF1VZe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 17:25:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5SLPIjA019943
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Jun 2005 14:25:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5SLPDUS029105;
	Tue, 28 Jun 2005 14:25:16 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.63.0506281655140.1667@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 28 Jun 2005, Nicolas Pitre wrote:
> 
> OK.  New patch below.

Dammit, I wasted all that time doing it myself.

I just committed and pushed out my version. But mine also does sha1_file.c 
right, so that you can use a packed archive in .git/objects/pack. Yours 
has some other cleanups, so..

Can you double-check my version (it hasn't mirrored out yet, it seems, but 
it should be there soon).

> Probably a version signature would be a good thing too.

I did that too, same format as for the index file. Nothing checks it 
though.

		Linus
