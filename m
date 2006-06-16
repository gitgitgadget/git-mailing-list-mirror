From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Running parse cvs
Date: Fri, 16 Jun 2006 12:24:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606161220360.5498@g5.osdl.org>
References: <9e4733910606161147m403a3f36r6657bd7b620958f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>, Keith Packard <keithp@keithp.com>
X-From: git-owner@vger.kernel.org Fri Jun 16 21:24:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrJvX-0004ge-5y
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 21:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWFPTYQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 15:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWFPTYQ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 15:24:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4765 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751403AbWFPTYP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 15:24:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5GJO8gt021815
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Jun 2006 12:24:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5GJO7UP027429;
	Fri, 16 Jun 2006 12:24:07 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606161147m403a3f36r6657bd7b620958f3@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21966>



On Fri, 16 Jun 2006, Jon Smirl wrote:
>
> I am running the latest parsecvs from your git tree. I am hitting a quick gpf.

If it's really quick, run it under valgrind. It will slow down things 
enormously, but if it happens early on, you won't care, and it will 
generally give a much better reason for why the problem happened than the 
glibc malloc debugger will.

Ie just

	valgrind --tool=memcheck parsecvs ..

should do it.

Valgrind is da bomb.

		Linus
