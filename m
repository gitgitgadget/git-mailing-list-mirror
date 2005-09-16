From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: git fsck messages - what to do about it?
Date: Fri, 16 Sep 2005 15:37:57 -0400
Message-ID: <200509161937.j8GJbv62018950@inti.inf.utfsm.cl>
References: <wd@denx.de>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 22:11:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGMWI-0005cb-IX
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 22:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161276AbVIPUJM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 16:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161278AbVIPUJM
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 16:09:12 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:61932 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1161276AbVIPUJL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 16:09:11 -0400
Received: from inti.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by inti.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j8GJbv62018950;
	Fri, 16 Sep 2005 15:37:58 -0400
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: Message from Wolfgang Denk <wd@denx.de> 
   of "Fri, 16 Sep 2005 12:11:38 +0200." <20050916101138.99906352682@atlas.denx.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8727>

Wolfgang Denk <wd@denx.de> wrote:
> When running git fsck I get some messages:
> 
> -> git-fsck-cache --unreachable $(cat .git/HEAD .git/refs/heads/*)
> unreachable commit 08cf4121ad704faa5ae7c7ae7b3dca4476ef2770
> unreachable tree 29a4c18afd958cc6cee938f0fe7fa59764418097

[...]

> I have to admit that I don't know what to do next...
> 
> a) I understand that these  messages  are  indications  of  problems,
>    right? What can I do to clean this up?

One of the nits I'd like to pick is that git-fsck does only check, not
(like its filesystem counterparts) fix the problems it finds.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
