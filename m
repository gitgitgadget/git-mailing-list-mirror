From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 17:45:50 -0400
Message-ID: <200504292145.j3TLjoTC014157@laptop11.inf.utfsm.cl>
References: <lord@emf.net>
Cc: seanlkml@sympatico.ca, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 23:43:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRdG1-0007UN-6l
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 23:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbVD2Vrq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 17:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbVD2Vqn
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 17:46:43 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:21215 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262984AbVD2VqH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 17:46:07 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j3TLiEBA023399
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 Apr 2005 17:44:14 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j3TLjolt014160;
	Fri, 29 Apr 2005 17:45:50 -0400
Received: from laptop11.inf.utfsm.cl (vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.4/8.13.4/Submit) with ESMTP id j3TLjoTC014157;
	Fri, 29 Apr 2005 17:45:50 -0400
To: Tom Lord <lord@emf.net>
In-Reply-To: Message from Tom Lord <lord@emf.net> 
   of "Fri, 29 Apr 2005 12:28:41 MST." <200504291928.MAA27145@emf.net> 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 29 Apr 2005 17:44:14 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Tom Lord <lord@emf.net> said:
> Think of it this way:
> 
>   (a) Joe, the mainline maintainer, gets a trusted message containing
>       a diff.
> 
>   (b) Joe reads the diff, it makes great sense, he wants to merge.
> 
>   (c) Joe downloads a tree.  Supposedly that tree is the result of
>       applying this diff.   The tree, not the diff, is used for
>       merging.
> 
> You can see the logical whole there... now the practical one:
> 
> 
>    (d) Joe is repeating (a..c) at an unfathomably high rate.
>        At a low rate, he could be double-checking enough that
>        that the diff-vs-tree problem isn't that serious.  But
>        at the rate he operates, exploits appear all along the
>        patch-flow pipeline because so much stuff goes unchecked.
> 
>        Joe may be scan the changes he's merged before committing but,
>        if his rate is high, that scan *must*, out of biological and
>        physical necessity, be shallow.   Exploits can occur on the
>        submitter machine, in the communication channel, and on Joe's 
>        machine.   Social exploits can occur because of the separation
>        between a submitter saying "this is what I'm doing" vs. the reality
>        of what the submitter is doing.

Now pray tell how Joe signing one, two, three, or none of the things he is
juggling makes any difference here.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
