From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Make sure the diff machinery outputs "\ No newline ..."
 in english
Date: Mon, 5 Sep 2005 08:52:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509050849500.3568@evo.osdl.org>
References: <20050904181724.GA23525@c165.ib.student.liu.se>
 <7vd5nohdp3.fsf@assigned-by-dhcp.cox.net> <20050905060149.GB1875@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 17:53:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECJGn-0000BN-U1
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 17:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVIEPw1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 11:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVIEPw1
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 11:52:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16040 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932221AbVIEPw0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 11:52:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j85FqHBo016110
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Sep 2005 08:52:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j85FqE1Q015761;
	Mon, 5 Sep 2005 08:52:16 -0700
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20050905060149.GB1875@c165.ib.student.liu.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8098>



On Mon, 5 Sep 2005, Fredrik Kuivinen wrote:
> 
> After a quick look through the diff source I didn't find anything
> else. It's quite possible that I haved missed something though. Most
> of the translated messages are related to error reporting, which I
> guess might be nice to have in the user specified language.

Is it possible that we could integrate the "diff" algorithm into git, and 
get rid of the dependency on an external GNU diff? It would also make the 
portability problems go away (ie old diff's being broken).

It would also potentially speed up the normal built-in diff a lot, since
we wouldn't have to execute a whole other program to generate a diff, just
call a helper function the way we do for xdiff..

Unreasonable?

		Linus
