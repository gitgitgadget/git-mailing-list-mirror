From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [zooko@zooko.com: [Revctrl] colliding md5 hashes of human-meaningful
Date: Mon, 13 Jun 2005 14:39:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506131434260.8487@ppc970.osdl.org>
References: <20050613210318.18965.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 02:30:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhzKQ-000528-9u
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 02:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVFNAf0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 20:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVFMVjO
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 17:39:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49540 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261428AbVFMVhe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jun 2005 17:37:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5DLbTjA004151
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 13 Jun 2005 14:37:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5DLbSGs009829;
	Mon, 13 Jun 2005 14:37:28 -0700
To: linux@horizon.com
In-Reply-To: <20050613210318.18965.qmail@science.horizon.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 13 Jun 2005 linux@horizon.com wrote:
> 
> > But perhaps slightly impractical.
> 
> There are just few laws of physics it violates.

Yeah, yeah. You avoided a few laws of phsyics of your own.

For example, when you say

  "(With an n-bit hash and an automated way to make harmless changes
   to source files, I can generate 2^(n/2) variants of each and expect to
   get a match, even in the absence of a better attack.)"

you kind of ignore the fact that "n" here is 160, and so you're going to 
be searching for quite a few versions of each. Also, you have to compare 
the sha's of all of those 2**80 versions against each other which is a lot 
of work in itself.

Finally, you have to make sure that al the versions make sense, and that 
people will take them 100% unmodified. 

My plan was more interesting, I feel.

		Linus
