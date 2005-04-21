From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Wed, 20 Apr 2005 22:14:51 -0700
Organization: OSDL
Message-ID: <20050420221451.36c98f62.rddunlap@osdl.org>
References: <20050420205633.GC19112@pasky.ji.cz>
	<20050420211919.GA20129@kroah.com>
	<20050420215117.GJ19112@pasky.ji.cz>
	<Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org>
	<20050420222815.GM19112@pasky.ji.cz>
	<Pine.LNX.4.58.0504201710500.2344@ppc970.osdl.org>
	<Pine.LNX.4.58.0504201809170.2344@ppc970.osdl.org>
	<20050421033526.GA9404@nevyn.them.org>
	<Pine.LNX.4.58.0504202056310.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: dan@debian.org, pasky@ucw.cz, greg@kroah.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 07:11:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOTxw-0002Tr-HO
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 07:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVDUFPK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 01:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVDUFPK
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 01:15:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:16851 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261220AbVDUFPB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 01:15:01 -0400
Received: from midway.verizon.net (wbar2.sea1-4-5-049-023.sea1.dsl-verizon.net [4.5.49.23])
	(authenticated bits=0)
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3L5Eus3010574
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 22:14:57 -0700
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504202056310.2344@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Apr 2005 21:00:44 -0700 (PDT) Linus Torvalds wrote:

| 
| 
| On Wed, 20 Apr 2005, Daniel Jacobowitz wrote:
| > 
| > My logic: it's a lot more intuitive to say "cg-log | less" to get
| > paginated output than it is to say "cg-log | cat" to get unpaginated
| > output.
| 
| I disagree.
| 
| There is _never_ any valid situation where you do "cg-log" with 
| unpaginated output to a tty.
| 
| In _any_ real system you'll be getting thousands of lines of output. 
| Possibly millions. unpaginated? What the hell are you talking about?

Who in the world would look at thousands or millions of lines on a
tty using a pager?

| And as I pointed out, if the output is not a tty, then both less and more
| automatically turn into cat, so there's no difference. This change _only_
| triggers for a tty, and I dare you to show a single relevant project where 
| it's ok to scroll thousands of lines.
| 
| Even git-pasky, which is just a two-week-old project right now outputs 
| 4338 lines of output to "git log". 
| 
| Unpaginated? You must be kidding.
| 
| (But if you are _that_ fast a reader, then hey, use "PAGER=cat", and 
| you'll find yourself happy).

---
~Randy
