From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Improve "git grep" flags handling
Date: Tue, 13 Sep 2005 13:39:26 -0400
Message-ID: <200509131739.j8DHdQL1010615@laptop11.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 13 19:41:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFEl2-0006Vj-2L
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 19:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbVIMRjo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 13:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVIMRjo
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 13:39:44 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:30347 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S964931AbVIMRjn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 13:39:43 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j8DHdQln029779
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 13 Sep 2005 13:39:26 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j8DHdQL1010615;
	Tue, 13 Sep 2005 13:39:26 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Mon, 12 Sep 2005 17:51:56 MST." <7v64t56b83.fsf_-_@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 13 Sep 2005 13:39:26 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8474>

Junio C Hamano <junkio@cox.net> wrote:

[...]

>  Thanks, Linus.  This is what will go into "master" tonight.
> 
>  git-grep.sh |   64 ++++++++++++++++++++++++++++++++++++++---------------------
>  1 files changed, 41 insertions(+), 23 deletions(-)
> 
> 6df4eef9b10c8de2b9bc3dc769f3a008a1200df7
> diff --git a/git-grep.sh b/git-grep.sh
> --- a/git-grep.sh
> +++ b/git-grep.sh
> @@ -1,25 +1,43 @@
>  #!/bin/sh

Shouldn't shebang go /bin/bash, as the script uses bash-isms now?
(For portability to non-enlightened systems the installation would have to
locate bash too... and/or mention this in the INSTALL file)

Or perhaps redo the mess in Perl or some such?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
