From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: new gitk feature
Date: Thu, 27 Apr 2006 22:11:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604272209060.3701@g5.osdl.org>
References: <17487.21137.344427.173131@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0604260802050.3701@g5.osdl.org> <17489.22838.502099.575465@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 28 07:11:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZLGC-00035C-VG
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 07:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbWD1FLS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 01:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbWD1FLS
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 01:11:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50369 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965135AbWD1FLR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Apr 2006 01:11:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3S5BFtH018046
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 27 Apr 2006 22:11:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3S5BEnT025610;
	Thu, 27 Apr 2006 22:11:15 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17489.22838.502099.575465@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19266>



On Fri, 28 Apr 2006, Paul Mackerras wrote:
> Linus Torvalds writes:
> > Any possibility of something light that? I'd _love_ to be able to see the 
> > whole tree, but with things that touch certain files or things that are 
> > newer highlighted.
> 
> That should be quite doable.  How about I show the commits that are in
> the highlight view in bold?  That won't conflict with the existing
> yellow background for commits that match the find criteria.

Bold sounds good to me.

> > (Btw, the "revision information" is also cool things like "--unpacked". I 
> > actually use "gitk --unpacked" every once in a while, just because it's 
> > such a cool way to say "show me everything I've added since I packed the 
> > repo last).
> 
> OK, I didn't know about --unpacked. :)  I plan to add stuff to the
> view definition window to allow you to select commits to
> include/exclude by reachability from given commits (by head/tag/ID)
> and when I do I can add a way to say --unpacked too.

It's more of a gimmick, but I find myself using it occasionally just to 
decide whether it's time to repack. It falls out automatically - not 
because I thought I'd ever want it, but because the --unpacked semantics 
for git-rev-list are what incremental packing needed.

(Of course, sane people probably just do "git count-objects" to decide to 
repack).

		Linus
