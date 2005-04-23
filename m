From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 13:01:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504231300140.2344@ppc970.osdl.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <42674724.90005@ppp0.net>
 <20050422002922.GB6829@kroah.com> <426A4669.7080500@ppp0.net>
 <1114266083.3419.40.camel@localhost.localdomain> <426A5BFC.1020507@ppp0.net>
 <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
 <20050423175422.GA7100@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <20050423184613.GE20410@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 21:57:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPQk1-0002fX-KQ
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 21:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVDWUAl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 16:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVDWUAl
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 16:00:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:31908 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261755AbVDWUAS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 16:00:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3NK01s4032501
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Apr 2005 13:00:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3NK00hH015349;
	Sat, 23 Apr 2005 13:00:00 -0700
To: Jan Harkes <jaharkes@cs.cmu.edu>
In-Reply-To: <20050423184613.GE20410@delft.aura.cs.cmu.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 23 Apr 2005, Jan Harkes wrote:
> 
> It is a bit more messy, but it can be done with a detached signature.

Ok, this looks more like it.

Except:

> To sign,
>     gpg -ab unsigned_commit
>     cat unsigned_commit unsigned_commit.asc > signed_commit
> 
> To verify,
>     cat signed_commit | sed '/-----BEGIN PGP/Q' | gpg --verify signed_commit -

Except I think you'd need to searc for the "---BEGIN PGP" starting from
the end, rather than the beginning.

Anyway, that should be workable. I'll whip something up.

		Linus
