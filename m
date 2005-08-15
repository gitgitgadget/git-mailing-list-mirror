From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb - option to disable rename detection
Date: Mon, 15 Aug 2005 15:43:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508151542290.3553@g5.osdl.org>
References: <87d5ofoxvt.wl@mail2.atmark-techno.com> <Pine.LNX.4.58.0508151140050.3553@g5.osdl.org>
 <87br3zorjk.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 00:44:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4ng4-00055N-Uk
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 00:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVHOWna (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 18:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbVHOWna
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 18:43:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36048 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965024AbVHOWn3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2005 18:43:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7FMhQjA000916
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 Aug 2005 15:43:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7FMhQUQ018617;
	Mon, 15 Aug 2005 15:43:26 -0700
To: Yasushi SHOJI <yashi@atmark-techno.com>
In-Reply-To: <87br3zorjk.wl@mail2.atmark-techno.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 16 Aug 2005, Yasushi SHOJI wrote:
>
> > Instead of disabling it entirely, how about just having some limit on it?
> 
> ah, that's a good idea.  here is a quick and dirty patch.

This makes it somewhat more expensive - I was thinking about disabling it 
in git-diff-tree, since the rename logic already knows how many 
new/deleted files there are.

		Linus
