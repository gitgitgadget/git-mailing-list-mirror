From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-pull-script hates me
Date: Wed, 6 Jul 2005 13:58:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507061357130.4675@g5.osdl.org>
References: <20050706203139.GA19198@kroah.com> <Pine.LNX.4.58.0507061335100.4159@g5.osdl.org>
 <20050706204627.GA19481@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 06 23:07:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqH77-00049Q-FR
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 23:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVGFVGR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 17:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbVGFVCJ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 17:02:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28617 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262509AbVGFU6c (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2005 16:58:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j66KwKjA030915
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 6 Jul 2005 13:58:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j66KwJgs022775;
	Wed, 6 Jul 2005 13:58:20 -0700
To: Greg KH <greg@kroah.com>
In-Reply-To: <20050706204627.GA19481@kroah.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 6 Jul 2005, Greg KH wrote:
> 
> Ok, below is a patch for this.  It works, but then errors out with:
> 	bash: git-upload-pack: command not found
> 	fatal: unexpected EOF
> 
> So I'm guessing that I have to convince the server owner to update their
> version of git too?

The easiest way is to just build git on the other end yourself, and make
sure you have

	PATH=~/bin:$PATH

in your .bashrc. That way you're not at the mercy of the sysadmin on the 
other side.

		Linus
