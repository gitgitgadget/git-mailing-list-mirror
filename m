From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Wed, 7 Feb 2007 15:02:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702071451030.8424@woody.linux-foundation.org>
References: <17866.20355.744025.133326@lisa.zopyra.com>
 <Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 00:03:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEvoY-0003G3-Jz
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 00:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161317AbXBGXC4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 18:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161457AbXBGXC4
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 18:02:56 -0500
Received: from smtp.osdl.org ([65.172.181.24]:43875 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161317AbXBGXCz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 18:02:55 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l17N2sdD023785
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 7 Feb 2007 15:02:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l17N2rFY030430;
	Wed, 7 Feb 2007 15:02:53 -0800
In-Reply-To: <Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.443 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.113__
X-MIMEDefang-Filter: osdl$Revision: 1.175 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38994>



On Wed, 7 Feb 2007, Linus Torvalds wrote:
> 
> Newer gits enable reflogs by default [...]

This, btw, is only true for non-bare ones. 

In particular, if you only _push_ to a repository, it won't have reflogs 
enabled by default, because pushing is a "bare git" action even if it 
actually has a working tree (because the push will ignore the working tree 
and enter the ".git" directory itself).

So even with new git, if you want to have reflogs enabled for shared 
repositories that people push to (as opposed to the individual *developer* 
repositories), you need to enable reflogs by hand (either in the git 
config file, or by just creating the empty log file).

		Linus
