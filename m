From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git-commits mailing list feed.
Date: Sun, 24 Apr 2005 18:50:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504241846290.18901@ppc970.osdl.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>      
 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>      
 <426A4669.7080500@ppp0.net>       <1114266083.3419.40.camel@localhost.localdomain>
       <426A5BFC.1020507@ppp0.net>       <1114266907.3419.43.camel@localhost.localdomain>
       <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>      
 <20050423175422.GA7100@cip.informatik.uni-erlangen.de>      
 <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <2911.10.10.10.24.1114279589.squirrel@linux1>
 <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org>
 <Pine.LNX.4.62.0504250008370.14200@sheen.jakma.org> <426C4168.6030008@dwheeler.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Jakma <paul@clubi.ie>, Sean <seanlkml@sympatico.ca>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 03:44:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPsdn-0005m8-Ba
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 03:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbVDYBst (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 21:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbVDYBst
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 21:48:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:12933 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262422AbVDYBsp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 21:48:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3P1mJs4005370
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 24 Apr 2005 18:48:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3P1mGQn026504;
	Sun, 24 Apr 2005 18:48:17 -0700
To: "David A. Wheeler" <dwheeler@dwheeler.com>
In-Reply-To: <426C4168.6030008@dwheeler.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 24 Apr 2005, David A. Wheeler wrote:
> 
> It may be better to have them as simple detached signatures, which are
> completely separate files (see gpg --detached).
> Yeah, gpg currently implements detached signatures
> by repeating what gets signed, which is unfortunate,
> but the _idea_ is the right one.

Actually, if we do totally separate files, then the detached thing is ok, 
and we migth decide to not call the objects at all, since that seems to be 
unnecessarily complex.

Maybe we'll just have signed tags by doing exactly that: just a collection 
of detached signature files. The question becomes one of how to name such 
things in a distributed tree. That is the thing that using an object for 
them would have solved very naturally.

		Linus
