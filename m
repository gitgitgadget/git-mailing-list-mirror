From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: I want to release a "git-1.0"
Date: Tue, 31 May 2005 20:04:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
 <m1psv7bjb6.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 05:00:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdJSD-00044L-VZ
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 04:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVFADCR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 23:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVFADCQ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 23:02:16 -0400
Received: from fire.osdl.org ([65.172.181.4]:43756 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261248AbVFADCJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 23:02:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j51327jA031693
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 May 2005 20:02:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j51326FP030075;
	Tue, 31 May 2005 20:02:07 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1psv7bjb6.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 31 May 2005, Eric W. Biederman wrote:
> 
> I way behind the power curve on learning git at this point but
> one piece of the puzzle that CVS has that I don't believe git does
> are multiple people committing to the same repository, especially
> remotely.  I don't see that as a down side of git but it is a common
> way people CVS so it is worth documenting.

It's actually one thing git doesn't do per se.

You have to do a "git-pull-script" from the common repository side, 
there's no "git-push-script". Ugly.

Anyway, I wrote just a _very_ introductory thing in
Documentation/tutorial.txt, I'll try to update and expand on it later. It
basically has a really stupid example of "how to set up a new project".

		Linus
