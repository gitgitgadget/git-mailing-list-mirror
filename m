From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Fri, 20 May 2005 16:25:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>
  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>  <1116611932.12975.22.camel@dhcp-188>
  <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org> 
 <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>  <1116615600.12975.33.camel@dhcp-188>
  <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com>
  <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>  <428E4D8C.3020606@zytor.com>
 <1116626652.12975.118.camel@dhcp-188>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 21 01:22:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZGoo-0003gj-5R
	for gcvg-git@gmane.org; Sat, 21 May 2005 01:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVETXXM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 19:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVETXXM
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 19:23:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:22225 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261437AbVETXXI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 19:23:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4KNN5jA002934
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 May 2005 16:23:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4KNN4Fl008265;
	Fri, 20 May 2005 16:23:04 -0700
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <1116626652.12975.118.camel@dhcp-188>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 21 May 2005, Kay Sievers wrote:
> 
> These scripts are just a quick hack, I just wanted to know how nice the
> stupid cvs file history can be converted to git-committs.

Ugh, indeed.

Is it a cvsps bug or what that causes you to have to re-order the patches?  
Or is it that you don't handle branches or something in CVS? The fact that
you also remove one of the tags "suppress ash-branch" in that same number
sequence that you had to fix up by re-ordering seems to imply that the
breakage has something to do with branching.

Does anybody have any suggestions for a nice and smallish CVS project that
has branches that I should look at?

		Linus
