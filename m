From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git 1.5.1-rc1 doesn't like empty files
Date: Mon, 19 Mar 2007 21:54:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703192148430.6730@woody.linux-foundation.org>
References: <1174361424.3143.42.camel@dv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 05:54:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTWMO-0006p4-Q3
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 05:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933993AbXCTEyK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 00:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933994AbXCTEyK
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 00:54:10 -0400
Received: from smtp.osdl.org ([65.172.181.24]:46270 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933993AbXCTEyI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 00:54:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2K4s2cD022877
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Mar 2007 21:54:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2K4s16W026042;
	Mon, 19 Mar 2007 20:54:02 -0800
In-Reply-To: <1174361424.3143.42.camel@dv>
X-Spam-Status: No, hits=-0.477 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42707>



On Mon, 19 Mar 2007, Pavel Roskin wrote:
> 
> I don't know where this problem appeared, but it present in the current
> git (1.5.1-rc1).  Empty files become invalid objects in the repository:

Hmm.. Not for me. Can you bisect when it started happening?

> This is Linux, Fedora Development, i386.

FC6, tested both i386 and x86-64.

I wonder if this is a zlib issue. Although I seem to have libz-1.2.3 on 
both machines, and that should be the most recent version. I don't see 
Fedora development having anything else..

		Linus
