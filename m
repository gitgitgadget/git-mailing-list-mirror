From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Wed, 7 Feb 2007 15:29:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702071526290.8424@woody.linux-foundation.org>
References: <17866.20355.744025.133326@lisa.zopyra.com>
 <Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
 <17866.23050.937572.192253@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 00:29:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEwET-0005NB-9R
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 00:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161490AbXBGX3m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 18:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161491AbXBGX3m
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 18:29:42 -0500
Received: from smtp.osdl.org ([65.172.181.24]:45255 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161490AbXBGX3m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 18:29:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l17NTfdD024680
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 7 Feb 2007 15:29:41 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l17NTeY4031089;
	Wed, 7 Feb 2007 15:29:40 -0800
In-Reply-To: <17866.23050.937572.192253@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.439 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.113__
X-MIMEDefang-Filter: osdl$Revision: 1.175 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38999>



On Wed, 7 Feb 2007, Bill Lear wrote:
> 
> Ah, I don't seem to have .git/logs at all.
> 
> We plan to upgrade to 1.5 when it's out, so I guess we'll just
> have to wait.

Even with the git you have, you can probably just do a

	git repo-config --global core.logallrefupdates true

and you'll have reflogs enabled for all of your repositories (well, at 
least the ones that share that home directory and thus ~/.gitconfig)

		Linus
