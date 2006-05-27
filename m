From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [SCRIPT] chomp: trim trailing whitespace
Date: Sat, 27 May 2006 09:13:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605270905190.5623@g5.osdl.org>
References: <4477B905.9090806@garzik.org> <46a038f90605270828u7842ea48hda07331388694db2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 27 18:13:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fk1Pr-0006BT-Qv
	for gcvg-git@gmane.org; Sat, 27 May 2006 18:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWE0QNX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 12:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWE0QNX
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 12:13:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:451 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964827AbWE0QNV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 12:13:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4RGD42g015210
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 27 May 2006 09:13:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4RGD354011397;
	Sat, 27 May 2006 09:13:04 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605270828u7842ea48hda07331388694db2@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20858>



On Sun, 28 May 2006, Martin Langhoff wrote:
>
> I love perl golf for this kind of stuff... but git-stripspace is part
> of git already. Even then, I tend to do it with perl -pi -e ''
> constructs ;-)

Well, git-stripspace actually does something slightly differently, in that 
it also removes extraneous all-whitespace lines from the beginning, the 
end, and the middle (in the middle, the rule is: two or more empty lines 
are collapsed into one).

Ie it's a total hack for parsing just commit messages (and it is in C, 
because I can personally write 25 lines of C in about a millionth of the 
time I can write 3 lines of perl).

		Linus
