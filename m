From: Edgar Toernig <froese@gmx.de>
Subject: Re: gitweb wishlist
Date: Wed, 25 May 2005 00:39:17 +0200
Message-ID: <20050525003917.40700d19.froese@gmx.de>
References: <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org>
	<428E745C.30304@zytor.com>
	<Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
	<4292A08A.5050108@cobite.com>
	<Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
	<20050524161745.GA9537@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org>
	<20050524184612.GA23637@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505241212190.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 00:38:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dai2J-0000rW-2d
	for gcvg-git@gmane.org; Wed, 25 May 2005 00:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVEXWj3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 18:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVEXWj3
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 18:39:29 -0400
Received: from pop.gmx.net ([213.165.64.20]:59016 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261926AbVEXWjX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 18:39:23 -0400
Received: (qmail invoked by alias); 24 May 2005 22:39:21 -0000
Received: from p50903B0F.dip.t-dialin.net (EHLO dialup) [80.144.59.15]
  by mail.gmx.net (mp005) with SMTP; 25 May 2005 00:39:21 +0200
X-Authenticated: #271361
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505241212190.2307@ppc970.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> > 	- Some Shell escapes (I didn't looked into them yet)
> 
> Ok, I'll check it out. I didn't figure out what characters are 
> shell-expanded by "<<EOF" handling, and only did '$' because that showed 
> up in the syslinux archives.

Nothing is expanded when you quote the EOF-word:

cat <<"EOF"
`foo` $PATH
bar \
baz
EOF

gives:

`foo` $PATH
bar \
baz

Ciao, ET.
