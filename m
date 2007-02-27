From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Trivia: When did git self-host?
Date: Mon, 26 Feb 2007 17:58:57 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702261722310.12485@woody.linux-foundation.org>
References: <3c6c07c20702261551u55ec2ea7mde4075b1c929cf87@mail.gmail.com>
 <Pine.LNX.4.64.0702261650120.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mike Coleman <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 02:58:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLrc6-0002zN-Ad
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 02:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbXB0B6o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 20:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbXB0B6o
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 20:58:44 -0500
Received: from smtp.osdl.org ([65.172.181.24]:42918 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065AbXB0B6n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 20:58:43 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1R1wehB015643
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 26 Feb 2007 17:58:41 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1R1weYf005584;
	Mon, 26 Feb 2007 17:58:40 -0800
In-Reply-To: <Pine.LNX.4.64.0702261650120.12485@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.437 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40690>



On Mon, 26 Feb 2007, Linus Torvalds wrote:
> 
> The first commit was already self-hosted. It was done manually (write-tree 
> etc by hand), but yes, the first commit really is:
> 
> 	Thu Apr 7 15:13:13 2005 -0700
> 
> and the second one (add copyright notices) was done a few minutes later.
> 
> So git was self-hosting since April 7, 2005.
> 
> Now, exactly when I started git development (ie how long it took before it 
> got to that self-hosting stage), I can't remember. I'd say about two 
> weeks, probably.

Actually, it must have been less than that.

The first version of git was just ~1300 lines of code, and I have reason 
to believe that I started it at or around April 3rd. The reason: I made 
the last BK release on that day, and I also remember aiming for having 
something usable in two weeks. 

And hosting git itself was not that important for me - hosting the kernel 
was. And the first kernel commit was April 16 (with the first merges being 
a few days later). Which meshes with my "two week goal" recollection.

Not that I'd normally be entirely sure I hit any time goals I set, but I 
*am* pretty sure that I decided that in order to be effective, I didn't 
want to do kernel development at the same time as git development, so the 
"April 3" date of the 2.6.12-rc2 release is fairly significant.

			Linus
