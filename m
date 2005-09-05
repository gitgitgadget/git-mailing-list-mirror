From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Mon, 5 Sep 2005 07:41:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509050738340.3504@evo.osdl.org>
References: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Tim Ottinger <tottinge@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 16:41:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECIAC-0008RH-5d
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 16:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbVIEOlc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 10:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVIEOlc
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 10:41:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4507 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751231AbVIEOlc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 10:41:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j85EfFBo011366
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Sep 2005 07:41:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j85EfBId012924;
	Mon, 5 Sep 2005 07:41:13 -0700
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8092>



On Sun, 4 Sep 2005, Horst von Brand wrote:
> > I had the same opinion.  The counter-argument people raised when
> > this topic came up on the list was that it would help grepping
> > in the source tree.
> 
> Grepping for what?

Grepping for strings.

For example, when renaming a binary, the sane way to check that you fixed 
all users right now is

	grep old-binary-name *.c *.h *-scripts

and you catch all users.

In contrast, "grep *" will catch totally uninteresting patterns like 
object files etc.

I personally find that very useful, and I don't see _any_ point to naming 
by what _kind_ of interpreter you use. Why would _anybody_ care whether 
something is written in perl vs shell? There's no reason to name things by 
the interpreter.

		Kubys
