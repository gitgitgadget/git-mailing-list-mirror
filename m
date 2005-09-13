From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Improve "git grep" flags handling
Date: Tue, 13 Sep 2005 12:09:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509131203280.3351@g5.osdl.org>
References: <200509131739.j8DHdQL1010615@laptop11.inf.utfsm.cl>
 <7v8xy03ilk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 13 21:11:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFGA8-0007Qb-CV
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 21:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbVIMTJj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 15:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbVIMTJj
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 15:09:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27860 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965093AbVIMTJg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 15:09:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8DJ9QBo011072
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Sep 2005 12:09:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8DJ9PZu018544;
	Tue, 13 Sep 2005 12:09:25 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xy03ilk.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8479>



On Tue, 13 Sep 2005, Junio C Hamano wrote:
> 
> I heard somebody say the shell arrays actually came from Korn,
> so /bin/bash is a wrong thing to do if that is the case.

Me. 

There are differences in indexing the arrays between ksh and bash, but I
think the git-grep.sh style of usage should work on both bash and ksh.

[ goes off and tests ]

Indeed. I just tested the thing I sent out with "ksh git-grep.sh .." and 
it worked fine.

Using "zsh" the grep flags don't work, and "tcsh" obviously will never run
_any_ valid shell code ;)

		Linus
