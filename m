From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 22:16:15 +0200
Message-ID: <20050524201615.GB25606@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org> <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org> <20050524161745.GA9537@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org> <20050524184612.GA23637@cip.informatik.uni-erlangen.de> <429383D6.6010908@cobite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 22:16:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dafni-0007nh-Hi
	for gcvg-git@gmane.org; Tue, 24 May 2005 22:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVEXUQ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 16:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVEXUQ2
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 16:16:28 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:19359 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262003AbVEXUQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 16:16:25 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4OKGFS8000389
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 May 2005 20:16:16 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4OKGFVk000388;
	Tue, 24 May 2005 22:16:15 +0200 (CEST)
To: David Mansfield <david@cobite.com>
Mail-Followup-To: David Mansfield <david@cobite.com>,
	Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <429383D6.6010908@cobite.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> There is something strange about 'cvs import' I believe which causes 
> various bizarre things to happen to the first cvsps patchset.  I haven't 
> looked at mutt cvs yet, but this could be the cause.  If you see a lot 
> of version numbers 1.1.1.1 then this is indeed the problem.

yes, that is happening. But it should be fairly easy to fix that.
Because the second one says INITIAL->1.1 and the first says 1.1->1.1.1.1
a lot.

> I'll look at taking these patches upstream.  The 'MT' fix is already in 
> my cvs of cvsps, and the rest looks pretty good.

Good. :-)

> Do you know where I can get attribution information for these changes? 
> Are they all from you? (I'm not familiar with debian at all)

none of them is from me, they're all from Debian. Here are a few URLs
how to get the attribution:

http://packages.qa.debian.org/c/cvsps.html
	-> You can get the source files from there: DSC are
	metainformation, ORIG is your upstream version and DIFF are the
	debian changes against your upstream version as patch. There is
	also a Changelog in the diff for the package. You should find in
	there everything you need.

http://bugs.debian.org/cgi-bin/pkgreport.cgi?pkg=cvsps
	-> The bug tracking system of debian could also be of help.


	Thomas
