From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Garbage in .git directories???
Date: Mon, 19 Sep 2005 07:51:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509190747210.9106@g5.osdl.org>
References: <200509172141.31591.dtor_core@ameritech.net>
 <Pine.LNX.4.58.0509181009160.26803@g5.osdl.org> <200509181254.14646.dtor_core@ameritech.net>
 <200509182333.58227.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 16:54:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHN03-00065G-7R
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 16:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVISOwE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 10:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbVISOwE
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 10:52:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16033 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932448AbVISOwC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 10:52:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8JEpxBo012073
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Sep 2005 07:51:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8JEptRi029284;
	Mon, 19 Sep 2005 07:51:57 -0700
To: Dmitry Torokhov <dtor_core@ameritech.net>
In-Reply-To: <200509182333.58227.dtor_core@ameritech.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8872>



On Sun, 18 Sep 2005, Dmitry Torokhov wrote:
> 
> Couple more points - just using rsync to get the data (without using git)
> does not not produce that wierd directory, only got clone does.

Does a plain "git-init-db" in a newly created empty directory do the same?  
There was a bug (a long time ago)  that created garbage instead of the
template files, I think.

Also, is there something inside of the garbage subdirectory?

> Btw, after doing a pull from git repository git cone now produces the
> following:

Ignore that one, looks like a silly error. Unrelated.

		Linus
