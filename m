From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] rev-list: add "--full-objects" flag.
Date: Mon, 11 Jul 2005 10:53:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507111045380.17536@g5.osdl.org>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org>
 <20050707144501.GG19781@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <20050707221443.GB7151@pasky.ji.cz>
 <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net>
 <7vfyuqfa6r.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071657140.25104@g5.osdl.org>
 <7vvf3mds9c.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071841010.25104@g5.osdl.org>
 <7vy88ica8e.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071928220.25104@g5.osdl.org>
 <m1pstrr8k1.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507101517370.17536@g5.osdl.org>
 <m1irzh74m0.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 20:07:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds2fQ-000665-Cf
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 20:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVGKSD1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 14:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVGKRyM
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 13:54:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65503 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261255AbVGKRxu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 13:53:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6BHrejA006033
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 10:53:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6BHrXZp020664;
	Mon, 11 Jul 2005 10:53:36 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1irzh74m0.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 11 Jul 2005, Eric W. Biederman wrote:
> 
> I'm having the worst time putting together a mental model of how git
> works, and the documentation is spotty enough that it hasn't been
> helpful.  So I am wading through the code.  It seems every time I turn
> a corner there is another rough spot.

Btw, I know I'm bad at writing docs, but what I _do_ enjoy doing is
answering reasonably specific technical questions, and maybe somebody else
can write docs by taking advantage of me that way.

I tried to write the tutorial in a way that it also tries to explain how
git works (not just a "do this", but a "you update the index file and then
write the result out as a tree object"), but it obviously covers a fairly
limited part of what git actually can do, and at the same time it doesn't
go into a lot of detail.

And part of that is not just my inability to write documentation, it's
also that I just have the wrong "view" of the project, ie I probably just
take a lot of things for granted and consider them obvious, even though
they aren't, and then I probably occasionally explain things that aren't
worth explaining, because either they _are_ obvious, or people just don't
care and they are irrelevant.

I'd love to see somebody write up more of a "this is how you use git" kind
of tutorial, _and_ on the other hand more of a low-level explanation of
the notion of an object store where objects refer to each other by their
SHA1 names, and how that is represented in the filesystem and/or in packs. 

Something with a few pictures would be great (ie screenshots of gitk, but
also something that tries to just visually show hot tags point to commits
that point to parents and trees, and trees pointing to other trees and
then blobs).

All things that I'm a complete idiot at, but that would help users 
visualize what the heck git is actually _doing_, so that they don't just 
parrot some magic command line that they don't understand, but can 
actually reason about what they are doing.

I think a lot of people do understand this, but yes, the docs are kind of 
lacking.

			Linus
