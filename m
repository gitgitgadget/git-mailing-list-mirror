From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Fri, 30 Sep 2005 14:13:33 -0400
Message-ID: <200509301813.j8UIDXr5015488@laptop11.inf.utfsm.cl>
References: <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 20:15:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELPOT-0004kM-CL
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 20:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbVI3SNy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 14:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVI3SNx
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 14:13:53 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:19089 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932559AbVI3SNu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2005 14:13:50 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j8UIDYQB006683
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Sep 2005 14:13:34 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id j8UIDXr5015488;
	Fri, 30 Sep 2005 14:13:33 -0400
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: Message from Jeff Garzik <jgarzik@pobox.com> 
   of "Fri, 30 Sep 2005 07:15:41 -0400." <433D1E5D.20303@pobox.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 30 Sep 2005 14:13:35 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9568>

Jeff Garzik <jgarzik@pobox.com> wrote:
> Thanks for all the comments.  I just updated the KHGtG with the
> feedback I received.  Go to
> 
> 	http://linux.yyz.us/git-howto.html
> 
> and click reload.  Continued criticism^H^H^Hcomments welcome!

- To know the current branch, "git branch" is enough (the one '*'-ed)
- rsync(1) a repository is dangerous, it might catch it in the middle of
  a update and give you an incomplete/messed up copy. Repeat rsync until no
  change, perhaps?
- I understand "git checkout -f" blows away any local changes, no questions
  asked. Not very nice to suggest that to a newbie...

Thanks for the docu!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
