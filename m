From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 12:34:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504231232260.2344@ppc970.osdl.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>          
 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>          
 <426A4669.7080500@ppp0.net>           <1114266083.3419.40.camel@localhost.localdomain>
           <426A5BFC.1020507@ppp0.net>          <1114266907.3419.43.camel@localhost.localdomain>
          <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
 <2646.10.10.10.24.1114278656.squirrel@linux1>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 21:27:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPQI7-0008Vm-60
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 21:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVDWTcb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 15:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVDWTca
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 15:32:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:8608 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261652AbVDWTc1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 15:32:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3NJWIs4030868
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Apr 2005 12:32:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3NJWEH2014687;
	Sat, 23 Apr 2005 12:32:17 -0700
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <2646.10.10.10.24.1114278656.squirrel@linux1>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 23 Apr 2005, Sean wrote:
> 
> Why not leave tags open to being signed or unsigned?

That is exactly what my proposal does, except I'd make the normal tags 
creation always sign.

But since _git_ won't care which is why I want the signature at the _end_, 
not "surrpunding" the thing, you could create a tag that just doesn't have 
the signature, and git will never even notice. The people who see the tag 
may say "hmm, why couldn't he be bothered to sign it", though.

		Linus

