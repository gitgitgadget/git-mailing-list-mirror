From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Avoid wasting memory in git-rev-list
Date: Thu, 15 Sep 2005 15:07:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509151507150.26803@g5.osdl.org>
References: <Pine.LNX.4.58.0509151434470.26803@g5.osdl.org>
 <7v7jdiyop9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 00:08:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG1tP-0004xl-25
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 00:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965288AbVIOWHl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 18:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965287AbVIOWHl
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 18:07:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26529 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965288AbVIOWHk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 18:07:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8FM7WBo024064
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Sep 2005 15:07:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8FM7TQx027756;
	Thu, 15 Sep 2005 15:07:30 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jdiyop9.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8644>



On Thu, 15 Sep 2005, Junio C Hamano wrote:
>
> So using this I could also avoid wasting memory by the "are we
> already walking the commit reachable from our existing refs"
> check by doing something like this?

Yes. It's still ugly, but it's _simple_.

		Linus
