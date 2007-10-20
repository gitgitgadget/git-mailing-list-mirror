From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: gitk patch collection pull request
Date: Fri, 19 Oct 2007 21:51:27 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710192149020.3794@woody.linux-foundation.org>
References: <20071019052823.GI14735@spearce.org>
 <alpine.LFD.0.999.0710191227340.26902@woody.linux-foundation.org>
 <18201.34779.27836.531742@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Oct 20 06:51:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij6JU-0005Im-VX
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 06:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbXJTEvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 00:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbXJTEvl
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 00:51:41 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49251 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752129AbXJTEvk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Oct 2007 00:51:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9K4pSNK020524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 19 Oct 2007 21:51:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9K4pRNG003905;
	Fri, 19 Oct 2007 21:51:28 -0700
In-Reply-To: <18201.34779.27836.531742@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=-2.72 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61782>



On Sat, 20 Oct 2007, Paul Mackerras wrote:
> 
> Do you mean that when you have a file limit, the diff window should
> just show the diffs for those files, not any other files the commit
> might have modified?

Yes. The same way "git log -p" works by default.

With perhaps a checkbox to toggle the "--full-diff" behaviour.

> That would be easy enough to implement in gitk.

Well, the "--merged" case is slightly trickier, since git will figure out 
the pathnames on its own (it limits pathnames to the intersection of the 
names you give one the command line *and* the list of unmerged files, ie 
the "filter" becomes "git ls-files -u [pathspec]".

But goodie. I look forward to it ;)

		Linus
