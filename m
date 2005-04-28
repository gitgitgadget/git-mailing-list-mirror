From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: I'm missing isofs.h
Date: Thu, 28 Apr 2005 07:42:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504280740450.18901@ppc970.osdl.org>
References: <20050426214338.32e9ac27.akpm@osdl.org> <20050427235115.GN22956@pasky.ji.cz>
 <Pine.LNX.4.58.0504271708550.18901@ppc970.osdl.org> <20050428003246.GV22956@pasky.ji.cz>
 <7vhdhra2sg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Andrew Morton <akpm@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 16:36:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRA77-0005LU-IU
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 16:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVD1Ok6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 10:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVD1Ok6
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 10:40:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:56031 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262081AbVD1Okv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 10:40:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SEebs4007460
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 07:40:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SEeaOr020397;
	Thu, 28 Apr 2005 07:40:36 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhdhra2sg.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 27 Apr 2005, Junio C Hamano wrote:
> 
> Linus & Andrew, is the above (second) format acceptable for the
> kernel work?

The only thing my stuff needs is that it's "-p1" format, but I don't care 
if the prefix is the sha1 tree-name, or "a/" and "b/" or anything else (I 
think the current thing that the built-in stuff defaults to is a bit 
strange. "k/" and "l/"? I understand "a/" and "b/", and I'd even get "x/" 
and "y/" or "old/" and "new/", but starting counting at "l" is strange ;)

		Linus
