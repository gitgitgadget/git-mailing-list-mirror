From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] add --no-check option to git-write-tree
Date: Fri, 8 Jul 2005 12:42:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507081238370.17536@g5.osdl.org>
References: <42CE577C.1070404@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 21:46:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqynC-0004Fi-4b
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 21:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbVGHTpD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 15:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbVGHTnG
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 15:43:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5004 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262787AbVGHTmE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 15:42:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j68Jg1jA013634
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 8 Jul 2005 12:42:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j68Jg0dS021232;
	Fri, 8 Jul 2005 12:42:01 -0700
To: Bryan Larsen <bryan.larsen@gmail.com>
In-Reply-To: <42CE577C.1070404@gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 8 Jul 2005, Bryan Larsen wrote:
>
> Add --no-check option to git-write-tree.

I like almost all of these patches (well, the ones relevant to core git,
I'll not speak for Pasky on cogito), although I'd actually prefer your
"index_fd()" info-only flag to work the other way around: make it a flag
to say whether to update the object directory or not (ie "0" means info
only, and "1" means the current "update object directory" - and name it
accordingly, of course).

However, your mailer - apparently

	User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)

is totally broken and does strange white-space corruption, so none of the 
patches would apply. 

So can you fix that up and re-send (and cc me on the git part)?

		Linus
