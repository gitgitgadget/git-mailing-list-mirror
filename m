From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cannot install git RPM
Date: Tue, 9 Aug 2005 08:00:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508090758110.3258@g5.osdl.org>
References: <20050809104040.B9C61352B36@atlas.denx.de>
 <20050809110705.6B1FF352B36@atlas.denx.de> <42F8AE6E.2020808@anagramm.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wolfgang Denk <wd@denx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 17:03:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2VbI-000135-K1
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 17:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVHIPBE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 11:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbVHIPBD
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 11:01:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8909 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964815AbVHIPBB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2005 11:01:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j79F0ijA024316
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 Aug 2005 08:00:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j79F0hOq010089;
	Tue, 9 Aug 2005 08:00:43 -0700
To: Clemens Koller <clemens.koller@anagramm.de>
In-Reply-To: <42F8AE6E.2020808@anagramm.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.41__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 9 Aug 2005, Clemens Koller wrote:
> 
> Over here - using a non-standard ELDK/LFS mixture, git depends at least on:
>...
> diffstat (ftp://invisible-island.net/diffstat/diffstat-1.39.tgz)

Hmm.. This should not be true. Any "diffstat"s should be converted to use
"git-apply --stat" instead.

I don't find any diffstat users, so maybe you just remember it from "the 
old days", and didn't realize that it's not needed any more.

[ That said, anybody who wants to install git might as well install 
  diffstat, it's a useful program in general, and works on more than just 
  unified diffs ]

		Linus
