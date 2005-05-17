From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/4] Tweak diff output further to make it a bit less
 distracting.
Date: Tue, 17 May 2005 16:32:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505171630130.18337@ppc970.osdl.org>
References: <7vvf5kqj9l.fsf@assigned-by-dhcp.cox.net> <20050516220559.GC8609@pasky.ji.cz>
 <7vsm0mn5s1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505161556260.18337@ppc970.osdl.org>
 <20050517070158.GA10031@pasky.ji.cz> <Pine.LNX.4.58.0505170812060.18337@ppc970.osdl.org>
 <7vu0l1fz6p.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505171227260.18337@ppc970.osdl.org>
 <7vsm0lqym3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 01:32:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYBWy-0000pq-EY
	for gcvg-git@gmane.org; Wed, 18 May 2005 01:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVEQXb2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 19:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVEQXb2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 19:31:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:3025 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261985AbVEQXa4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 19:30:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4HNUhU3011582
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 May 2005 16:30:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4HNUgFK030933;
	Tue, 17 May 2005 16:30:43 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsm0lqym3.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 17 May 2005, Junio C Hamano wrote:
> 
> Now, in the new diff format, if the rename is really a pure
> rename, then we would have:
> 
>      diff -git a/nitfol b/nitfol
>      rename old frotz
>      rename new nitfol
>      diff -git a/rezrov b/rezrov
>      --- a/rezrov
>      +++ b/rezrov
>      @@ ...
> 
> that is, nothing until the patch for the next file or EOF.  Is
> this acceptable?

I think that's exactly what we want. At least it does exactly the right 
thing for me, when I do '/^diff ' in less, with nice highlighting of the 
headers.

With people inevitably adding some nice coloration support in gitweb etc,
and it will be outstanding.

		Linus
