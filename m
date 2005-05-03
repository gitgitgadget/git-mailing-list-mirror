From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Careful object writing..
Date: Tue, 3 May 2005 13:11:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505031306310.26698@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org>
 <20050503200034.GA16104@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 22:04:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT3cB-0004Dj-4c
	for gcvg-git@gmane.org; Tue, 03 May 2005 22:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVECUJv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 16:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVECUJv
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 16:09:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:14991 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261657AbVECUJt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 16:09:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j43K9ks4014740
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 May 2005 13:09:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j43K9jFg013120;
	Tue, 3 May 2005 13:09:46 -0700
To: Jan Harkes <jaharkes@cs.cmu.edu>
In-Reply-To: <20050503200034.GA16104@delft.aura.cs.cmu.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 3 May 2005, Jan Harkes wrote:
> 
> I tried to pull in the latest version of your tree, but it doesn't look
> like this commit has propagated to rsync.kernel.org yet. Hopefully you
> will accept a small patch (should be < 5 lines) that makes git work
> nicely when Coda complains about the cross-directory hardlink without
> affecting the reliability of using link/unlink on normal filesystems.

What is it that coda wants to do, and is there some portable way to get 
there? 

Is it just that you want to stay within the directory? Or is it any link 
action that is nasty?

What makes resolving renames hard when the file contents are the same? 
Maybe Coda could just do a trivial resolve of that "conflict" too?

			Linus
