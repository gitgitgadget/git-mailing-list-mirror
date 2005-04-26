From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Tue, 26 Apr 2005 14:07:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org>
References: <20050426004111.GI21897@waste.org> <200504260713.26020.mason@suse.com>
 <aec7e5c305042608095731d571@mail.gmail.com> <200504261138.46339.mason@suse.com>
 <aec7e5c305042609231a5d3f0@mail.gmail.com> <20050426135606.7b21a2e2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Magnus Damm <magnus.damm@gmail.com>, mason@suse.com,
	mike.taht@timesys.com, mpm@selenic.com,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 23:01:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQXAh-0007VA-Lo
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 23:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVDZVFu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 17:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVDZVFu
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 17:05:50 -0400
Received: from fire.osdl.org ([65.172.181.4]:6086 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261785AbVDZVFp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 17:05:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3QL5Cs4026475
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 14:05:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3QL59Cw008979;
	Tue, 26 Apr 2005 14:05:10 -0700
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050426135606.7b21a2e2.akpm@osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Apr 2005, Andrew Morton wrote:
> 
> Mounting as ext2 is a useful technique for determining whether the fs is
> getting in the way.

What's the preferred way to try to convert a root filesystem to a bigger
journal? Forcing "rootfstype=ext2" at boot and boot into single-user, and
then the appropriate magic tune2fs? Or what?

		Linus
