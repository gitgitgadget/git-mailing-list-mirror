From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [0/5] Parsers for git objects, porting some programs
Date: Mon, 18 Apr 2005 11:34:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504181126480.15725@ppc970.osdl.org>
References: <Pine.LNX.4.21.0504172229240.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 20:29:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNazF-0001QN-OE
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 20:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVDRScp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 14:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVDRScp
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 14:32:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:38597 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262143AbVDRSco (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 14:32:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3IIWcs4016330
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Apr 2005 11:32:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3IIWbTH027990;
	Mon, 18 Apr 2005 11:32:38 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504172229240.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Daniel Barkalow wrote:
>
> This series introduces common parsers for objects, and ports the programs
> that currently use revision.h to them.
> 
>  1: the header files
>  2: the implementations
>  3: port rev-tree
>  4: port fsck-cache
>  5: port merge-base

Ok, having now looked at the code, I don't have any objections at all. 
Could you clarify the "fsck" issue about reading the same object twice? 
When does that happen?

		Linus
