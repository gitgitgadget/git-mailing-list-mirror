From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: minimum set of utils for git 'server'?
Date: Sun, 26 Mar 2006 10:16:57 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603261011140.15714@g5.osdl.org>
References: <Pine.LNX.4.64.0603261804180.5276@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 26 20:17:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNZnX-00030g-Q2
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 20:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWCZSRE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 13:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWCZSRE
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 13:17:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30152 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932104AbWCZSRC (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 13:17:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2QIGwDZ029548
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Mar 2006 10:16:58 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2QIGvAX013995;
	Sun, 26 Mar 2006 10:16:58 -0800
To: Paul Jakma <paul@clubi.ie>
In-Reply-To: <Pine.LNX.4.64.0603261804180.5276@sheen.jakma.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18052>



On Sun, 26 Mar 2006, Paul Jakma wrote:
> 
> What is the minimum set of git utilities required for a git 'server'?
> 
> 	git-receive-pack
> 	git-daemon
> 	git-init-db
> 	git-repack
> 	git-fsck-objects

At least git-upload-pack, git-pack-objects, git-rev-list and 
git-unpack-objects (which are all part of the object receive/send paths), 
and git-update-server-info if you do http.

> I have an old server, but it lacks recent python (for merge-recursive), so I'd
> like to ensure no one accidently tries to do actual merging locally. Only the
> bare minimum needed for a central git 'server' desired.

You should be able to just try it out. Start out with the above list, and 
see what complains...

		Linus
