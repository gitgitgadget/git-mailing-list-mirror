From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Last mile for 1.0
Date: Sun, 5 Jun 2005 23:44:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506052341330.1876@ppc970.osdl.org>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org> <7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506051658100.1876@ppc970.osdl.org>
 <20050606054356.GB3669@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0506052300350.1876@ppc970.osdl.org> <7vpsv0uh5d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 08:40:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfBGj-0006fE-0F
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 08:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVFFGnB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 02:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVFFGnB
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 02:43:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:35754 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261190AbVFFGmx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 02:42:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j566gmjA029309
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Jun 2005 23:42:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j566glIJ011285;
	Sun, 5 Jun 2005 23:42:47 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsv0uh5d.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 5 Jun 2005, Junio C Hamano wrote:
> >>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
> 
> LT> And the "git-merge-one-file-script" thing needs to be updated to keep the
> LT> tree updated as it merges things by hand, since it can't depend on the
> LT> git-checkout-cache fixing things up any more. Anybody?
> 
> I'd love to bite.  One problem I have been having for the last
> 30 minutes or so is that t1000 test (merge from h*ll) does not
> show that read-tree resolving even the trivial ones anymore, and
> I do not know if you want make it that the responsibility of
> git-merge-one-file-script, or if it is just an oversight.

It was just two really stupid bugs, both due to me trying to make the 
three different merge loops look a bit more like each other, and that had 
broken the three-way case in two different ways.

Should be fixed, as soon as the mirroring pushes out the last off-by-one 
fix.

			Linus
