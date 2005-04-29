From: Tom Lord <lord@emf.net>
Subject: Re: Val Henson's critique of hash-based content storage systems
Date: Fri, 29 Apr 2005 12:52:43 -0700 (PDT)
Message-ID: <200504291952.MAA27541@emf.net>
References: <Pine.LNX.4.58.0504291221250.18901@ppc970.osdl.org>
Cc: robj@unrealities.com
X-From: git-owner@vger.kernel.org Fri Apr 29 21:47:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRbS7-0002hJ-2r
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 21:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbVD2Twq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 15:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbVD2Twq
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 15:52:46 -0400
Received: from emf.emf.net ([205.149.0.19]:55049 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S262915AbVD2Two (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 15:52:44 -0400
Received: (from lord@localhost) by emf.net (K/K) id MAA27541; Fri, 29 Apr 2005 12:52:43 -0700 (PDT)
To: git@vger.kernel.org
In-reply-to: <Pine.LNX.4.58.0504291221250.18901@ppc970.osdl.org> (message from Linus Torvalds on Fri, 29 Apr 2005 12:45:07 -0700 (PDT))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



I wouldn't expect outright successful attacks like forged replacements
for arbitrary files.

I would expect someone to have on hand a small number of blobs that are
different but have different hashes and, eventually, to drop said files
into a blob-based infrastructure to wreak havoc.

So: a way to locally mark a given checksum as "controversial" seems 
prudent, to me (hence, support for such in my blob-db code/spec).

-t
