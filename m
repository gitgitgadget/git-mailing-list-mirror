From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 11:33:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702271132130.12485@woody.linux-foundation.org>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
 <Pine.LNX.4.64.0702270830260.12485@woody.linux-foundation.org>
 <20070227190912.GA30080@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 27 20:33:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM84i-0004Sf-Mo
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 20:33:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbXB0TdV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 14:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbXB0TdV
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 14:33:21 -0500
Received: from smtp.osdl.org ([65.172.181.24]:48475 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044AbXB0TdU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 14:33:20 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1RJXHhB014790
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Feb 2007 11:33:18 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1RJXHVZ025999;
	Tue, 27 Feb 2007 11:33:17 -0800
In-Reply-To: <20070227190912.GA30080@thunk.org>
X-Spam-Status: No, hits=-0.435 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40772>



On Tue, 27 Feb 2007, Theodore Tso wrote:
> 
> Yeah, the problem was that in the git man pages I had read, and the
> git tutorials that I had read, I had never learned about the
> <tree>:<path> syntax of object identifiers.

It's there in git-rev-parse.txt (which explains all the SHA1 object 
"math"), but yeah, it's not exactly obvious, and all the examples tend to 
use just the "commit relationship" math, not the commit->tree->path rules.

		Linus
