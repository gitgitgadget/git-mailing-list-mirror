From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Pushing a single tag (ref + object)?
Date: Wed, 19 Oct 2005 09:39:05 -0300
Message-ID: <200510191239.j9JCd5nQ018754@laptop11.inf.utfsm.cl>
References: <martin.langhoff@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 14:39:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESDE1-0002BF-Bw
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 14:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbVJSMjN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 08:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVJSMjN
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 08:39:13 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:59619 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750886AbVJSMjL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2005 08:39:11 -0400
Received: from laptop11.inf.utfsm.cl (ip-90.inf.utfsm.cl [200.1.19.90] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j9JCd6Mb002747
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Oct 2005 09:39:06 -0300
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id j9JCd5nQ018754;
	Wed, 19 Oct 2005 09:39:06 -0300
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: Message from Martin Langhoff <martin.langhoff@gmail.com> 
   of "Wed, 19 Oct 2005 19:05:32 +1300." <46a038f90510182305j1fa2c4bh6d2b36c2fdd058ce@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 19 Oct 2005 09:39:06 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10287>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> While we are using a repo which holds all our branches
> (dev/test/prod), locally we have a group of developers that checkout
> one repo-per-branch, working on it with a
> cg-clone/cg-update/cg-commit/cg-push workcycle. So far it's working
> great.
> 
> Now, I am at a loss on how to push a _tag_ object+ref to the repo,
> without doing a git-push --all, which I naturally don't want to do. I
> managed to push the object itself, doing
> 
>     git-push repository tagrefname
> 
> But that ddn't create the ref on the repo. So I had to do
> 
>     scp .git/refs/tags/refname repostory/refs/tags/

I've done:

     git push repository refs/tags/refname
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
