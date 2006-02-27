From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Quick question: how to generate a patch?
Date: Mon, 27 Feb 2006 08:04:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602270801280.22647@g5.osdl.org>
References: <6d6a94c50602270657m453cc581p6ec290c20879de25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 17:09:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDkrc-0002Wc-Dy
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 17:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWB0QEl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 11:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWB0QEl
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 11:04:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6610 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751413AbWB0QEk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 11:04:40 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1RG4bDZ026121
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Feb 2006 08:04:38 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1RG4aQA027952;
	Mon, 27 Feb 2006 08:04:37 -0800
To: Aubrey <aubreylee@gmail.com>
In-Reply-To: <6d6a94c50602270657m453cc581p6ec290c20879de25@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16855>



On Mon, 27 Feb 2006, Aubrey wrote:
> 
> I'm a newbie of git. I have a question about how to generate a patch by git.
> I want to make a patch againt git repository HEAD. So in my local
> tree, I do the command:
> 
> git diff -p > my.patch

You don't need the "-p" - it's the default for "git diff".

> The file my.patch is generated. But the unchanged files information is
> also included in the patch file. It should be quiet.

It sounds like your index is not synchronized with your file contents. 
Have you done "touch" on files? Or edited them, and then edited them back?

If so, "git-update-index --refresh" will re-synchronize your index with 
whatever file contents you have.

			Linus
