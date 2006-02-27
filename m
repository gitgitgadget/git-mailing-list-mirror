From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Quick question: how to generate a patch?
Date: Mon, 27 Feb 2006 08:32:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602270830330.22647@g5.osdl.org>
References: <6d6a94c50602270657m453cc581p6ec290c20879de25@mail.gmail.com> 
 <Pine.LNX.4.64.0602270801280.22647@g5.osdl.org>
 <6d6a94c50602270818k5f82bb8ft68a19899db3db636@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 17:34:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDlIl-00033U-4L
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 17:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWB0Qcl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 11:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWB0Qcl
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 11:32:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64985 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751488AbWB0Qck (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 11:32:40 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1RGWcDZ027454
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Feb 2006 08:32:38 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1RGWa1F028934;
	Mon, 27 Feb 2006 08:32:37 -0800
To: Aubrey <aubreylee@gmail.com>
In-Reply-To: <6d6a94c50602270818k5f82bb8ft68a19899db3db636@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16859>



On Tue, 28 Feb 2006, Aubrey wrote:
>
> No, what I did was just "git clone" one repository to my local directory.
> And entered the local directory to modify one file I wanted.
> Then I run "git diff > my.patch". The "my.patch" was supposed to
> contain one file diff information. But it contained the all the files,
> including which were not changed.

It really should "just have worked". Can you show what the diff actually 
looked like, and your exact command history?

If it was something like

	git clone remote-repo localdir
	cd localdir
	vi somefile
	git diff

then you did everything right, and if it gives any diff other than your 
changes to "somefile", something is buggy. Need more info.

Does "git diff" and "git diff HEAD" give different results, btw?

		Linus
