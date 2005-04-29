From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 08:58:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504290854270.18901@ppc970.osdl.org>
References: <200504291544.IAA23584@emf.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: mpm@selenic.com, seanlkml@sympatico.ca,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 17:52:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRXmX-0005eR-S1
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 17:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbVD2P5H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 11:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbVD2P5H
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 11:57:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:23720 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262254AbVD2P4q (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 11:56:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3TFucs4010090
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Apr 2005 08:56:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3TFubd9020322;
	Fri, 29 Apr 2005 08:56:38 -0700
To: Tom Lord <lord@emf.net>
In-Reply-To: <200504291544.IAA23584@emf.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 29 Apr 2005, Tom Lord wrote:
> 
> On the other hand, you're asking people to sign whole trees and not just at
> first-import time but also for every change.

I don't agree.

Sure, the commit determins the whole tree end result, but if you want to 
sign the _tree_, you can do so: just tag the actual _tree_ object as "this 
tree has been verified to be bug-free and non-baby-seal-clubbing".

But that's not what people do with tags. They sign a _commit_ object. And
yes, the commit object points to the tree, but it also points to the whole
history of other commit objects (and thus all historical trees etc), and 
together with just common sense it is very obvious that what you're really 
signing is that "point in time".

If you want to clarify it, you can always just say so in the tag. Instead 
of saying "I tag this as something I have verified every byte of", you can 
say "this was what I released as xxx", or "this commit contains my change" 
or something.

> If I've changed five files, I should be signing a statement of:
> 
> 	1) my belief about the identity of the immediate ancestor tree
> 	2) a robust summary of my changes, sufficient to recreate my
> 	   new tree given a faithful copy of the ancestor

So _do_ exactly that. You can say that in the tag you're signing.

			Linus
