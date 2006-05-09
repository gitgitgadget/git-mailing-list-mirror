From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-feed-mail-list.sh
Date: Mon, 8 May 2006 17:45:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605081742330.3718@g5.osdl.org>
References: <1146678513.20773.45.camel@pmac.infradead.org> 
 <7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net>  <1147131877.2694.37.camel@shinybook.infradead.org>
  <Pine.LNX.4.64.0605081715270.3718@g5.osdl.org> <1147134522.2694.45.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 02:46:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdGMa-0003h2-0y
	for gcvg-git@gmane.org; Tue, 09 May 2006 02:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWEIAqE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 20:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWEIAqE
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 20:46:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44260 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750926AbWEIAqD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 20:46:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k490jstH008601
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 May 2006 17:45:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k490jr3T026938;
	Mon, 8 May 2006 17:45:53 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1147134522.2694.45.camel@shinybook.infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19791>



On Tue, 9 May 2006, David Woodhouse wrote:
> 
> Anyone got any objections to switching the kernel git-commits-* lists to
> this format?

As long as the "commit <sha1>" id is there (and "--pretty=fuller" does 
have it), I'll be happy. At some point, the commit mailing list didn't 
actually mention the commit ID itself, just the tree/parent IDs.

The "fuller" format should be fine, if you care about committer. Otherwise 
just use the standard "--pretty", which drops committer info.

		Linus
