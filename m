From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Trial git RPM's..
Date: Mon, 11 Jul 2005 16:11:11 -0400
Message-ID: <200507112011.j6BKBBwx011503@laptop11.inf.utfsm.cl>
References: <torvalds@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 02:12:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds8Np-0001UU-AH
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 02:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbVGLAIv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 20:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbVGKULq
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 16:11:46 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:12736 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262558AbVGKULi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 16:11:38 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j6BKBCkC015386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Jul 2005 16:11:17 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j6BKBBwx011503;
	Mon, 11 Jul 2005 16:11:11 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: Message from Linus Torvalds <torvalds@osdl.org> 
   of "Mon, 11 Jul 2005 10:06:06 MST." <Pine.LNX.4.58.0507110958400.17536@g5.osdl.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 11 Jul 2005 16:11:17 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> On Mon, 11 Jul 2005, Eric W. Biederman wrote:
> > A couple of pieces.  The dist target has assumes git-tar-tree is in the
> > path.  Making it so you have to have git installed to build the rpm.

> Yes. Maybe we could relax that requirement by using "./git-tar-tree" or 
> something? That still requires that you have _built_ git to do the rpm, 
> but at least you won't have had to install it.

I don't see a problem here. Sure, you need git to build git, so place it in
Build-requires: Need to install the binary to build the next from source,
that's all. Just like gcc ;-)

[...]

> > The man pages are not built. The build dependencies do not call out
> > the tools necessary to build the man pages.

> Most people don't have asciidoc, and I'm not sure we want to require it. 
> Maybe we could have a separate "make man-rpm" target for that?

Would have to be a requirement for building anyway. There is a (not really
nice) SRPM at <http://www.pvv.ntnu.no/~terjeros/rpms/asciidoc/>. Will see
to clean it up.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
