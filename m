From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: command to show diff of a commit
Date: Thu, 22 Sep 2005 08:20:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509220820011.2553@g5.osdl.org>
References: <72499e3b05092202583f9a751d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 17:25:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EISsi-00033m-0r
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 17:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbVIVPVA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 11:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbVIVPVA
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 11:21:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44738 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030400AbVIVPU7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 11:20:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8MFKqBo031387
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Sep 2005 08:20:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8MFKpcx003711;
	Thu, 22 Sep 2005 08:20:51 -0700
To: Robert Watson <robert.oo.watson@gmail.com>
In-Reply-To: <72499e3b05092202583f9a751d@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9126>



On Thu, 22 Sep 2005, Robert Watson wrote:
> 
> I am wondering what is the best way to show the change introduced by a
> commit. In the other words, is there a better way to do this:
> 
> git-diff b163512d4eb36ee946908b682c7863658c5a8db4^
> b163512d4eb36ee946908b682c7863658c5a8db4

Oh, absolutely.

Do

	git-diff-tree -p --pretty b163512d4eb36ee946908b682c7863658c5a8db4

and you're done.

If you _just_ want the diff (and not the message), skip the "--pretty".

		Linus
