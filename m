From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 21:55:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505242153150.2307@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
 <20050524161745.GA9537@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org>
 <20050524184612.GA23637@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org>
 <20050524202846.GC25606@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505241410380.2307@ppc970.osdl.org> <20050524213102.GB19180@vrfy.org>
 <7vu0ksoxg4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 06:52:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Danrw-0000bN-IS
	for gcvg-git@gmane.org; Wed, 25 May 2005 06:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVEYExV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 00:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbVEYExV
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 00:53:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:2949 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262255AbVEYExS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 00:53:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4P4rDjA022001
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 21:53:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4P4rCRh004489;
	Tue, 24 May 2005 21:53:12 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0ksoxg4.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, Junio C Hamano wrote:
>
> I was browsing www.kernel.org/git and noticed that it shows
> only files that exist at the tip.  How do I get history of a
> file that does not exist anymore at the tip?

The only sane interface I can think of is to expose the subdirectory 
history and then pick from that. Otherwise you'd have to actually type in 
the name, which is a bit against the notion of a graphical browsing 
interface.

		Linus
