From: Paul Mackerras <paulus@samba.org>
Subject: Re: git-diff-tree rename detection bug
Date: Thu, 15 Sep 2005 12:23:35 +1000
Message-ID: <17192.56103.803096.526568@cargo.ozlabs.ibm.com>
References: <59a6e583050914094777c4fe96@mail.gmail.com>
	<7vwtljjzc3.fsf@assigned-by-dhcp.cox.net>
	<59a6e583050914114054b1564d@mail.gmail.com>
	<Pine.LNX.4.58.0509141321180.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Wayne Scott <wsc9tt@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 04:24:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFjPf-000508-2A
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 04:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbVIOCXo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 22:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbVIOCXo
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 22:23:44 -0400
Received: from ozlabs.org ([203.10.76.45]:63406 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030345AbVIOCXo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 22:23:44 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 0B8BE68270; Thu, 15 Sep 2005 12:23:43 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509141321180.26803@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8578>

Linus Torvalds writes:

> Damn, too bad valgrind doesn't work on ppc64, so I can't use it on my main 
> machine. It seems to be in development on ppc32, so maybe some day.

How about... today? :-)  My port of Valgrind-2.4.1 to ppc32 works
pretty well.  You can get it from:

http://www.valgrind.org/downloads/variants.html?pmk

I assume you're compiling git as 32-bit executables on your G5.  I
don't see any reason why the git binaries would need to be 64-bit.

Regards,
Paul.
