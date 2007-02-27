From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Trivia: When did git self-host?
Date: Mon, 26 Feb 2007 16:54:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702261650120.12485@woody.linux-foundation.org>
References: <3c6c07c20702261551u55ec2ea7mde4075b1c929cf87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mike Coleman <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 01:54:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLqbP-00019q-VO
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 01:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbXB0Ax5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 19:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbXB0Ax5
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 19:53:57 -0500
Received: from smtp.osdl.org ([65.172.181.24]:41066 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965016AbXB0Ax4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 19:53:56 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1R0rshB013553
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 26 Feb 2007 16:53:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1R0rrcj004115;
	Mon, 26 Feb 2007 16:53:54 -0800
In-Reply-To: <3c6c07c20702261551u55ec2ea7mde4075b1c929cf87@mail.gmail.com>
X-Spam-Status: No, hits=-0.438 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40681>



On Mon, 26 Feb 2007, Mike Coleman wrote:
>
> Does anyone recall when git first self-hosted?  This doesn't seem to
> be present on the GitHistory page on the wiki, and I'm not finding it
> elsewhere.

The first commit was already self-hosted. It was done manually (write-tree 
etc by hand), but yes, the first commit really is:

	Thu Apr 7 15:13:13 2005 -0700

and the second one (add copyright notices) was done a few minutes later.

Later that same day I imported "sparse" into a git archive from BK (you 
can get the sparse archive, and see the initial commit:

	commit 3ece2ef7c0a3d5975f65aa09911e1944e4125c45
	Author:     Linus Torvalds <torvalds@home.transmeta.com>
	AuthorDate: Thu Mar 13 12:53:56 2003 -0700
	Commit:     Linus Torvalds <torvalds@ppc970.osdl.org>
	CommitDate: Thu Apr 7 20:59:14 2005 -0700

notice how the commit date is different from the author date - the 
author date was taken from the BK tree that I imported).

The third git commit is committing the changes to git to make that import 
possible ("Thu Apr 7 21:03:28 2005 -0700").

So git was self-hosting since April 7, 2005.

Now, exactly when I started git development (ie how long it took before it 
got to that self-hosting stage), I can't remember. I'd say about two 
weeks, probably.

		Linus
