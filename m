From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Public Gitweb Hosting Service
Date: Wed, 20 Sep 2006 17:45:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609201743550.4388@g5.osdl.org>
References: <20060920004828.GI8259@pasky.or.cz> <Pine.LNX.4.64.0609192033050.4388@g5.osdl.org>
 <20060920105133.GL8259@pasky.or.cz> <Pine.LNX.4.64.0609200753370.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 02:45:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQChG-000342-I9
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 02:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWIUApo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 20:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWIUApn
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 20:45:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46280 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750870AbWIUApn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 20:45:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8L0jVnW018390
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Sep 2006 17:45:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8L0jTtn021743;
	Wed, 20 Sep 2006 17:45:30 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <Pine.LNX.4.64.0609200753370.4388@g5.osdl.org>
X-Spam-Status: No, hits=-0.996 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.151 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27441>



On Wed, 20 Sep 2006, Linus Torvalds wrote:
> 
> It's _definitely_ broken for me. But it looks like that may be a firefox 
> on ppc issue (even if other sites work fine), because I don't have the 
> same problem on my Mac Mini. Strange.
> 
> Maybe it's a "yum install" that upgraded firefox while it was running or 
> something.

Indeed, that seems to have been it. It all works for me now. Very strange 
firefox bug that only affected one site ;)

(kernel.org runs a much older gitweb, so it was possibly triggered by 
something that gitweb does in newer versions).

		Linus
